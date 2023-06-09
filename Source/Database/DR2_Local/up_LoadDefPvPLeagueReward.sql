USE [DR2_Local]
GO
/****** Object:  StoredProcedure [dbo].[up_LoadDefPvPLeagueReward]    Script Date: 06/07/2010 14:18:36 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_LoadDefPvPLeagueReward]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_LoadDefPvPLeagueReward]
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
CREATE PROCEDURE [dbo].[up_LoadDefPvPLeagueReward] 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT [LeagueLevel]
      ,[ItemNo1]
      ,[ItemCount1]
      ,[ItemNo2]
      ,[ItemCount2]
      ,[ItemNo3]
      ,[ItemCount3]
      ,[ItemNo4]
      ,[ItemCount4]
      ,[ItemNo5]
      ,[ItemCount5]
  FROM [dbo].[TB_PvPLeague_Reward]
END
