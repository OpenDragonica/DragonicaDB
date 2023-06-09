USE [DR2_Local]
GO
/****** Object:  StoredProcedure [dbo].[up_Web_Admin_LuckyStarEvent_Insert]    Script Date: 09/09/2009 11:29:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Web_Admin_LuckyStarEvent_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_Web_Admin_LuckyStarEvent_Insert]
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[up_Web_Admin_LuckyStarEvent_Insert]
	@EventID	int,
	@Memo	nvarchar(50),
	@UserLimit int,
	@CostMoney int,
	@StartDate	datetime,
	@EndDate	datetime,
	@EventNotiClose	nvarchar(200),
	@MailTitle		nvarchar(50),
	@MailText		nvarchar(200),
	@DelayTime		int,
	@LimitTime		int,
	@LuckyPoint		int,
	@ReVal	int	OUTPUT
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @Count	INT

	SET @Count = ( SELECT COUNT(*) FROM [dbo].[TB_LuckyStarEvent] WHERE EventID = @EventID )

	IF @Count > 0
	BEGIN
		SET @ReVal = 1
		RETURN
	END

	INSERT [dbo].[TB_LuckyStarEvent]
			   ([EventId]
			   ,[Memo]
			   ,[UserLimit]
			   ,[CostMoney]
			   ,[StartDate]
			   ,[EndDate]
			   ,[EventNotiClose]
			   ,[MailTitle]
			   ,[MailText]
			   ,[DelayTime]
			   ,[LimitTime]
			   ,[LuckyPoint])
		 VALUES
			   (@EventID
			   ,@Memo
			   ,@UserLimit
			   ,@CostMoney
			   ,@StartDate
			   ,@EndDate
			   ,@EventNotiClose
			   ,@MailTitle
			   ,@MailText
			   ,@DelayTime
			   ,@LimitTime
			   ,@LuckyPoint)

	SET @ReVal = 0
	RETURN
END




