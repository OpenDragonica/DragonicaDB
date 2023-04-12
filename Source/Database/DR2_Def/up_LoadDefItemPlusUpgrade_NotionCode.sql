USE [DR2_Def]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_LoadDefItemPlusUpgrade_NationCode]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_LoadDefItemPlusUpgrade_NationCode]

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[up_LoadDefItemPlusUpgrade_NationCode]
AS

BEGIN

	SELECT [NationCodeStr], [EquipPos], [PlusLevel], [SuccessRate], [SuccessRateBonus], [NeedMoney],
		[RareGroupNo], [RareGroupSuccessRate], [NeedItemNo01], [NeedItemCount01], [NeedItemNo02],
		[NeedItemCount02], [NeedItemNo03], [NeedItemCount03]
		FROM [dbo].[TB_DefItemPlusUpgrade] WITH(NOLOCK)
		
END

