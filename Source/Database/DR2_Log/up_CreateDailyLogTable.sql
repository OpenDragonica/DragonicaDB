USE [DR2_Log]
GO
/****** Object:  StoredProcedure [dbo].[up_CreateDailyLogTable]    Script Date: 06/26/2009 22:17:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Object:  StoredProcedure [dbo].[up_CreateDailyLogTable]    Script Date: 06/26/2009 22:17:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_CreateDailyLogTable]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_CreateDailyLogTable]
GO

CREATE PROC [dbo].[up_CreateDailyLogTable]
/*
////////////////////////////////////////////////////////////////////////
//
// 프로시져명 : 일별 LOG 테이블 생성
// 작 성 자 : 김범준(tigerjune@barunsoninter.com)
// 작 성 일 : 2007-11-30
// N O T E : 매일 11:50 P.M. 에 SQL JOB에서 실행 예약.
// - ID, iValue6 추가(2008.12.19)
//
//	2009.06.26 : Eric Kim, Log table 두개로 분리
////////////////////////////////////////////////////////////////////////
*/ 
AS
SET nocount ON 
SET XACT_ABORT ON	

DECLARE @Daily VARCHAR(20)
DECLARE @SQL	 NVARCHAR(4000)
DECLARE @SQL_Params NVARCHAR(2000)

--내일 날짜이름 테이블
SET @Daily = ( SELECT CONVERT(CHAR(8), GETDATE()+1, 112) )

SET @SQL = N'
if not exists (select * from dbo.sysobjects where id = object_id(N''[dbo].[TB_'+@Daily+']''))
BEGIN
CREATE TABLE [dbo].[TB_'+@Daily+'] (
	[IDX] [int] IDENTITY(1,1) NOT NULL,
	[LogGUID] [uniqueidentifier] ,
	[LogType] [smallint] NOT NULL,
	[SubLogType] [smallint] NOT NULL,
	[MemberKey] [uniqueidentifier] NOT NULL,
	[CharacterKey] [uniqueidentifier] NOT NULL,
	[ID] [nvarchar](20) NULL,
	[Name] [nvarchar](200) NULL,
	[LogDate] [datetime] NOT NULL,
	[ChannelNo] [smallint] NOT NULL DEFAULT ((0)),
	[Job] [smallint] NULL DEFAULT ((0)),
	[Level] [smallint] NULL DEFAULT ((0)),
	[GroundNo] [int] NULL DEFAULT ((0)) )

CREATE CLUSTERED INDEX IX_C_TB_'+@Daily+'_LogDate ON [dbo].[TB_'+@Daily+'](LogDate);
CREATE INDEX IX_NC_TB_'+@Daily+'_LogType ON [dbo].[TB_'+@Daily+'](LogType);
CREATE INDEX IX_NC_TB_'+@Daily+'_ID ON [dbo].[TB_'+@Daily+'](ID);
CREATE INDEX IX_NC_TB_'+@Daily+'_Name ON [dbo].[TB_'+@Daily+'](Name);
END
'
EXEC sp_executesql @SQL

SET @SQL = N'
if not exists (select * from dbo.sysobjects where id = object_id(N''[dbo].[TB_'+@Daily+'_Sub]''))
BEGIN
CREATE TABLE [dbo].[TB_'+@Daily+'_Sub](
	[LogGuid] [uniqueidentifier] NOT NULL,
	[OrderType] [smallint] NOT NULL,
	[ActionType] [smallint] NOT NULL,
	[Message1] [nvarchar](200) NULL,
	[Message2] [nvarchar](200) NULL,
	[Message3] [nvarchar](200) NULL,
	[Message4] [nvarchar](200) NULL,
	[iValue1] [int] NOT NULL DEFAULT ((0)),
	[iValue2] [int] NOT NULL DEFAULT ((0)),
	[iValue3] [int] NOT NULL DEFAULT ((0)),
	[iValue4] [int] NOT NULL DEFAULT ((0)),
	[iValue5] [int] NOT NULL DEFAULT ((0)),
	[i64Value1] [bigint] NOT NULL DEFAULT ((0)),
	[i64Value2] [bigint] NOT NULL DEFAULT ((0)),
	[i64Value3] [bigint] NOT NULL DEFAULT ((0)),
	[i64Value4] [bigint] NOT NULL DEFAULT ((0)),
	[i64Value5] [bigint] NOT NULL DEFAULT ((0))
) ON [PRIMARY];
CREATE INDEX IX_NC_TB_'+@Daily+'_Message1 ON [dbo].[TB_'+@Daily+'_Sub](Message1);
CREATE INDEX IX_NC_TB_'+@Daily+'_iValue1 ON [dbo].[TB_'+@Daily+'_Sub](iValue1);
CREATE INDEX IX_NC_TB_'+@Daily+'_iValue2 ON [dbo].[TB_'+@Daily+'_Sub](iValue2);
END
'
EXEC sp_executesql @SQL

