USE [DR2_Def]
GO
/****** Object:  StoredProcedure [dbo].[up_LoadDefQuestReward6]    Script Date: 06/30/2009 18:24:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- =============================================
-- Author:		<육정범>
-- Create date: <2008.03.05>
-- Modify data: 2008.12.02
-- Description:
	2008.08.26 // 테이블로 부터 퀘스트 보상 경험치/골드, 레벨 Min/Max 읽는다.>
	2008.12.02 // 추가된 QuestDifficult 필드 읽도록
	2009.02.18 // NationCode 추가
-- =============================================
*/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_LoadDefQuestReward6]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_LoadDefQuestReward6]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_LoadDefQuestReward]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_LoadDefQuestReward]
GO

CREATE PROCEDURE [dbo].[up_LoadDefQuestReward]
AS
BEGIN
	SET NOCOUNT ON;

	SELECT [NationCodeStr]
		,[QuestID]
		,[XmlPath]
		,[GroupNo]
		,[QuestType]
		,[RewardExp]
		,[RewardGold]
		,[iRewardPerLevel_Exp]
		,[iRewardPerLevel_Money]
		,[LevelMin]
		,[LevelMax]
		,[LimitLevelMax]
		,[TacticsLevel]
		,[TacticsExp]
		,[GuildExp]
		,[QuestDifficult]
		,[f_OrderIndex]
		,[f_IsCanRemoteComplete]
		,[f_IsCanShare]
		,[TitleText]
		,[GroupName]
		,[Class]
		,[DraClassLimit]
		,[PreQuestAnd]
		,[PreQuestOr]
		,[NotQuest]
		,[MinParty]
		,[MaxParty]
		,[f_Wanted_ClearCount]
		,[f_Wanted_ItemNo]
		,[f_Wanted_ItemCount]
		,[f_Wanted_CoolTime]
		,[f_Dra_Wanted_ItemNo]
		,[f_Dra_Wanted_ItemCount]
		,[f_IsCanRemoteAccept]
	FROM [dbo].[TB_DefQuestReward]
	WITH(NOLOCK)
END