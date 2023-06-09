USE [DR2_local]
GO
/****** Object:  StoredProcedure [dbo].[up_Web_Admin_LuckyStarEvent_Insert]    Script Date: 07/27/2010 20:21:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_UpdateLastLuckyStarEvent]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_UpdateLastLuckyStarEvent]
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[up_UpdateLastLuckyStarEvent]
	@UserLimit int,
	@CostMoney int,
	@StartDate	datetime,
	@EndDate	datetime,
	@DelayTime		int,
	@LimitTime		int,
	@LuckyPoint		int
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @Count	INT
	DECLARE @EventID INT
	SET @EventID = 0

	SET @Count = ( SELECT COUNT(*) FROM [dbo].[TB_LuckyStarEvent] WHERE EventID = @EventID )

	IF @Count > 0
	BEGIN
		UPDATE [dbo].[TB_LuckyStarEvent]
		   SET [UserLimit] = @UserLimit
			  ,[CostMoney] = @CostMoney
			  ,[StartDate] = @StartDate
			  ,[EndDate] = @EndDate
			  ,[DelayTime] = @DelayTime
			  ,[LimitTime] = @LimitTime
			  ,[LuckyPoint] = @LuckyPoint
		 WHERE EventID = @EventID
	END
	ELSE
	BEGIN
		INSERT [dbo].[TB_LuckyStarEvent]
				   ([EventId]
				   ,[UserLimit]
				   ,[CostMoney]
				   ,[StartDate]
				   ,[EndDate]
				   ,[DelayTime]
				   ,[LimitTime]
				   ,[LuckyPoint])
			 VALUES
				   (@EventID
				   ,@UserLimit
				   ,@CostMoney
				   ,@StartDate
				   ,@EndDate
				   ,@DelayTime
				   ,@LimitTime
				   ,@LuckyPoint)
	END

	RETURN
END




