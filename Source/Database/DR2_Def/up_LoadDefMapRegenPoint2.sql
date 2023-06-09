USE [DR2_Def]
GO

/****** Object:  StoredProcedure [dbo].[up_LoadDefMapRegenPoint2]    Script Date: 03/26/2009 15:41:02 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_LoadDefMapRegenPoint2]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_LoadDefMapRegenPoint2]

/****** Object:  StoredProcedure [dbo].[up_LoadDefMapRegenPoint2]    Script Date: 03/26/2009 15:30:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[up_LoadDefMapRegenPoint2]
/*
////////////////////////////////////////////////////////////////////////
//
// 프로시져명: [dbo].[up_LoadDefMapRegenPoint2]
// 작성자: 김승현
// 작성일: 2009-03-26
// 최종수정자:
// 수정일: 
// 파일명: 
// N O T E : Loading Monster Regen Pointer table 
//
//	2009-03-26 : Eric Kim, [Direction] tinyint  추가
*/
AS
SET Nocount On;
begin
	SELECT 
		[MapNo]
		,[ParentBagType]
		,[ParentBagNo]
		,[PointGuid]
		,[PointGroup]
		,[RegenPeriod]
		,[PosX] 
		,[PosY] 
		,[PosZ] 
		,[MoveRange]
		,[Direction]
		FROM [dbo].[TB_DefMapMonsterRegen_01] WITH(NOLOCK)

	SELECT 
		[MapNo]
		,[ParentBagType]
		,[ParentBagNo]
		,[PointGuid]
		,[PointGroup]
		,[RegenPeriod]
		,[PosX] 
		,[PosY] 
		,[PosZ] 
		,[MoveRange]
		,[Direction]
		FROM [dbo].[TB_DefMapMonsterRegen_02] WITH(NOLOCK)

	SELECT 
		[MapNo]
		,[ParentBagType]
		,[ParentBagNo]
		,[PointGuid]
		,[PointGroup]
		,[RegenPeriod]
		,[PosX] 
		,[PosY] 
		,[PosZ] 
		,[MoveRange]
		,[Direction]
		FROM [dbo].[TB_DefMapMonsterRegen_03] WITH(NOLOCK)

	SELECT 
		[MapNo]
		,[ParentBagType]
		,[ParentBagNo]
		,[PointGuid]
		,[PointGroup]
		,[RegenPeriod]
		,[PosX] 
		,[PosY] 
		,[PosZ] 
		,[MoveRange]
		,[Direction]
		FROM [dbo].[TB_DefMapMonsterRegen_04] WITH(NOLOCK)
		
	SELECT 
		[MapNo]
		,[ParentBagType]
		,[ParentBagNo]
		,[PointGuid]
		,[PointGroup]
		,[RegenPeriod]
		,[PosX] 
		,[PosY] 
		,[PosZ] 
		,[MoveRange]
		,[Direction]
		FROM [dbo].[TB_DefMapMonsterRegen_11] WITH(NOLOCK)
		
	SELECT 
		[MapNo]
		,[ParentBagType]
		,[ParentBagNo]
		,[PointGuid]
		,[PointGroup]
		,[RegenPeriod]
		,[PosX] 
		,[PosY] 
		,[PosZ] 
		,[MoveRange]
		,[Direction]
		FROM [dbo].[TB_DefMapInsItemRegen_01] WITH(NOLOCK)

end








