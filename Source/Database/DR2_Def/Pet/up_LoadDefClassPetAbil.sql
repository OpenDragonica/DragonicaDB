USE [DR2_Def]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_LoadDefPetAbil]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_LoadDefPetAbil]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_LoadDefClassPetAbil]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_LoadDefClassPetAbil]
GO

CREATE PROCEDURE [dbo].[up_LoadDefClassPetAbil]
/*
////////////////////////////////////////////////////////////////////////
//
// 프로시져명: [dbo].[up_LoadDefClassPetAbil]
// 작성자: YonMy(yonmy@barunsoninter.com)
// 작성일: 2009-06-12
// 파일명: 
////////////////////////////////////////////////////////////////////////
*/ 
AS

BEGIN
	SELECT	[AbilNo]
		,	[Type01]
		,	[Value01]
		,	[Type02]
		,	[Value02]
		,	[Type03]
		,	[Value03]
		,	[Type04]
		,	[Value04]
		,	[Type05]
		,	[Value05]
		,	[Type06]
		,	[Value06]
		,	[Type07]
		,	[Value07]
		,	[Type08]
		,	[Value08]
		,	[Type09]
		,	[Value09]
		,	[Type10]
		,	[Value10]
	FROM [dbo].[TB_DefClassPetAbil] WITH(NOLOCK)
END






