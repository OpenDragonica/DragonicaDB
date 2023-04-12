USE [DR2_User]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_SelectCharacterLevel_Rank]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[up_SelectCharacterLevel_Rank]
END
GO

CREATE PROCEDURE [dbo].[up_SelectCharacterLevel_Rank]
/*
////////////////////////////////////////////////////////////////////////
//
// ���ν����� : �ش� ���� �ɸ����� Level Ranking
// �� �� �� : YonMy(yonmy@barunsoninter.com)
// �� �� �� : 2009-01-18
// ���������� : 
// �� �� �� : 
// �� �� �� : 
// N O T E : 
//
////////////////////////////////////////////////////////////////////////
*/
(
	@MemberID	uniqueidentifier
,	@Lv			smallint
)
AS
SET NOCOUNT ON
SET XACT_ABORT ON
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

BEGIN
	
	SELECT	COUNT(A.CharacterID)
	FROM	[dbo].[TB_CharacterBasic] AS A
		INNER JOIN [dbo].[TB_CharacterSub] AS B
			ON A.[CharacterID] = B.[CharacterID]
	WHERE	A.[MemberID] = @MemberID AND A.[State] <> 1 AND B.[Lv] > @Lv

END

