USE [DR2_User]
GO

IF EXISTS( SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[up_UPDATE_Guild_Exp_Level2]') AND  [type] in ('P') )
BEGIN
	DROP PROCEDURE [dbo].[up_UPDATE_Guild_Exp_Level2]
END

IF EXISTS( SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[up_UPDATE_Guild_Exp_Level]') AND  [type] in ('P') )
BEGIN
	DROP PROCEDURE [dbo].[up_UPDATE_Guild_Exp_Level]
END

/****** Object:  StoredProcedure [dbo].[up_UPDATE_Guild_Exp_Level2]    Script Date: 07/17/2009 12:39:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
////////////////////////////////////////////////////////////////////////
// Lasst Update by : 육정범
// Update date  : 2007-10-10
// Description : 길드 경험치/레벨 정보를 저장한다.
// [PARAMETER] : 
// [RETURN] : 
// [REMARK]
////////////////////////////////////////////////////////////////////////
*/
CREATE PROCEDURE [dbo].[up_UPDATE_Guild_Exp_Level]
(
	@CommandType tinyint,
	@GuildGuid UNIQUEIDENTIFIER,
	@CurrentLevel smallint,
	@CurrentExp bigint,
	@CurrentEmblem tinyint,
	@CurrentSkillPoint smallint,
	@CurrentSkills binary(200),
	@ExternInt int,
	@OperatorGuid UNIQUEIDENTIFIER
)
AS
SET NOCOUNT ON;
SET XACT_ABORT ON

DECLARE @Err int;
SET @Err = 0;

--길드 있는가?
IF NOT EXISTS(SELECT 1 FROM [DBO].[TB_Guild_Basic_Info] WHERE [GuildGuid] = @GuildGuid)
BEGIN
	SET @Err = 1; --step 1
	GOTO __rollback_tran;
END

--저장
UPDATE [DBO].[TB_Guild_Basic_Info]
	SET [CurrentLevel] = @CurrentLevel,
		[CurrentExp] = @CurrentExp,
		[Emblem] = @CurrentEmblem,
		[SkillPoint] = @CurrentSkillPoint,
		[Skills] = @CurrentSkills
	WHERE [GuildGuid] = @GuildGuid;
IF @@error <> 0
BEGIN
	SET @Err = 2; --step 2
	GOTO __rollback_tran;
END


__rollback_tran:
	SELECT @Err, @CommandType, @GuildGuid, @CurrentLevel, @CurrentExp, @CurrentSkillPoint, @CurrentSkills, @ExternInt, @OperatorGuid
	--RETURN @Err
	RETURN 

