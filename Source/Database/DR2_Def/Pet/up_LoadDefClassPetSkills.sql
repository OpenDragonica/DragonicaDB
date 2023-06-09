USE [DR2_Def]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_LoadDefClassPetSkills]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[up_LoadDefClassPetSkills]
END
GO

CREATE PROCEDURE [dbo].[up_LoadDefClassPetSkills]
/*
////////////////////////////////////////////////////////////////////////
//
// 프로시져명: [dbo].[up_LoadDefClassPetSkill]
// 작성자: YonMy(yonmy@barunsoninter.com)
// 작성일: 2009-08-25
// 파일명: 
// 2010-02-17, YonMy 펫 스킬 갯수 확장
// 2010-04-02, YonMy 펫 스킬
////////////////////////////////////////////////////////////////////////
*/ 
AS
SET Nocount On;

BEGIN
	SELECT	[ID]
		,	[Level]
		,	[Skill01]
		,	[Skill02]
		,	[Skill03]
		,	[Skill04]
		,	[Skill05]
		,	[Skill06]
		,	[Skill07]
		,	[Skill08]
		,	[Skill09]
		,	[Skill10]
		,	[Skill11]
		,	[Skill12]
		,	[Skill13]
		,	[Skill14]
		,	[Skill15]
		,	[Skill16]
		,	[Skill17]
		,	[Skill18]
		,	CAST(([UseTime01] + ([UseTime02]*2) + ([UseTime03]*4) + ([UseTime04]*8) + ([UseTime05]*16) + ([UseTime06]*32) + ([UseTime07]*64) + ([UseTime08]*128) + ([UseTime09]*256) + ([UseTime10]*512) + ([UseTime11]*1024) + ([UseTime12]*2048) + ([UseTime13]*4096) + ([UseTime14]*8192) + ([UseTime15]*16348) + + ([UseTime16]*32768) + ([UseTime17]*65536) + ([UseTime18]*131072)) AS INT)
	FROM [dbo].[TB_DefClassPetSkills] WITH(NOLOCK)
END
