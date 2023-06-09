USE [DR2_Def]
GO
/****** 개체:  StoredProcedure [dbo].[up_LoadDefMonsterAbil]    스크립트 날짜: 01/15/2010 12:33:36 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_LoadDefMonsterAbil]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_LoadDefMonsterAbil]

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Proc [dbo].[up_LoadDefMonsterAbil]
AS
BEGIN
	SELECT [f_NationCodeStr], [MonsterAbilNo],
		[Type01], [Value01], [Type02], [Value02], [Type03], [Value03],
		[Type04], [Value04], [Type05], [Value05], [Type06], [Value06],
		[Type07], [Value07], [Type08], [Value08], [Type09], [Value09],
		[Type10], [Value10] 
		FROM dbo.TB_DefMonsterAbil WITH(NOLOCK)
END