DECLARE @ProcName nvarchar(100)
SET @ProcName = N'[dbo].[UP_Log_'+@Daily+']'
if not exists (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(@ProcName))
BEGIN
	SET @SQL = N'
	CREATE PROC [dbo].[UP_Log_'+@Daily+']
		@DateTime DATETIME,
		@LogGuid UNIQUEIDENTIFIER,
		@LogType smallint,
		@SubLogType smallint,
		@MemberKey UNIQUEIDENTIFIER,
		@CharacterKey UNIQUEIDENTIFIER,
		@ID NVARCHAR(20),
		@Name NVARCHAR(20),
		@ChannelNo SMALLINT,
		@GroundNo	INT,
		@Job	SMALLINT,
		@Level	INT
	AS
	SET NOCOUNT ON
	SET XACT_ABORT ON

	INSERT INTO [dbo].[TB_'+@Daily+']
			   ([LogGUID] ,[LogType] ,[SubLogType] ,[MemberKey] ,[CharacterKey]
			   ,[ID] ,[Name] ,[LogDate] ,[ChannelNo] ,[Job]
			   ,[Level] ,[GroundNo])
		 VALUES
			   (@LogGuid, @LogType, @SubLogType, @MemberKey, @CharacterKey,
				@ID, @Name, @DateTime, @ChannelNo, @Job,
				@Level, @GroundNo)
	SELECT @@ERROR
	'
	EXEC sp_executesql @SQL
END

SET @ProcName = N'[dbo].[UP_Log_'+@Daily+'_Sub]'
if not exists (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(@ProcName))
BEGIN
	SET @SQL = N'
	CREATE PROC [dbo].[UP_Log_'+@Daily+'_Sub]
		@LogGuid UNIQUEIDENTIFIER,
		@OrderType smallint,
		@ActionType smallint,
		@iValue1 INT,
		@iValue2 INT,
		@iValue3 INT,
		@iValue4 INT,
		@iValue5 INT,
		@i64Value1 BIGINT,
		@i64Value2 BIGINT,
		@i64Value3 BIGINT,
		@i64Value4 BIGINT,
		@i64Value5 BIGINT,
		@Message1 NVARCHAR(200) = NULL,
		@Message2 NVARCHAR(200) = NULL,
		@Message3 NVARCHAR(200) = NULL,
		@Message4 NVARCHAR(200) = NULL
	AS
	SET NOCOUNT ON
	SET XACT_ABORT ON

	INSERT INTO [dbo].[TB_'+@Daily+'_Sub]
			   ([LogGuid] ,[OrderType] ,[ActionType] ,[Message1]  ,[Message2]
			   ,[Message3] ,[Message4] ,[iValue1] ,[iValue2] ,[iValue3]
			   ,[iValue4] ,[iValue5] ,[i64Value1] ,[i64Value2] ,[i64Value3]
			   ,[i64Value4], [i64Value5])
		 VALUES
			   ( @LogGuid, @OrderType, @ActionType, @Message1, @Message2,
			   @Message3, @Message4, @iValue1, @iValue2, @iValue3,
			   @iValue4, @iValue5, @i64Value1, @i64Value2, @i64Value3,
			   @i64Value4, @i64Value5)
	           
	SELECT @@ERROR
	'
	EXEC sp_executesql @SQL
END

-- Cleanup Old-date procedure
DECLARE @DelDay nvarchar(20)
DECLARE @Count smallint
SET @Count = -20
WHILE (@Count < -10)
BEGIN
	Set @DelDay = CONVERT(nvarchar(20), DATEADD(day, @Count, GetDate()), 112)
	SET @Count = @Count + 1
	
	SET @ProcName = N'[dbo].[UP_Log_'+@DelDay+']'
	if exists (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(@ProcName))
	BEGIN
		SET @SQL = N'DROP PROCEDURE ' + @ProcName
		EXEC sp_executesql @SQL
	END

	SET @ProcName = N'[dbo].[UP_Log_'+@DelDay+'_Sub]'
	if exists (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(@ProcName))
	BEGIN
		SET @SQL = N'DROP PROCEDURE ' + @ProcName
		EXEC sp_executesql @SQL
	END
END

