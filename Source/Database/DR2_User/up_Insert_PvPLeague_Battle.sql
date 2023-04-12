USE [DR2_User]
GO

/****** Object:  StoredProcedure [dbo].[up_Insert_PvPLeague_Battle]    Script Date: 05/24/2010 15:29:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Insert_PvPLeague_Battle]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[up_Insert_PvPLeague_Battle]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
////////////////////////////////////////////////////////////////////////
//
// ���ν����� : PvP Laegue ���� �߰�
// �� �� �� : codenavy
// �� �� �� : 2009-06-10
// ���������� : 
// �� �� �� : 
// �� �� �� : codenavy
// N O T E : 
// 2010-05-24, codenavy PvP Laegue ���� �߰�
////////////////////////////////////////////////////////////////////////
*/

CREATE PROCEDURE [dbo].[up_Insert_PvPLeague_Battle]
(
	@TournamentID [uniqueidentifier],
	@BattleID [uniqueidentifier],
	@TournamentIdx [int],
	@TeamID1 [uniqueidentifier],
	@TeamID2 [uniqueidentifier],
	@GroupIdx [int],
	@LeagueID [uniqueidentifier],
	@LeagueLv [int]
)
AS
SET XACT_ABORT ON
SET NOCOUNT ON

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

BEGIN
	INSERT INTO [dbo].[TB_PvPLeague_Battle] ([TournamentGuid], [BattleGuid], [TournamentIndex], [TeamGuid1], [TeamGuid2], [WinTeamGuid], [GroupIndex])
		 VALUES (@TournamentID, @BattleID, @TournamentIdx, @TeamID1, @TeamID2, NULL, @GroupIdx)
	
	UPDATE [dbo].[TB_PvPLeague_Team]
	SET [LeagueLevel] = @LeagueLv
	WHERE [LeagueGuid] = @LeagueID
	  AND (  (@TeamID1 IS NOT NULL AND [TeamGuid] = @TeamID1) 
		  OR (@TeamID2 IS NOT NULL AND [TeamGuid] = @TeamID2) )

	SELECT @LeagueLv, @TeamID1, @TeamID2
END	

