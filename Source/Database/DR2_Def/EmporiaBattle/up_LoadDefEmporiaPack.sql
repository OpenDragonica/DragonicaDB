USE [DR2_Def]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_LoadDefEmporiaPack]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[up_LoadDefEmporiaPack]
END
GO

CREATE PROCEDURE [dbo].[up_LoadDefEmporiaPack]
/*
////////////////////////////////////////////////////////////////////////
//
// 프로시져명 : Def EmporiaPack 정보 불러오기
// 작 성 자 : YonMy
// 작 성 일 : 2009-06-10
// 최종수정자 :
// 수 정 일 : 2010-02-09 // 심헌섭 // Reward 정보 추가
// 담 당 자 : 
// N O T E : 
//	2009-06-26, YonMy, Function 정보 추가
//	2009-09-17, YonMy, Battle Ground 도 셋팅할 수 있게 추가
////////////////////////////////////////////////////////////////////////
*/
AS
SET XACT_ABORT ON
SET NOCOUNT ON
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

BEGIN
	SELECT	T1.[EmporiaID]
		,	[BaseMapNo]
		,	[Grade1_GroundNo]
		,	[Grade1_BattleGroundNo]
		,	[Grade2_GroundNo]
		,	[Grade2_BattleGroundNo]
		,	[Grade3_GroundNo]
		,	[Grade3_BattleGroundNo]
		,	[Grade4_GroundNo]
		,	[Grade4_BattleGroundNo]
		,	[Grade5_GroundNo]
		,	[Grade5_BattleGroundNo]
		,	[Challenge_BattleGroundNo]
		,	[LimitCost]
		,	[FromNo]	,[TitleNo]	,[BodyNo]
		,	[QuarterItem]	,[QuarterMoney]		,[QuarterGradeTextNo]
		,	[SemiItem]		,[SemiMoney]		,[SemiGradeTextNo]
		,	[SecondItem]	,[SecondMoney]		,[SecondGradeTextNo]
		,	[WinnerItem]	,[WinnerMoney]		,[WinnerGradeTextNo]
		,	[Grade1_Item]	,[Grade1_Money]		,[Grade1_TextNo]
		,	[Grade2_Item]	,[Grade2_Money]		,[Grade2_TextNo]
		,	[Grade3_Item]	,[Grade3_Money]		,[Grade3_TextNo]
		,	[Grade4_Item]	,[Grade4_Money]		,[Grade4_TextNo]
		,	[Grade5_Item]	,[Grade5_Money]		,[Grade5_TextNo]
		,	[LimitDay]
	FROM [dbo].[TB_DefEmporiaPack] T1
	JOIN [dbo].[TB_DefEmporiaReward] T2 ON T1.[EmporiaID]=T2.[EmporiaID]
	
	SELECT	[EmporiaID]
		,	[Grade]
		,	[FunctionNo]
		,	[Price_ForWeek]
		,	[iValue]
	FROM [dbo].[TB_DefEmporiaFunction]
END
GO

