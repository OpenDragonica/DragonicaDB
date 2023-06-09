USE [DR2_User]
GO

/****** Object:  StoredProcedure [dbo].[UP_Update_LuckyStarEventSub]    Script Date: 09/18/2009 00:12:36 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UP_Update_LuckyStarEventSub]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[UP_Update_LuckyStarEventSub]

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[UP_Update_LuckyStarEventSub]
	@EventId int,
	@Type tinyint,
	@Value int
AS
BEGIN
BEGIN TRAN

	IF NOT EXISTS( SELECT 1 FROM dbo.TB_LuckyStarEventSub WHERE EventId = @EventId )
	BEGIN
		INSERT INTO dbo.TB_LuckyStarEventSub (EventId) VALUES (@EventId)
	END

	--EVENTSTATE		= 0,
	--SENDRESULTTYPE	= 1,
	--LASTREWARDID		= 2,
	--EVENTCOUNT		= 3,
	--LASTRESULTSTAR	= 4,
	--EVENTFLAG			= 5,

	IF @Type = 0
	BEGIN
		UPDATE dbo.TB_LuckyStarEventSub SET EventState = @Value WHERE EventID = @EventID
	END
	ELSE IF @Type = 1
	BEGIN
		UPDATE dbo.TB_LuckyStarEventSub SET SendResultType = @Value
		WHERE EventId = @EventId
	END
	ELSE IF @Type = 2
	BEGIN
		UPDATE dbo.TB_LuckyStarEventSub SET LastRewardId = @Value
		WHERE EventId = @EventId
	END
	ELSE IF @Type = 3
	BEGIN
		UPDATE dbo.TB_LuckyStarEventSub SET EventCount = ISNULL(EventCount,0)+1
		WHERE EventId = @EventId
	END
	ELSE IF @Type = 4
	BEGIN
		UPDATE dbo.TB_LuckyStarEventSub SET LastResultStar = @Value
		WHERE EventId = @EventId
	END
	ELSE IF @Type = 5
	BEGIN
		UPDATE dbo.TB_LuckyStarEventSub SET EventFlag = @Value
		WHERE EventId = @EventId
	END

COMMIT TRAN
END
