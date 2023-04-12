USE [DR2_User]
IF EXISTS(SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'up_LoadMissionRank'))
BEGIN
	DROP Proc [dbo].[up_LoadMissionRank]
END
GO


/****** Object:  StoredProcedure [dbo].[up_LoadMissionRank]    Script Date: 03/31/2009 14:04:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/*
////////////////////////////////////////////////////////////////////////
//	2009-01-22 : Eric Kim, 30�� �̻�� Ranking ������ �ڵ����� �����
////////////////////////////////////////////////////////////////////////
*/
CREATE Proc [dbo].[up_LoadMissionRank]
(
	@MissionKey int,
	@Level tinyint
)
AS
SET NOCOUNT ON
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
BEGIN

	/* --------------------------------------------------- */
	-- ������ Ranking �� ��������.
	/* --------------------------------------------------- */
	DECLARE @Count int
	DECLARE @MinCount int
	DECLARE @Today datetime

	SET @MinCount = 5;	-- �ּ��� ������ Ranking�� ���ܵ���
	SET @ToDay = GetDate()

	SELECT @Count=COUNT(*)  FROM [dbo].[TB_Mission_Rank] WHERE [MissionKey]=@MissionKey and [Level]=@Level GROUP BY [MissionKey], [Level]
	IF @Count > @MinCount
	BEGIN
		DELETE FROM [dbo].[TB_Mission_Rank]
			WHERE [IDX] in (
				SELECT TOP (@Count-@MinCount) [IDX] FROM [dbo].[TB_Mission_Rank] 
					WHERE [MissionKey] = @MissionKey 
					and [Level] = @Level
					and DATEDIFF(d, [Date], @Today) > 30
					ORDER BY [Date] ASC
			)
	END

	/* --------------------------------------------------- */
	-- Ranking ���� �о� ����
	/* --------------------------------------------------- */
	DECLARE @Err int
	SET @Err = 0
	SELECT TOP 10
		A.[MissionKey],
		A.[Level],
		A.[Point],
		A.[PlayTime],
		A.[CharacterID],
		B.[Name],
		A.[Memo],
		A.[UserLevel],
		A.[Class],
		A.[Date]
		FROM [dbo].[TB_Mission_Rank] AS A
		INNER JOIN [dbo].[TB_CharacterBasic] AS B on A.[CharacterID] = B.[CharacterID]
		WHERE [MissionKey] = @MissionKey AND [Level] = @Level 
		ORDER BY Point DESC, PlayTime ASC

	IF @@rowcount <> 0
	BEGIN
		return @Err
	END

	SET @Err = 1001
	return @Err
END




GO