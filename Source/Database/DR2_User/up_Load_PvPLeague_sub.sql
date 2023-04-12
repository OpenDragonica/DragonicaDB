USE [DR2_User]
GO

/****** Object:  StoredProcedure [dbo].[up_Load_PvPLeague_sub]    Script Date: 05/24/2010 15:29:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Load_PvPLeague_sub]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[up_Load_PvPLeague_sub]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
////////////////////////////////////////////////////////////////////////
//
// ���ν����� : PvP Laegue sub �ҷ�����(����On�ÿ� �ѹ� ���)
// �� �� �� : codenavy
// �� �� �� : 2009-06-10
// ���������� : 
// �� �� �� : 
// �� �� �� : codenavy
// N O T E : 
// 2010-05-24, codenavy PvP Laegue ���� �ε��ϰ� �߰�
////////////////////////////////////////////////////////////////////////
*/
CREATE PROCEDURE [dbo].[up_Load_PvPLeague_sub]
	@LeagueID [uniqueidentifier]
AS
SET XACT_ABORT ON
SET NOCOUNT ON

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

BEGIN
DECLARE @Err int

SET @Err = 0

	-- 1. TB_PvPLeague_Team
	SELECT TEAM.[TeamGuid]
		  ,TEAM.[TeamName]
		  ,TEAM.[UserGuid1]
		  ,(SELECT [Name] FROM [dbo].[TB_CharacterBasic] WHERE [CharacterID]= TEAM.[UserGuid1])
		  ,TEAM.[UserGuid2]
		  ,(SELECT [Name] FROM [dbo].[TB_CharacterBasic] WHERE [CharacterID]= TEAM.[UserGuid2])
		  ,TEAM.[UserGuid3]
	      ,(SELECT [Name] FROM [dbo].[TB_CharacterBasic] WHERE [CharacterID]= TEAM.[UserGuid3])
		  ,TEAM.[UserGuid4]
		  ,(SELECT [Name] FROM [dbo].[TB_CharacterBasic] WHERE [CharacterID]= TEAM.[UserGuid4])
		  ,TEAM.[RegistDate]
		  ,TEAM.[TournamentIndex]
		  ,TEAM.[LeagueLevel]
		  ,TEAM.[Point]
	FROM [dbo].[TB_PvPLeague_Team] AS TEAM
	WHERE TEAM.[LeagueGuid] = @LeagueID
	
	-- 2. TB_PvPLeague_Battle
	SELECT BATTLE.[BattleGuid]
		  ,BATTLE.[TournamentGuid]
		  ,BATTLE.[TournamentIndex]
		  ,BATTLE.[TeamGuid1]
		  ,BATTLE.[TeamGuid2]
		  ,BATTLE.[WinTeamGuid]
		  ,BATTLE.[GroupIndex]
	FROM [dbo].[TB_PvPLeague_Battle] AS BATTLE
	INNER JOIN [dbo].[TB_PvPLeague_Tournament] AS TOURNAMENT ON BATTLE.[TournamentGuid] = TOURNAMENT.[TournamentGuid]
	WHERE TOURNAMENT.[LeagueGuid] = @LeagueID
	
	-- 2. TB_PvPLeague_Tournament
	SELECT [TournamentGuid]
		  ,[LeagueLevel]
		  ,[GameType]
		  ,[GameMode]
		  ,[GameTime]
		  ,[BeginTime]
	FROM [dbo].[TB_PvPLeague_Tournament]
	WHERE [LeagueGuid] = @LeagueID

	RETURN @Err
END	

