USE [DR2_User]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_ClearMissionRank]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_ClearMissionRank]
GO

CREATE PROCEDURE [dbo].[up_ClearMissionRank]
/*
////////////////////////////////////////////////////////////////////////
//
// ���ν����� : [up_ClearMissionRank]
// �� �� �� : YonMy
// �� �� �� : 2009-03-31
// ���������� : 
// �� �� �� : 
// �� �� �� : YonMy
// N O T E : 
//	      ���� : Def_Mission ���� �ϴ°� ���� 
////////////////////////////////////////////////////////////////////////
*/
(
	@No		int
)
AS
Set Nocount on
Set Xact_Abort On

DECLARE @Err int
Set @Err = 0

BEGIN
	DECLARE @MissionKey int
	SET @MissionKey = @No
	
	IF @No < 0
	BEGIN
		TRUNCATE TABLE [dbo].[TB_Mission_Rank]
	END
	ELSE
	BEGIN
		DELETE FROM [dbo].[TB_Mission_Rank]
		WHERE [MissionKey] = @No
	END
END	
RETURN @Err
