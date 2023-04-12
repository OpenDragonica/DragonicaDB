USE [DR2_Def]
GO
/****** Object:  StoredProcedure [dbo].[up_LoadDefMonsterBag]    Script Date: 01/19/2010 15:19:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_LoadDefMonsterBag]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_LoadDefMonsterBag]
GO

CREATE Proc [dbo].[up_LoadDefMonsterBag]
AS
BEGIN
	SELECT [BagNo],[ElementNo],[SuccessRateNo],[TunningNo_Min],[TunningNo_Max] FROM dbo.TB_DefMonsterBag WITH(NOLOCK)
END



