USE [DR2_Def]
GO
/****** Object:  StoredProcedure [dbo].[up_LoadDefPvPGroundMode]    Script Date: 01/20/2010 18:14:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_LoadDefPvPGroundMode]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_LoadDefPvPGroundMode]
GO

CREATE PROCEDURE [dbo].[up_LoadDefPvPGroundMode]
AS

BEGIN
	SELECT	[GroundNo], [NameNo], [UseType], [PreviewImg], [UserCount]
	FROM [dbo].[TB_DefPvPGroundMode] WITH(NOLOCK)
END