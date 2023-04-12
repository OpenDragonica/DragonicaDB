USE [DR2_Def]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_CheckMonsterBagFrom_TB_DefItemBag]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_CheckMonsterBagFrom_TB_DefItemBag]

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[up_CheckMonsterBagFrom_TB_DefItemBag]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @TABLE TABLE (MONABILNO INT, BAGNO INT)
	INSERT INTO @TABLE SELECT [MonsterAbilNo],[Value01] FROM [dbo].[TB_DefMonsterAbil] WHERE TYPE01 = 3041 OR TYPE01 = 3042
	INSERT INTO @TABLE SELECT [MonsterAbilNo],[Value02] FROM [dbo].[TB_DefMonsterAbil] WHERE TYPE02 = 3041 OR TYPE02 = 3042
	INSERT INTO @TABLE SELECT [MonsterAbilNo],[Value03] FROM [dbo].[TB_DefMonsterAbil] WHERE TYPE03 = 3041 OR TYPE03 = 3042
	INSERT INTO @TABLE SELECT [MonsterAbilNo],[Value04] FROM [dbo].[TB_DefMonsterAbil] WHERE TYPE04 = 3041 OR TYPE04 = 3042
	INSERT INTO @TABLE SELECT [MonsterAbilNo],[Value05] FROM [dbo].[TB_DefMonsterAbil] WHERE TYPE05 = 3041 OR TYPE05 = 3042
	INSERT INTO @TABLE SELECT [MonsterAbilNo],[Value06] FROM [dbo].[TB_DefMonsterAbil] WHERE TYPE06 = 3041 OR TYPE06 = 3042
	INSERT INTO @TABLE SELECT [MonsterAbilNo],[Value07] FROM [dbo].[TB_DefMonsterAbil] WHERE TYPE07 = 3041 OR TYPE07 = 3042
	INSERT INTO @TABLE SELECT [MonsterAbilNo],[Value08] FROM [dbo].[TB_DefMonsterAbil] WHERE TYPE08 = 3041 OR TYPE08 = 3042
	INSERT INTO @TABLE SELECT [MonsterAbilNo],[Value09] FROM [dbo].[TB_DefMonsterAbil] WHERE TYPE09 = 3041 OR TYPE09 = 3042
	INSERT INTO @TABLE SELECT [MonsterAbilNo],[Value10] FROM [dbo].[TB_DefMonsterAbil] WHERE TYPE10 = 3041 OR TYPE10 = 3042
	SELECT * FROM @TABLE A LEFT JOIN DBO.TB_DEFITEMBAG B ON A.BAGNO = B.BAGNO
	WHERE A.BAGNO > 0 AND B.IDX IS NULL

END
