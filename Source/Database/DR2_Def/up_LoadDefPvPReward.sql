USE [DR2_Def]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_LoadDefPvPReward]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_LoadDefPvPReward]
GO

CREATE PROCEDURE [dbo].[up_LoadDefPvPReward]
/*
////////////////////////////////////////////////////////////////////////
//
// 프로시져명: [dbo].[up_LoadDefPvPReward]
// 작성자: YonMy(yonmy@barunsoninter.com)
// 작성일: 2009-11-24
// 파일명: 
////////////////////////////////////////////////////////////////////////
*/ 
AS
SET Nocount On;

BEGIN	SELECT	[Point_Min]		,	[Point_Max]		,	[CP]	FROM [dbo].[TB_DefPvPRewardPoint]	WITH(NOLOCK)	
	SELECT	[ID]
		,	[GiveItem_Win]
		,	[GiveItem_Draw]
		,	[GiveItem_Lose]
		,	[ItemBagNo_Draw]
		,	[ItemBagNo_Win]
		,	[ItemBagNo_Lose]
	FROM [dbo].[TB_DefPvPRewardItem] WITH(NOLOCK)
END
