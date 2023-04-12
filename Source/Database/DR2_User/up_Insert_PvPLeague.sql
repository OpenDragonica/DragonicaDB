USE [DR2_User]
GO

/****** Object:  StoredProcedure [dbo].[up_Insert_PvPLeague]    Script Date: 05/24/2010 15:29:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Insert_PvPLeague]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[up_Insert_PvPLeague]
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
CREATE PROCEDURE [dbo].[up_Insert_PvPLeague]
	@SessionNo [int]
AS
SET XACT_ABORT ON
SET NOCOUNT ON

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
BEGIN
	DECLARE @LeagueID uniqueidentifier
	DECLARE @NowDate datetime
	SET @LeagueID = NEWID()
	SET @NowDate = GetDate()
	
	INSERT INTO [dbo].[TB_PvPLeague] ([LeagueGuid], [TounamentGuid], [LeagueState], [RegistDate], [Session])
		 VALUES (@LeagueID, NULL, 0, @NowDate, @SessionNo )
	
	SELECT @LeagueID, @NowDate
END	

