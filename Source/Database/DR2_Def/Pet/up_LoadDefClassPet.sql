USE [DR2_Def]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_LoadDefClassPet]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_LoadDefClassPet]
GO

CREATE PROCEDURE [dbo].[up_LoadDefClassPet]
/*
////////////////////////////////////////////////////////////////////////
//
// 프로시져명: [dbo].[up_LoadDefClassPet]
// 작성자: YonMy(yonmy@barunsoninter.com)
// 작성일: 2009-06-12
// 파일명: 
// 2009-08-25, 2차펫에 따른 데이터 수정 / DB 분리 
////////////////////////////////////////////////////////////////////////
*/ 
AS
SET Nocount On;

BEGIN
	SELECT	[ClassNo]
		,	[ClassName]
		,	[PetType]
		,	[f_LevelID]
		,	[f_SkillID]
		,	[f_ItemOptionID]
		,	[Hair]
		,	[Face]
		,	[Body]
	FROM [dbo].[TB_DefClassPet] WITH(NOLOCK)
END
