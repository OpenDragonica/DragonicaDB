USE [DR2_Def]
GO
/****** Object:  StoredProcedure [dbo].[up_LoadDefItemMaking]    Script Date: 03/20/2013 10:37:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_LoadDefCooking]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_LoadDefCooking]
GO

CREATE PROC [dbo].[up_LoadDefCooking]
AS
BEGIN

	SELECT [No], [MakingTypeNo], [NeedMoney],
		[NeedElementNo01], [NeedElementCount01],
		[NeedElementNo02], [NeedElementCount02],
		[NeedElementNo03], [NeedElementCount03],
		[NeedElementNo04], [NeedElementCount04],
		[OptionElementNo01], [OptionElementCount01],
		[ResultItemNo01], [ResultItemCount01], [ResultItemRate01], [OptionResultItemRate01],
		[ResultItemNo02], [ResultItemCount02], [ResultItemRate02], [OptionResultItemRate02],
		[ResultItemNo03], [ResultItemCount03], [ResultItemRate03], [OptionResultItemRate03]
	  FROM [dbo].[TB_DefCooking] WITH(NOLOCK)

END
