USE [DR2_User]
GO

IF EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Guild_Proc_Delete]') AND [type] in (N'P'))
BEGIN
	DROP PROCEDURE [dbo].[up_Guild_Proc_Delete]
END
GO

/****** Object:  StoredProcedure [dbo].[up_Guild_Proc_Delete]    Script Date: 11/04/2009 16:28:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
////////////////////////////////////////////////////////////////////////
// Description : 길드 생성/삭제 프로시져
// [PARAMETER] : 
// [RETURN] : 
// [REMARK]
//	2008-08-17 : 임상우, 시작
//	2008-09-10 : 생성시 엠블렘 지정 할 수 있도록 수정
//	2008-10-07 : Eric Kim, CharacterDB 두개로 분리된 것 적용
//	2008-12-01 : 육정범, SELECT COUNT(*) FROM XXX -> SELECT count(1) FROM XXX 쿼리로 변경
////////////////////////////////////////////////////////////////////////
*/
CREATE PROCEDURE [dbo].[up_Guild_Proc_Delete]
(
	@CommandType tinyint,
	@GuildGuid uniqueidentifier,
	@MasterCharGuid uniqueidentifier = NULL,
	@GuildName nvarchar(30) = NULL,
	@GuildEmblem tinyint = NULL,
	@GradeName1 nvarchar(20) = NULL,
	@GradeName2 nvarchar(20) = NULL,
	@GradeName3 nvarchar(20) = NULL,
	@GradeName4 nvarchar(20) = NULL,
	@GradeName5 nvarchar(20) = NULL
)
AS
SET XACT_ABORT ON
SET Nocount On;

DECLARE @Err int;
DECLARE @TempMasterChararacterGuid UNIQUEIDENTIFIER;
SET @Err = 0;


--1.길드가 있는지 확인
IF NOT EXISTS (	SELECT 1 FROM [DBO].[TB_Guild_Basic_Info] WHERE [GuildGuid] = @GuildGuid )
BEGIN
	SET @Err = 2;--step 2
	SELECT @Err, @CommandType, @GuildGuid, @GuildName
	RETURN 
END

SELECT @TempMasterChararacterGuid = MasterCharacterGuid FROM [DBO].[TB_Guild_Basic_Info] WHERE [GuildGuid] = @GuildGuid

--2.맴버가 남지 않았는지 확인
IF (SELECT count(1) FROM [DBO].[TB_Guild_Member] WHERE [GuildGuid] = @GuildGuid) > 1
BEGIN
	SET @Err = 3; --step3
	SELECT @Err, @CommandType, @GuildGuid, @GuildName
	RETURN 
END

BEGIN TRAN
	DECLARE @ToDay Datetime
	SET @ToDay = GetDate()
	exec dbo.UP_UPDATE_TB_UserCharacter_DateContents @TempMasterChararacterGuid, N'f_GuildLeaveDate', @ToDay
	IF @@error <> 0
	BEGIN
		SET @Err = 31; --step4
		GOTO __rollback_tran;
	END

	-- Mercenary 삭제
	DELETE FROM [dbo].[TB_Guild_Set_Mercenary] WHERE [GuildGuid] = @GuildGuid
	
	--3. Member 몽땅 삭제
	DELETE FROM [DBO].[TB_Guild_Member] WHERE [GuildGuid] = @GuildGuid
	IF @@error <> 0
	BEGIN
		SET @Err = 4; --step4
		GOTO __rollback_tran;
	END

	--4. Member Grade 정보 삭제
	DELETE FROM [DBO].[TB_Guild_Member_Grade] WHERE [GuildGuid] = @GuildGuid
	IF @@error <> 0
	BEGIN
		SET @Err = 5;--step5
		GOTO __rollback_tran;
	END

	--5. Extern Info 삭제
	DELETE FROM [DBO].[TB_Guild_Extern_Info] WHERE [GuildGuid] = @GuildGuid
	IF @@error <> 0
	BEGIN
		SET @Err = 6;--step6
		GOTO __rollback_tran;
	END

	-- 6.Basic Info 삭제
	DELETE FROM [DBO].[TB_Guild_Basic_Info] WHERE [GuildGuid] = @GuildGuid
	IF @@error <> 0
	BEGIN
		SET @Err = 7;
		GOTO __rollback_tran;
	END
	
	-- 7. 길드게시판에서 제거
	DELETE FROM [DBO].[TB_Guild_EntranceOpen] WHERE [GuildGuid] = @GuildGuid
	IF @@error <> 0
	BEGIN
		SET @Err = 8;
		GOTO __rollback_tran;
	END
	
	--8. 길드금고의 아이템 삭제
	DELETE FROM [dbo].[TB_UserItem] WHERE [OwnerGUID] = @GuildGuid
	IF @@error <> 0
	BEGIN
		SET @Err = 9;
		GOTO __rollback_tran;
	END

	COMMIT TRAN
	SELECT @Err, @CommandType, @GuildGuid, @GuildName
	RETURN 

__rollback_tran:
BEGIN
	ROLLBACK TRAN
	SELECT @Err, @CommandType, @GuildGuid, @GuildName
	RETURN 
END
