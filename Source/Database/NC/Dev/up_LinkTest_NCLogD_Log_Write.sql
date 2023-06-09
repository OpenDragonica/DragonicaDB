USE [DR2_Log]
GO

IF EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.up_LinkTest_NCLogD_Log_Write') AND [type] IN (N'P'))
BEGIN
	DROP PROCEDURE dbo.up_LinkTest_NCLogD_Log_Write
END

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[up_LinkTest_NCLogD_Log_Write]
/*
////////////////////////////////////////////////////////////////////////
//
// 프로시져명 : [NCLogD 연동 테스트 테이블] [dbo].[UP_LinkTest_NCLogD_Log_Write]
// 작 성 자 : 김용민(yonmy@barunsoninter.com)
// 작 성 일 : 2009-02-17
// 최종수정자 : 
// 수 정 일 :  
// 파 일 명 : 
// N O T E :  NCLogD 연동 테스트용 SP
////////////////////////////////////////////////////////////////////////
*/ 
	@Act_Time DATETIME,
	@Log_ID INT,
	@iData1 INT = NULL,
	@iData2 INT = NULL,
	@iData3 INT = NULL,
	@iData4 INT = NULL,
	@iData5 INT = NULL,
	@iData6 INT = NULL,
	@iData7 INT = NULL,
	@bData1 BIGINT = NULL,
	@bData2 BIGINT = NULL,
	@bData3 BIGINT = NULL,
	@bData4 BIGINT = NULL,
	@bData5 BIGINT = NULL,
	@bData6 BIGINT = NULL,
	@sData1 NVARCHAR(200) = NULL,
	@sData2 NVARCHAR(200) = NULL,
	@sData3 NVARCHAR(200) = NULL,
	@sData4 NVARCHAR(200) = NULL,
	@sData5 NVARCHAR(200) = NULL,
	@sData6 NVARCHAR(200) = NULL,
	@sData7 NVARCHAR(200) = NULL,
	@sData8 NVARCHAR(200) = NULL,
	@sData9 NVARCHAR(200) = NULL,
	@sData10 NVARCHAR(200) = NULL,
	@sData11 NVARCHAR(200) = NULL,
	@sData12 NVARCHAR(200) = NULL,
	@sData13 NVARCHAR(200) = NULL,
	@sData14 NVARCHAR(200) = NULL,
	@sData15 NVARCHAR(200) = NULL
AS
SET NOCOUNT ON
SET XACT_ABORT ON

DECLARE @Daily VARCHAR(20)
DECLARE @SQL	 NVARCHAR(4000)
DECLARE @SQL_Params NVARCHAR(2000)

SET @Daily = ( SELECT CONVERT(CHAR(8), GETDATE(), 112) )--오늘 날짜 테이블

SET @SQL = N' INSERT [dbo].[TB_NCLOGD_' + @Daily + '] ('
SET @SQL = @SQL + N'[Act_Time],[Log_ID]'
SET @SQL = @SQL + N',[iData1],[iData2],[iData3],[iData4],[iData5],[iData6],[iData7]'
SET @SQL = @SQL + N',[bData1],[bData2],[bData3],[bData4],[bData5],[bData6]'
SET @SQL = @SQL + N',[sData1],[sData2],[sData3],[sData4],[sData5]'
SET @SQL = @SQL + N',[sData6],[sData7],[sData8],[sData9],[sData10]'
SET @SQL = @SQL + N',[sData11],[sData12],[sData13],[sData14],[sData15]'
SET @SQL = @SQL + N' ) VALUES ('
SET @SQL = @SQL + N'@Act_Time,@Log_ID'
SET @SQL = @SQL + N',@iData1,@iData2,@iData3,@iData4,@iData5,@iData6,@iData7'
SET @SQL = @SQL + N',@bData1,@bData2,@bData3,@bData4,@bData5,@bData6'
SET @SQL = @SQL + N',@sData1,@sData2,@sData3,@sData4,@sData5'
SET @SQL = @SQL + N',@sData6,@sData7,@sData8,@sData9,@sData10'
SET @SQL = @SQL + N',@sData11,@sData12,@sData13,@sData14,@sData15 '
SET @SQL = @SQL + N') '

SET @SQL_Params = N'@Act_Time DATETIME,@Log_ID int'
SET @SQL_Params = @SQL_Params + N',@iData1 int,@iData2 int,@iData3 int,@iData4 int,@iData5 int,@iData6 int,@iData7 int'
SET @SQL_Params = @SQL_Params + N',@bData1 bigint,@bData2 bigint,@bData3 bigint,@bData4 bigint,@bData5 bigint,@bData6 bigint'
SET @SQL_Params = @SQL_Params + N',@sData1 nvarchar(200),@sData2 nvarchar(200),@sData3 nvarchar(200),@sData4 nvarchar(200),@sData5 nvarchar(200)'
SET @SQL_Params = @SQL_Params + N',@sData6 nvarchar(200),@sData7 nvarchar(200),@sData8 nvarchar(200),@sData9 nvarchar(200),@sData10 nvarchar(200)'
SET @SQL_Params = @SQL_Params + N',@sData11 nvarchar(200),@sData12 nvarchar(200),@sData13 nvarchar(200),@sData14 nvarchar(200),@sData15 nvarchar(200) '

EXEC sp_executesql @SQL, @SQL_Params
	,@Act_Time, @Log_ID
	,@iData1 ,@iData2 ,@iData3 ,@iData4 ,@iData5 ,@iData6 ,@iData7
	,@bData1 ,@bData2 ,@bData3 ,@bData4 ,@bData5 ,@bData6
	,@sData1 ,@sData2 ,@sData3 ,@sData4 ,@sData5
	,@sData6 ,@sData7 ,@sData8 ,@sData9 ,@sData10
	,@sData11 ,@sData12 ,@sData13 ,@sData14 ,@sData15

SELECT @@ERROR
