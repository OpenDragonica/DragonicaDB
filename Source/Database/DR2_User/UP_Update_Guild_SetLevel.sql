USE [DR2_User]
GO

IF EXISTS( SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[UP_Update_Guild_SetLevel]') AND  [type] in ('P') )
BEGIN
	DROP PROCEDURE [dbo].[UP_Update_Guild_SetLevel]
END

/****** Object:  StoredProcedure [dbo].[UP_Update_Guild_SetLevel]    Script Date: 07/17/2009 12:39:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
////////////////////////////////////////////////////////////////////////
// Lasst Update by : 심헌섭
// Update date  : 2012-03-16
// Description : 길드 레벨 정보를 저장한다.
// [PARAMETER] : 
// [RETURN] : 
// [REMARK]
////////////////////////////////////////////////////////////////////////
*/
CREATE PROCEDURE [dbo].[UP_Update_Guild_SetLevel]
(
	@CommandType TINYINT,
	@GuildGuid UNIQUEIDENTIFIER,
	@CurrentLevel SMALLINT,
	@SkillPoint SMALLINT
)
AS
SET NOCOUNT ON;
SET XACT_ABORT ON

DECLARE @Err int;
SET @Err = 0;

--길드 있는가?
IF (NOT EXISTS(SELECT 1 FROM [DBO].[TB_Guild_Basic_Info] WHERE [GuildGuid] = @GuildGuid)) OR (EXISTS (SELECT 1 FROM [DBO].[TB_Guild_Basic_Info] WHERE [GuildGuid] = @GuildGuid AND [CurrentLevel] = @CurrentLevel))
BEGIN
	SET @Err = 1; --step 1
	GOTO __rollback_tran;
END

--저장
UPDATE [DBO].[TB_Guild_Basic_Info]
	SET [CurrentLevel] = @CurrentLevel,
		[SkillPoint] = @SkillPoint
	WHERE [GuildGuid] = @GuildGuid;
IF @@error <> 0
BEGIN
	SET @Err = 2; --step 2
	GOTO __rollback_tran;
END

DECLARE @CurrentExp BIGINT
DECLARE @CurrentSkills BINARY(200)

SELECT @CurrentLevel = CurrentLevel, @CurrentExp = CurrentExp, @SkillPoint = SkillPoint, @CurrentSkills = Skills
  FROM [dbo].[TB_Guild_Basic_Info]
 WHERE [GuildGuid] = @GuildGuid;
IF @@error <> 0
BEGIN
	SET @Err = 3; --step 3
	GOTO __rollback_tran;
END

__rollback_tran:
	SELECT @Err, @CommandType, @GuildGuid, @CurrentLevel, @CurrentExp, @SkillPoint, @CurrentSkills, 0, '00000000-0000-0000-0000-000000000000'
	--RETURN @Err
	RETURN 

