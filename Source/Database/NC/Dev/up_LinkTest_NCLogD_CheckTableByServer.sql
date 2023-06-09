USE [DR2_Log]
GO

IF EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.up_LinkTest_NCLogD_CheckTableByServer') AND [type] IN (N'P'))
BEGIN
	DROP PROCEDURE [dbo].[up_LinkTest_NCLogD_CheckTableByServer]
END

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[up_LinkTest_NCLogD_CheckTableByServer]
/*
////////////////////////////////////////////////////////////////////////
//
// 프로시져명 : [NCLogD 연동 테스트 테이블] 일별 LOG 테이블 생성
// 작 성 자 : 김용민(yonmy@barunsoninter.com)
// 작 성 일 : 2009-02-17
// 최종수정자 : 
// 수 정 일 : 
// 파 일 명 :
// 
//
////////////////////////////////////////////////////////////////////////
*/ 
AS
SET nocount ON 
SET XACT_ABORT ON	

DECLARE @Daily VARCHAR(20)
DECLARE @SQL	 NVARCHAR(4000)
DECLARE @SQL_Params NVARCHAR(2000)
SET @Daily = ( SELECT CONVERT(CHAR(8), GETDATE(), 112) )

SET @SQL = N'
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N''[dbo].[TB_NCLOGD_'+@Daily+']''))
BEGIN
CREATE TABLE [dbo].[TB_NCLOGD_'+@Daily+'](
	[IDX] [int] IDENTITY(1,1) NOT NULL,
	[Act_Time] [datetime] NOT NULL,
	[Log_ID] [int] NOT NULL,
	[iData1] [int] NULL,
	[iData2] [int] NULL,
	[iData3] [int] NULL,
	[iData4] [int] NULL,
	[iData5] [int] NULL,
	[iData6] [int] NULL,
	[iData7] [int] NULL,
	[bData1] [bigint] NULL,
	[bData2] [bigint] NULL,
	[bData3] [bigint] NULL,
	[bData4] [bigint] NULL,
	[bData5] [bigint] NULL,
	[bData6] [bigint] NULL,
	[sData1] [nvarchar](200) NULL,
	[sData2] [nvarchar](200) NULL,
	[sData3] [nvarchar](200) NULL,
	[sData4] [nvarchar](200) NULL,
	[sData5] [nvarchar](200) NULL,
	[sData6] [nvarchar](200) NULL,
	[sData7] [nvarchar](200) NULL,
	[sData8] [nvarchar](200) NULL,
	[sData9] [nvarchar](200) NULL,
	[sData10] [nvarchar](200) NULL,
	[sData11] [nvarchar](200) NULL,
	[sData12] [nvarchar](200) NULL,
	[sData13] [nvarchar](200) NULL,
	[sData14] [nvarchar](200) NULL,
	[sData15] [nvarchar](200) NULL,
) ON [PRIMARY];

CREATE CLUSTERED INDEX IX_C_TB_NCLOGD_'+@Daily+'_LogDate ON [dbo].[TB_NCLOGD_'+@Daily+'](Act_Time);
CREATE INDEX IX_NC_TB_NCLOGD_'+@Daily+'_LogID ON [dbo].[TB_NCLOGD_'+@Daily+'](Log_ID);
END

IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N''dbo.[TB_NCLOGD_CHAT_'+@Daily+']'') AND [type] IN (N''U''))
BEGIN
	CREATE TABLE [dbo].[TB_NCLOGD_CHAT_'+@Daily+'](
	[IDX] [int] IDENTITY(1,1) NOT NULL,
	[Act_Time] [datetime] NOT NULL,
	[Log_ID] [int] NOT NULL,
	[iData1] [int] NULL,
	[iData2] [int] NULL,
	[iData3] [int] NULL,
	[iData4] [int] NULL,
	[iData5] [int] NULL,
	[iData6] [int] NULL,
	[iData7] [int] NULL,
	[iData8] [int] NULL,
	[iData9] [int] NULL,
	[sData1] [nvarchar](200) NULL,
	[sData2] [nvarchar](200) NULL,
	[sData3] [nvarchar](200) NULL,
	[sData4] [nvarchar](200) NULL,
	[sData5] [nvarchar](200) NULL,
	[bData1] [bigint] NULL,
	[bData2] [bigint] NULL,
	[bData3] [bigint] NULL
) ON [PRIMARY];
END
'
EXEC sp_executesql @SQL