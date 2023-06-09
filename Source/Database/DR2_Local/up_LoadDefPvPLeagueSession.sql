USE [DR2_Local]
GO
/****** Object:  StoredProcedure [dbo].[up_LoadDefPvPLeagueSession]    Script Date: 06/07/2010 14:18:36 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_LoadDefPvPLeagueSession]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_LoadDefPvPLeagueSession]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[up_LoadDefPvPLeagueSession] 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT [Session]
      ,[GameMode]
      ,[GameType]
      ,[GameTime]
  FROM [dbo].[TB_PvPLeague_Session]
END