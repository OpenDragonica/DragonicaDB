--USE [DR2_User]

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_DeleteUserCharacter]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[up_DeleteUserCharacter]
END
GO
/****** Object:  StoredProcedure [dbo].[up_DeleteUserCharacter]    Script Date: 03/30/2009 19:51:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[up_DeleteUserCharacter]
/*
////////////////////////////////////////////////////////////////////////
//
// 프로시져명 : 캐릭터 삭제 / 복구
// 작 성 자 : 
// 작 성 일 : 
// 최종수정자 : YonMy
// 수 정 일 : 2008-02-17
// 담 당 자 : 
// N O T E :
//[PARAMETER] : 
//	@CharacterGuid : character guid to delete
//	@IsDeath :
//		== 1 (삭제하기),
//		== 0 (Character 복구하기)
//	@Name : 복구할때, 복구될 Character Nickname
//	@Mode :
//		(삭제 할때)
//				== 0 : DB 에서 지우지는 않고, [Name] = NULL 로만 세팅 (복구가능)
//				== 1 : DB 에서 정말로 지우기
//				== 2 : DB 에서 지우지는 않고, [Name] 그대로 유지, 지웠다고 표시만 하기
//		(복구 할때)
//				== 0 : 캐릭터 이름 중복 체크를 삭제된 캐릭터 명도 검사 (복구전에 사용하던 캐릭터 명 사용할 수 있도록 하기)
//				== 2 : 캐릭터 이름 중복 체크를 정상 캐릭터에서만 검사 (삭제 후 캐릭터 이름 바로 사용할 수 있게 하기)
// [RETURN] : 
// [REMARK]
//		Return Code 가 서버에서 정의된 에러코드와 맞추어져 있다.
//
//	2009-01-26 : Eric Kim, @Mode=2 추가 
//	2009-02-17 : YonMy, Return값에 Gender 추가
//	2009-02-23 : Eric Kim, Character 복구할 때, 복구하려는 Character Name과 동일한 이름 사용하면 오류 나던 것 수정
//	2009-04-22 : Eric Kim, 캐릭터 복구 옵션(위에 Parameter 설명 참조)
////////////////////////////////////////////////////////////////////////
*/
(
	@CharacterGuid	uniqueidentifier,
	@IsDeath		int,
	@Name			nvarchar(20),
	@Mode			int
)
AS
BEGIN TRAN
	SET NOCOUNT ON;

	DECLARE @ErrNo int
	DECLARE @OrgName nvarchar(20)
	DECLARE @Class smallint
	DECLARE @LV	smallint
	DECLARE @Exp bigint
	DECLARE @Gender tinyint
	DECLARE @GuildGuid UNIQUEIDENTIFIER
	DECLARE @CoupleGuid UNIQUEIDENTIFIER
	DECLARE @NullGuid UNIQUEIDENTIFIER
	SET @ErrNo = 0
	SET @NullGuid = N'00000000-0000-0000-0000-000000000000'

	----------------------------------------------------------------------------
	--	삭제 하기 @IsDeath = 1
	----------------------------------------------------------------------------
	IF @IsDeath = 1
	BEGIN
		--길드 정보 확인
		DECLARE @GuildMemberLevel int
		SELECT @CharacterGuid = [CharacterGuid], @GuildMemberLevel = [MemberLevel], @GuildGuid = ISNULL([GuildGuid], @NullGuid)
			FROM [dbo].[TB_Guild_Member] WHERE [CharacterGuid] = @CharacterGuid
		IF @GuildMemberLevel = 0
		BEGIN
			SET @ErrNo = 3;--길드 오너면 삭제 안되
			GOTO __rollback_tran
		END

		SELECT @OrgName = [Name], @Gender = [Gender] FROM [dbo].[TB_CharacterBasic] WHERE CharacterID = @CharacterGuid;
		SELECT @CoupleGuid = ISNULL([CoupleCharGuid], @NullGuid) FROM [dbo].[TB_UserCouple] WHERE CharacterGuid = @CharacterGuid;
		SELECT @Class = [Class], @Lv = [Lv], @Exp = [Exp] from [dbo].[TB_CharacterSub] where CharacterID = @CharacterGuid

		IF @Mode = 0	-- [Name] = NULL, [State] = 1
		BEGIN
			--삭제 (가상 삭제)
			UPDATE [dbo].[TB_CharacterBasic] 
				SET [Name] = N'__D__', [State] = 1, [DeleteDate] = GetDate() WHERE CharacterID = @CharacterGuid;
			IF @@rowcount <> 1
			BEGIN
				SET @ErrNo = 2;-- TB_UserCharacter 삭제실패
				GOTO __rollback_tran;
			END
			
			EXEC dbo.[UP_DeleteUserCharacterSub] @CharacterGuid, 0
		END
		---------------
		ELSE IF @Mode = 1	-- Character 정보 실제로 DB에서 삭제하기
		BEGIN
			EXEC dbo.[UP_DeleteUserCharacterSub] @CharacterGuid, 100
			IF @@error <> 0
			BEGIN
				SET @ErrNo = 2;-- TB_UserCharacter 삭제실패
				GOTO __rollback_tran;
			END
			DELETE [dbo].[TB_CharacterSub] WHERE CharacterID = @CharacterGuid;
			IF @@rowcount <> 1
			BEGIN
				SET @ErrNo = 2;-- TB_UserCharacter 삭제실패
				GOTO __rollback_tran;
			END
			DELETE [dbo].[TB_CharacterBasic] WHERE CharacterID = @CharacterGuid;
			IF @@rowcount <> 1
			BEGIN
				SET @ErrNo = 2;-- TB_UserCharacter 삭제실패
				GOTO __rollback_tran;
			END
		END
		---------------
		ELSE IF @Mode = 2	-- 삭제 : [Name] 유지하고, [State] = 1
		BEGIN
			UPDATE [dbo].[TB_CharacterBasic]
				SET [State] = 1, [DeleteDate] = GetDate()
				WHERE CharacterID = @CharacterGuid;
			IF @@rowcount <> 1
			BEGIN
				SET @ErrNo = 2;-- TB_UserCharacter 삭제실패
				GOTO __rollback_tran;
			END
			EXEC dbo.[UP_DeleteUserCharacterSub] @CharacterGuid, 0
		END
		---------------
		ELSE	-- @Mode <> (0,1,2)
		BEGIN
			SET @ErrNo = 2;-- TB_UserCharacter 삭제실패
			GOTO __rollback_tran;
		END

		--Record PlayTimeSec 삭제
		EXEC [dbo].[up_Delete_LevelUp_PlayTimeSec] @CharacterGuid
		SET @ErrNo = 1 --성공
		goto __commit_tran;
	END -- IF @IsDeath = 1

	----------------------------------------------------------------------------
	--	복구 하기 @IsDeath <> 1
	----------------------------------------------------------------------------
	ELSE
	BEGIN
		--일단 복구할 캐릭터가 있는지 찾는다.
		DECLARE @MemberId uniqueidentifier
		SET @MemberId = (select MemberID from [dbo].[TB_CharacterBasic] where CharacterID = @CharacterGuid)
		IF @MemberId = NULL
		BEGIN
			SET @ErrNo = 2-- 해당캐릭터없음
 			GOTO __rollback_tran
		END

		--캐릭터명 중복 검사
		IF @Mode = 2	-- 삭제된 캐릭터도 포함해서 검사 (복구이전의 캐릭터 명 그대로 사용하려고 할 때)
		BEGIN
			IF  EXISTS (select 1 from [dbo].[TB_CharacterBasic] where [Name] = @Name and [CharacterID] <> @CharacterGuid)
			begin
				set @ErrNo = 100-- 중복되는 캐릭터이름이 있음 (C소스와 에러번호 같음 CCR_OVERLAP_NAME)
				goto __rollback_tran
			end
		END
		ELSE	-- @Mode = 0 (삭제된 캐릭터명 바로 사용할 수 있도록 하기)
		BEGIN
			IF  EXISTS (select 1 from [dbo].[TB_CharacterBasic] where [Name] = @Name AND [CharacterID] <> @CharacterGuid AND [State] = 0)
			begin
				set @ErrNo = 100-- 중복되는 캐릭터이름이 있음 (C소스와 에러번호 같음 CCR_OVERLAP_NAME)
				goto __rollback_tran
			end
		END

		-- 캐릭터 생성된 카운트가 MAX값을 넘어가는지 확인한다.
		declare @count int
		set @count = 0
		select @count = count(*) from [dbo].[TB_CharacterBasic] where MemberID = @MemberID AND State = 0
		if @count > 4	-- 5 = 최대 캐릭터 보유수
		begin
			set @ErrNo = 200--캐릭터갯수 제한을 초과하였음(max : 5개) (C소스와 에러번호 같음 CCR_MAX_LIMINT)
			goto __rollback_tran
		end

		Update [dbo].[TB_CharacterBasic] 
			set [Name] = @Name, [State] = 0, [DeleteDate] = NULL where CharacterID = @CharacterGuid;
		IF @@error <> 0
		BEGIN
			Set @ErrNo = 3;--복구 실패
			goto __rollback_tran;
		END
		set @ErrNo = 1 --성공
		goto __commit_tran;
	END

__commit_tran:
BEGIN
	COMMIT TRAN
	IF @IsDeath = 1
		select @CharacterGuid, @ErrNo, @OrgName, @GuildGuid, @CoupleGuid, @Class, @LV, @Exp, @Gender
	ELSE
		select @CharacterGuid, @ErrNo
	return
END
__rollback_tran:
BEGIN
	ROLLBACK TRAN
	IF @IsDeath = 1
		select @CharacterGuid, @ErrNo, @OrgName, @GuildGuid, @CoupleGuid, @Class, @LV, @Exp, @Gender
	ELSE
		select @CharacterGuid, @ErrNo
	return
END


