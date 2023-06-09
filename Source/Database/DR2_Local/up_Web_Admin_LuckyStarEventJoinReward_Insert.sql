USE [DR2_Local]
GO
/****** Object:  StoredProcedure [dbo].[up_Web_Admin_LuckyStarEventJoinReward_Insert]    Script Date: 09/09/2009 11:29:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Web_Admin_LuckyStarEventJoinReward_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_Web_Admin_LuckyStarEventJoinReward_Insert]
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[up_Web_Admin_LuckyStarEventJoinReward_Insert]
	@EventID	int,
	@RewardID	int,
	@ReVal	int OUTPUT
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @EventCount	 int
	DECLARE @RewardCount int
	DECLARE @Count		 int

	SET @EventCount = ( SELECT COUNT(*) FROM [dbo].[TB_LuckyStarEvent] WHERE EventID = @EventID )
	SET @RewardCount = ( SELECT COUNT(*) FROM [dbo].[TB_LuckyStarReward] WHERE RewardID = @RewardID )

	IF @EventCount = 0 OR @RewardCount = 0
	BEGIN
		SET @ReVal = 1
		RETURN
	END

	SET @Count = ( SELECT COUNT(*) FROM [dbo].[TB_LuckyStarEventJoinReward] WHERE EventID = @EventID AND RewardID = @RewardID )

	IF @Count > 0
	BEGIN
		SET @ReVal = 1
		RETURN
	END

	INSERT [dbo].[TB_LuckyStarEventJoinReward] (
		EventID, RewardID
	) VALUES (
		@EventID, @RewardID
	)

	SET @ReVal = 0
	RETURN
END

