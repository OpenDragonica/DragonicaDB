USE [DR2_Local]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_LoadDefPvPTime]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_LoadDefPvPTime]
GO

CREATE PROCEDURE [dbo].[up_LoadDefPvPTime]
/*
////////////////////////////////////////////////////////////////////////
//
// 프로시져명: [dbo].[up_LoadDefPvPTime]
// 작성자: YonMy(yonmy@barunsoninter.com)
// 작성일: 2009-09-07
// 파일명: 
// 2009-12-03, YonMy 레벨제한 설정 추가
// 2009-12-18, YonMy 확장데이터 추가
// 2010-05-03, codenavy 밸런스 레벨 제한 설정 추가
////////////////////////////////////////////////////////////////////////
*/ 
AS
SET Nocount On;

BEGIN
	SELECT	[f_NationCodeStr]
		,	[TypeID]
		,	[BeginTime_Hour]
		,	[BeginTime_Minute]
		,	[EndTime_Hour]
		,	[EndTime_Minute]
		,	[LevelLimit]
		,	[iValue01]
		,	[iValue02]
		,	[iBalanceLevelMin]
		,	[iBalanceLevelMax]
	FROM [dbo].[TB_DefPvPTime] WITH(NOLOCK)
END
