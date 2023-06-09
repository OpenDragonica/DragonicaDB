USE [DR2_Local]
GO
/****** Object:  StoredProcedure [dbo].[up_LoadDefPvPLeagueTime]    Script Date: 06/07/2010 14:18:36 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_LoadDefPvPLeagueTime]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_LoadDefPvPLeagueTime]
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
CREATE PROCEDURE [dbo].[up_LoadDefPvPLeagueTime] 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT [WeekOfDay]
      ,[LeagueState]
      ,[LeagueLevel]
      ,[BeginTime_Hour]
      ,[BeginTime_Minute]
      ,[EndTime_Hour]
      ,[EndTime_Minute]
  FROM [dbo].[TB_PvPLeague_Time]
END
