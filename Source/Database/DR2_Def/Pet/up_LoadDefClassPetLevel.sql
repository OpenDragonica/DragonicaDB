USE [DR2_Def]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_LoadDefClassPetLevel]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_LoadDefClassPetLevel]
GO

CREATE PROCEDURE [dbo].[up_LoadDefClassPetLevel]
/*
////////////////////////////////////////////////////////////////////////
//
// 프로시져명: [dbo].[up_LoadDefClassPetLevel]
// 작성자: YonMy(yonmy@barunsoninter.com)
// 작성일: 2009-08-21
// 파일명: 
////////////////////////////////////////////////////////////////////////
*/ 
AS
SET Nocount On;

BEGIN
	SELECT	[ID]
		,	[Level]
		,	[Experience]
		,	[AddExperienceForTime]
		,	[MaxMP]
		,	[MP_Recovery_Speed]
		,	[MP_Recovery]
		,	[Abil01]
		,	[Abil02]
		,	[Abil03]
		,	[Abil04]
		,	[Abil05]
		,	[Abil06]
		,	[Abil07]
		,	[Abil08]
		,	[Abil09]
		,	[Abil10]
	FROM [dbo].[TB_DefClassPetLevel] WITH(NOLOCK)
END
GO
