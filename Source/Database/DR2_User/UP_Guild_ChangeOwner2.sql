USE [DR2_User]
GO

IF EXISTS(SELECT 1 FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Guild_ChangeOwner2]'))
BEGIN
	DROP PROCEDURE [dbo].[up_Guild_ChangeOwner2]
END
IF EXISTS(SELECT 1 FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Guild_ChangeOwner]'))
BEGIN
	DROP PROCEDURE [dbo].[up_Guild_ChangeOwner]
END

/****** Object:  StoredProcedure [dbo].[up_Guild_ChangeOwner]    Script Date: 04/08/2009 14:00:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- =============================================
-- Author:		육정범
-- Create date: 2008. 7. 15
-- Description:	길드 마스터(소유자)를 변경한다.
--	2008-10-07 : Eric Kim, CharacterDB 가 두개로 나누어 진 것 적용
-- =============================================
*/
CREATE PROCEDURE [dbo].[up_Guild_ChangeOwner]
@CmdType INT,
@GuildGuid UNIQUEIDENTIFIER,
@OldGuildOwner UNIQUEIDENTIFIER,
@OldOwnerGrade tinyint,
@NewGuildOwner UNIQUEIDENTIFIER,
@NewOwnerGrade tinyint
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @Err int
	SET @Err = 0

	IF not exists( SELECT 1 FROM [dbo].[TB_Guild_Basic_Info] WHERE [GuildGuid] = @GuildGuid AND [MasterCharacterGuid] = @OldGuildOwner)
	BEGIN
		SET @Err = 1
		GOTO __ERROR_RETURN;
	END

	IF @OldGuildOwner = @NewGuildOwner
	BEGIN
		SET @Err = 9
		GOTO __ERROR_RETURN;
	END

	IF not exists( SELECT 1 FROM [dbo].[TB_CharacterBasic] WHERE [CharacterID] = @OldGuildOwner AND [State] = 0)
	BEGIN
		SET @Err = 2
		GOTO __ERROR_RETURN;
	END

	IF not exists( SELECT 1 FROM [dbo].[TB_CharacterBasic] WHERE [CharacterID] = @NewGuildOwner AND [State] = 0)
	BEGIN
		SET @Err = 3
		GOTO __ERROR_RETURN;
	END

BEGIN TRAN
	UPDATE [dbo].[TB_Guild_Member] SET [MemberLevel] = @OldOwnerGrade WHERE CharacterGuid = @OldGuildOwner
	IF @@error <> 0
	BEGIN
		SET @Err = 4
		GOTO __ROLBACK_TRAN;
	END

	UPDATE [dbo].[TB_Guild_Member] SET [MemberLevel] = @NewOwnerGrade WHERE CharacterGuid = @NewGuildOwner
	IF @@error <> 0
	BEGIN
		SET @Err = 5
		GOTO __ROLBACK_TRAN;
	END
	
	UPDATE [dbo].[TB_Guild_Basic_Info] SET [MasterCharacterGuid] = @NewGuildOwner WHERE [GuildGuid] = @GuildGuid
	IF @@error <> 0
	BEGIN
		SET @Err = 6
		GOTO __ROLBACK_TRAN;
	END
	
	GOTO __COMMIT_TRAN;
END

__ERROR_RETURN:
BEGIN
	SELECT @Err, @CmdType, @NewGuildOwner, @OldGuildOwner;
	return
END

__COMMIT_TRAN:
BEGIN
	COMMIT TRAN;
	SELECT @Err, @CmdType, @NewGuildOwner, @OldGuildOwner;
	return
END
__ROLBACK_TRAN:
BEGIN
	ROLlBACK TRAN;
	SELECT @Err, @CmdType, @NewGuildOwner, @OldGuildOwner;
	return
END
