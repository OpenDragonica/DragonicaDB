USE [DR2_Def]
GO
/****** 개체:  StoredProcedure [dbo].[up_LoadDefMonsterTunning]    스크립트 날짜: 01/15/2010 12:33:36 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_LoadDefMonsterTunning]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_LoadDefMonsterTunning]

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Proc [dbo].[up_LoadDefMonsterTunning]
AS
BEGIN
	SELECT [KeyNo],[Grade],[Level],
		[Abil01], [Abil02], [Abil03],
		[Abil04], [Abil05], [Abil06],
		[Abil07], [Abil08], [Abil09],
		[Abil10] 
	FROM dbo.TB_DefMonsterTunning WITH(NOLOCK)
END
