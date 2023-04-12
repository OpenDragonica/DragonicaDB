USE [DR2_Def]
GO

set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_LoadDefHiddenRewordBag]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[up_LoadDefHiddenRewordBag]
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[up_LoadDefHiddenRewordBag]
/*
////////////////////////////////////////////////////////////////////////
//
// ���ν����� : [up_LoadDefHiddenRewordBag]
// �� �� �� : 
// �� �� �� : 
// ���������� :
// �� �� �� : 
// �� �� �� : 
// N O T E : 
//	2010-01-19, ������
////////////////////////////////////////////////////////////////////////
*/
AS
BEGIN
	SET NOCOUNT ON;

	SELECT [RewordNo],[ContainerNo],[RarityCtrl],[PlusUpCtrl] FROM [dbo].[TB_DefHiddenRewordBag]
END

GO
