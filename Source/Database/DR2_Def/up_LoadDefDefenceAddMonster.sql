USE [DR2_Def]
GO
/****** Object:  StoredProcedure [dbo].[up_LoadDefDefenceAddMonster]    Script Date: 02/12/2010 16:33:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_LoadDefDefenceAddMonster]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_LoadDefDefenceAddMonster]
GO

/****** Object:  StoredProcedure [dbo].[up_LoadDefDefenceAddMonster]    Script Date: 02/12/2010 16:33:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[up_LoadDefDefenceAddMonster]
AS

BEGIN
	SELECT 	[f_NationCodeStr]
			, [AddMonster_GroupNo]
			, [Success_Count]
			, [Add_StageTime]
			, [MonsterNo]
			, [Enchant_Probability]
			, [ExpRate]
			, [ItemNo]
			, [ItemCount]
			, [DropRate]
			, [MonRes]
	FROM [dbo].[TB_DefDefenceAddMonster] with(NOLOCK)
END
GO
