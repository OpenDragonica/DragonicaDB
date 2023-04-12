USE DR2_Def

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_LoadDefBaseCharacter2]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[up_LoadDefBaseCharacter2]
END 

set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go


create Proc [dbo].[up_LoadDefBaseCharacter2]
/*
////////////////////////////////////////////////////////////////////////
//
// ���ν�����: [dbo].[up_LoadDefBaseCharacter]
// �ۼ���: 
// �ۼ���: 
// ���ϸ�: 
// N O T E :  ���̽�ĳ�����������ε��Ѵ�.
//	2008-12-09 : ��������������Ʈ��������ø�
//	2009-03-12 : ����gmlv ����
//	2009-03-12 : �ι��丮Ȯ��/��������߰�
////////////////////////////////////////////////////////////////////////
*/ 
AS

begin
	SELECT 
		f_NationCodeStr,
		f_Class,			
		f_State,
		f_Race,
		f_Lv,
		f_Exp,					--5
		f_Money,
		f_HP,
		f_MP,
		f_CP,
		f_ExtraSkillPoint,		--10
		f_Skills,
		f_RecentMap,
		f_RecentLocX,
		f_RecentLocY,
		f_RecentLocZ,			--15
		f_LastVillage,
		f_LastVillageLocX,
		f_LastVillageLocY,
		f_LastVillageLocZ,
		f_QuickSlot,			--20
		f_IngQuest,
		f_EndQuest,
		f_EndQuest2,
		f_EndQuestExt,
		f_EndQuestExt2,			--25
		f_InvExtend
		FROM [dbo].[TB_DefBaseCharacter2] with(nolock)
end

GO
