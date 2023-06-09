USE [DR2_Local]
GO

/****** Object:  StoredProcedure [dbo].[up_LoadLuckyStarEvent]    Script Date: 09/09/2009 11:29:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_LoadLuckyStarEvent]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_LoadLuckyStarEvent]
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROC [dbo].[up_LoadLuckyStarEvent]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT [EventId]
      ,[UserLimit]
      ,[CostMoney]
      ,[StartDate]
      ,[EndDate]
      ,[EventNotiClose]
      ,[MailTitle]
      ,[MailText]
	  ,[DelayTime]
	  ,[LimitTime]
	  ,[LuckyPoint]
  FROM [dbo].[TB_LuckyStarEvent]
    

 SELECT [RewardId]
      ,[Step]
      ,[Money]
      ,[ItemNo]
      ,[ItemCount]
  FROM [dbo].[TB_LuckyStarReward] 

 SELECT [EventId]
	  ,[RewardId]
  FROM [dbo].[TB_LuckyStarEventJoinReward]
  
END
