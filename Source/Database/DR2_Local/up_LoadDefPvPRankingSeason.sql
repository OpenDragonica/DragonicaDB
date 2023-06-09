USE [DR2_Local]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_LoadDefPvPRankingSeason]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_LoadDefPvPRankingSeason]
GO

CREATE PROCEDURE [dbo].[up_LoadDefPvPRankingSeason]
/*
////////////////////////////////////////////////////////////////////////
//
// 프로시져명: [dbo].[up_LoadDefPvPRankingSeason]
// 작성자: YonMy(yonmy@barunsoninter.com)
// 작성일: 2009-11-26
// 파일명: 
////////////////////////////////////////////////////////////////////////
*/ 
AS
SET Nocount On;

BEGIN

DECLARE @tommorow datetime
SET @tommorow = CONVERT( char(10), DATEADD(day, 1, GETDATE()), 120 )

SELECT	TOP 1
		[Schedule]
	,	[Season_InitPoint]
	,	[Cycle_Pass]
	,	[Cycle_Day]
	,	[Cycle_PointRate]
	,	[Cycle_GivePoint]
FROM [dbo].[TB_DefPvPRankingSeason]
WHERE [Schedule] < @tommorow
ORDER BY [Schedule] DESC

END
GO
