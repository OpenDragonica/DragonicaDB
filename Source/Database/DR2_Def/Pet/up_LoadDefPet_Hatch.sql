USE [DR2_Def]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_LoadDefPet_Hatch]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_LoadDefPet_Hatch]
GO

CREATE PROCEDURE [dbo].[up_LoadDefPet_Hatch]
/*
////////////////////////////////////////////////////////////////////////
//
// 프로시져명: [dbo].[up_LoadDefPet_Hatch]
// 작성자: YonMy(yonmy@barunsoninter.com)
// 작성일: 2009-06-12
// 파일명: 
////////////////////////////////////////////////////////////////////////
*/ 
AS
SET Nocount On;
BEGIN
	SELECT	[f_NationCodeStr]
		,	[ID]
		,	[Class_01]
		,	[Level_01]
		,	[Rate_01]
		,	[BonusStatusID_01_1]
		,	[BonusStatusID_01_2]
		,	[BonusStatusID_01_3]
		,	[Class_02]
		,	[Level_02]
		,	[Rate_02]
		,	[BonusStatusID_02_1]
		,	[BonusStatusID_02_2]
		,	[BonusStatusID_02_3]
		,	[Class_03]
		,	[Level_03]
		,	[Rate_03]
		,	[BonusStatusID_03_1]
		,	[BonusStatusID_03_2]
		,	[BonusStatusID_03_3]
		,	[Class_04]
		,	[Level_04]
		,	[Rate_04]
		,	[BonusStatusID_04_1]
		,	[BonusStatusID_04_2]
		,	[BonusStatusID_04_3]
		,	[Class_05]
		,	[Level_05]
		,	[Rate_05]
		,	[BonusStatusID_05_1]
		,	[BonusStatusID_05_2]
		,	[BonusStatusID_05_3]
		,	[Period_01]
		,	[PeriodRate_01]
		,	[Period_02]
		,	[PeriodRate_02]
		,	[Period_03]
		,	[PeriodRate_03]
		,	[Period_04]
		,	[PeriodRate_04]
		,	[Period_05]
		,	[PeriodRate_05]
		,	[Period_06]
		,	[PeriodRate_06]
		,	[Period_07]
		,	[PeriodRate_07]
		,	[Period_08]
		,	[PeriodRate_08]
		,	[Period_09]
		,	[PeriodRate_09]
		,	[Period_10]
		,	[PeriodRate_10]
		FROM [dbo].[TB_DefPet_Hatch] WITH(NOLOCK)
END





