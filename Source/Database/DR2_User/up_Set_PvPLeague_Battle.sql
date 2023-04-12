USE [DR2_User]
GO

/****** Object:  StoredProcedure [dbo].[up_Set_PvPLeague_Battle]    Script Date: 05/24/2010 15:29:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Set_PvPLeague_Battle]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[up_Set_PvPLeague_Battle]
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
CREATE PROCEDURE [dbo].[up_Set_PvPLeague_Battle]
(
	@BattleID [uniqueidentifier],
	@WinTeamNo [int]
)
AS
SET XACT_ABORT ON
SET NOCOUNT ON

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

BEGIN
	DECLARE @TeamID uniqueidentifier
	
	IF @WinTeamNo = 1 BEGIN
		SET @TeamID = (SELECT [TeamGuid1] FROM [dbo].[TB_PvPLeague_Battle] WHERE [BattleGuid] = @BattleID)
	END
	ELSE BEGIN
		SET @TeamID = (SELECT [TeamGuid2] FROM [dbo].[TB_PvPLeague_Battle] WHERE [BattleGuid] = @BattleID)
	END
	
	IF @TeamID IS NOT NULL	
	BEGIN
		UPDATE [dbo].[TB_PvPLeague_Battle]
		SET [WinTeamGuid] = @TeamID
		WHERE [BattleGuid] = @BattleID
	END
	
	SELECT @BattleID, @TeamID
END	

