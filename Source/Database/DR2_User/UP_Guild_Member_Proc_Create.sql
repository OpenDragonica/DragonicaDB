USE [DR2_User]
GO
/****** Object:  StoredProcedure [dbo].[up_Guild_Member_Proc_Create]    Script Date: 10/26/2009 10:27:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
////////////////////////////////////////////////////////////////////////
// Lasst Update by : 육정범
// Update date  : 2008-10-21
// Description : 길드원 추가 프로시져 Step. 1
// [PARAMETER] : 
// [RETURN] : 
// [REMARK]
//	2008-10-21 : 육정범, CREATE, DELETE, MODIFY로 나눔
//	2008-10-07 : Eric Kim, Character DB 가 두개로 나누어진것 적용
//	2008-06-30 : 육정범
////////////////////////////////////////////////////////////////////////
*/
ALTER PROCEDURE [dbo].[up_Guild_Member_Proc_Create]
(
	@CommandType tinyint,
	@GuildGuid UNIQUEIDENTIFIER,
	@CharGuid UNIQUEIDENTIFIER,
	@MemberLevel tinyint = 0
)
AS
	Set Nocount On
	DECLARE @Err int;
	SET @Err = 0;

	--캐릭터가 있나
	IF NOT EXISTS (	SELECT 1 FROM [DBO].[TB_CharacterBasic] WHERE [CharacterID] = @CharGuid )
	BEGIN
		SET @Err = 1; --Step1
		GOTO ErrorHandler;
	END
	--길드가 있나
	IF NOT EXISTS ( SELECT 1 FROM [DBO].[TB_Guild_Basic_Info] WHERE [GuildGuid] = @GuildGuid )
	BEGIN
		SET @Err = 1; --step 1
		GOTO ErrorHandler;
	END

	DECLARE @Today DATETIME
	SET @Today = GetDate()
--	IF EXISTS (	SELECT 1 FROM [DBO].[TB_Guild_Member] WHERE [CharacterGuid] = @CharGuid )
--	BEGIN
--		-- 1. 이미 존재하는 것이므로 UPDATE
--		UPDATE [DBO].[TB_Guild_Member]
--			SET [GuildGuid] = @GuildGuid, [MemberLevel] = @MemberLevel, [f_LastLoginDate] = @Today
--			WHERE [CharacterGuid] = @CharGuid
--		IF @@error <> 0
--		BEGIN
--			SET @Err = 2; --step 2
--			GOTO ErrorHandler;
--		END
--	END
--	ELSE
--	BEGIN
		--	1. Guild Member 테이블에 행 추가
		INSERT [DBO].[TB_Guild_Member] ([CharacterGuid], [GuildGuid], [MemberLevel], [f_LastLoginDate])
			VALUES (@CharGuid, @GuildGuid, @MemberLevel, @Today)
		IF @@error <> 0
		BEGIN
			SET @Err = 2; --step 2
			GOTO ErrorHandler;
		END
--	END

ErrorHandler:
	SELECT @Err, @CommandType, @GuildGuid, @CharGuid, @MemberLevel
	RETURN 
