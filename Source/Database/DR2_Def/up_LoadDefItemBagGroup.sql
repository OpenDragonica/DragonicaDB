USE [DR2_Def]
GO
/****** Object:  StoredProcedure [dbo].[up_LoadDefItemBagGroup]    Script Date: 06/03/2010 16:33:38 ******/

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_LoadDefItemBagGroup]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_LoadDefItemBagGroup]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[up_LoadDefItemBagGroup]
AS
BEGIN
	SELECT f_NationCodeStr, BagGroupNo, SuccessRateNo, BagNo01, BagNo02, BagNo03, BagNo04, BagNo05,
		BagNo06, BagNo07, BagNo08, BagNo09, BagNo10 FROM [dbo].[TB_DefItemBagGroup] WITH(NOLOCK)
end
