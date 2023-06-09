USE [DR2_Local]
GO
/****** Object:  StoredProcedure [dbo].[up_Web_Admin_LuckyStarReward_Insert]    Script Date: 09/09/2009 11:30:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Web_Admin_LuckyStarReward_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_Web_Admin_LuckyStarReward_Insert]
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[up_Web_Admin_LuckyStarReward_Insert]
	@RewardID	int,
	@Memo	nvarchar(50),
	@Step	int,	
	@Money	int,
	@ItemNo	int,
	@ItemCount	INT,
	@ReVal	int OUTPUT
AS
BEGIN
	SET NOCOUNT ON

	SET @ItemNo = ISNULL(@ItemNo, 0)
	SET @ItemCount = ISNULL(@ItemCount, 0)

	INSERT dbo.TB_LuckyStarReward (
		RewardID, Memo, Step, [Money]
		, ItemNo, ItemCount
	) VALUES (
		@RewardID, @Memo, @Step, @Money
		, @ItemNo, @ItemCount
	)

	SET @ReVal = 0
	RETURN
END

