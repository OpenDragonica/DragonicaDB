USE [DR2_Def]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_LoadDefGamble]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_LoadDefGamble]

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[up_LoadDefGamble]
/*
////////////////////////////////////////////////////////////////////////
//
// ���ν����� : [up_LoadDefGamble]
// �� �� �� : 
// �� �� �� : 
// ���������� :
// �� �� �� : 
// �� �� �� : 
// N O T E : 
//	2009-07-08, YonMy, EnchantCtrl �߰�
////////////////////////////////////////////////////////////////////////
*/
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


SELECT [GambleNo]
      ,[ContainerNo]
      ,[TimeType]
      ,[TimeValue]
      ,[RarityCtrl]
      ,[PlusUpCtrl]
  FROM [dbo].[TB_DefGamble]

SELECT 	[GambleNo]
	,[ItemNo]
      	,[Grade]
  FROM [dbo].[TB_DefGambleShoutItem]
  
END


