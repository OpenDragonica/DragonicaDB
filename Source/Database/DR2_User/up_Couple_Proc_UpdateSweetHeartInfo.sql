USE [DR2_User]
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

/****** Object:  StoredProcedure [dbo].[up_Couple_Proc_UpdateSweetHeartInfo]    Script Date: 07/10/2009 15:23:52 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Couple_Proc_UpdateSweetHeartInfo]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[up_Couple_Proc_UpdateSweetHeartInfo]
END
GO

/*
////////////////////////////////////////////////////////////////////////
//
// ���ν����� : up_Couple_Proc_UpdateSweetHeartInfo
// �� �� �� : �� �� ��
// �� �� �� : 2009-7-10
// ���������� : 
// �� �� �� : 
// �� �� �� : 
// N O T E : ���̺��� �ش� �÷����� �����Ѵ�.
//
////////////////////////////////////////////////////////////////////////
*/

CREATE PROC [dbo].[up_Couple_Proc_UpdateSweetHeartInfo] 
	@CharacterID uniqueidentifier,
	@QuestID int = 0,
	@QuestTime bigint = 0,
	@LearnSkill int = 0,
	@ColorID uniqueidentifier = '00000000-0000-0000-0000-000000000000',
	@DateValue DATETIME = NULL	
AS
SET NOCOUNT ON
SET XACT_ABORT ON	

UPDATE [dbo].[TB_UserCouple]
	SET 
		[DeleteQuest]				= @QuestID,
		[SweetHeartQuestTime]		= @QuestTime,
		[LearnSkill]				= @LearnSkill,
		[ColorGuid]					= @ColorID,
		[CouplePanaltyLimitDate]	= @DateValue		
	WHERE
		[CharacterGuid]				= @CharacterID

GO
