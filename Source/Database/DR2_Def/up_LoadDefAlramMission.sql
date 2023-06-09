USE [DR2_Def]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_LoadDefAlramMission]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[up_LoadDefAlramMission]
END
GO

CREATE PROCEDURE [dbo].[up_LoadDefAlramMission]
/*
////////////////////////////////////////////////////////////////////////
//
// 프로시져명 : up_LoadDefAlramMission
// 작 성 자 : YonMy
// 작 성 일 : 2010-02-10
// 최종수정자 : 하승봉
// 수 정 일 : 2011-06-21
// 담 당 자 : 
// N O T E : 용족용 클래스구분 필드 추가에 따른 스크립트 수정
////////////////////////////////////////////////////////////////////////
*/
AS
SET XACT_ABORT ON
SET NOCOUNT ON
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

BEGIN
	SELECT	[AlramID]
		,	[Type]
		,	[TitleNo]
		,	[AlramID_Next]
		,	[IsDraClass]
		,	[ClassLimit]
		,	[Time]
		,	[Point]
		,	[Exp]
		,	[Effect]
		,	[ItemBag01]
		,	[ItemBag02]
	FROM [dbo].[TB_DefAlramMission]
	
	SELECT	[AlramID]
		,	[DiscriptionNo]
		,	[ActionType]
		,	[ObjectType]
		,	[ObjectValue]
		,	[Count]
		,	[IsFail]
	FROM [dbo].[TB_DefAlramMission_Action]
END
GO
