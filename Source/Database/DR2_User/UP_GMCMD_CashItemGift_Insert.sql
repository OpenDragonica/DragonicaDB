USE [DR2_User]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UP_GMCMD_CashItemGift_Insert]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[UP_GMCMD_CashItemGift_Insert]
GO

/****** 개체:  StoredProcedure [dbo].[UP_GMCMD_CashItemGift_Insert]    스크립트 날짜: 09/24/2009 23:33:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
-- =============================================
-- Author:		
-- Create date: 
-- Description:	
-- =============================================
*/
CREATE PROC [dbo].[UP_GMCMD_CashItemGift_Insert]
(
	@ArticleIdx INT
	,@TimeType SMALLINT
	,@UseTime INT
	,@StartDate NVARCHAR(30)
	,@EndDate NVARCHAR(30)
	,@Sender NVARCHAR(50)
	,@Memo NVARCHAR(50)
	,@MailTitle NVARCHAR(50)
	,@MailBody NVARCHAR(200)
	,@Option INT
)
AS
BEGIN TRAN
SET NOCOUNT ON;

DECLARE @CNT INT
SELECT @CNT=COUNT(*) FROM dbo.TB_Event 
WHERE (eventtype = 12 and intdata01=64511) and
	((startdate <= @StartDate and @StartDate < enddate) or
	(startdate < @EndDate and @EndDate <= enddate))

IF @CNT <> 0
BEGIN
	ROLLBACK TRAN
	SELECT 2
	RETURN 2
END

DECLARE @EventNo INT
DECLARE @EventType TINYINT
DECLARE @EventType2 INT
SET @EventNo = (SELECT ISNULL(MAX(EventNo),0)+1 FROM [dbo].[TB_Event])
SET @EventType = 12
SET @EventType2 = 64511

IF @StartDate > @EndDate
BEGIN
	ROLLBACK TRAN
	SELECT 1
	RETURN 1
END

INSERT INTO [dbo].[TB_Event]
       ([EventNo],[EventType],[StartDate],[EndDate],
		[intData01],[intData02],[intData03],[bigintData01],
		[bigintData02],
		[stringData01],[stringData02],
		[Title],[Description])
 VALUES
       (@EventNo,@EventType,@StartDate,@EndDate
       ,@EventType2,@ArticleIdx,@TimeType,@UseTime
	   ,@Option
       ,@Sender,@Memo
       ,@MailTitle,@MailBody)

IF @@ROWCOUNT = 0
BEGIN
	ROLLBACK TRAN
	SELECT 3
	RETURN 3
END

COMMIT TRAN
SELECT 0, @EventNo
RETURN 0

