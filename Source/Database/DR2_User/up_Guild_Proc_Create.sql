USE [DR2_User]
GO
/****** Object:  StoredProcedure [dbo].[up_Guild_Proc_Create]    Script Date: 05/13/2010 17:33:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Guild_Proc_Create]') AND type in (N'P'))
BEGIN
	DROP PROCEDURE [dbo].[up_Guild_Proc_Create]
END
GO

/*
////////////////////////////////////////////////////////////////////////
// Description : ��� ����/���� ���ν���
// [PARAMETER] : 
// [RETURN] : 
// [REMARK]
//	2008-08-17 : �ӻ��, ����
//	2008-09-10 : ������ ���� ���� �� �� �ֵ��� ����
//	2008-10-07 : Eric Kim, CharacterDB �ΰ��� �и��� �� ����
////////////////////////////////////////////////////////////////////////
*/
CREATE PROCEDURE [dbo].[up_Guild_Proc_Create]
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
SET Nocount On;
SET XACT_ABORT ON

BEGIN TRAN
	DECLARE @Err int;
	SET @Err = 0;

--///////////////////////////// Create /////////////////////////////
	--1. ��� ����
	--  Basic Info ����
	--    Guid, �̸� �ߺ� �˻�
	IF EXISTS (	SELECT 1 FROM [DBO].[TB_Guild_Basic_Info] 
		WHERE 
		[GuildName] = @GuildName or
		[GuildGuid] = @GuildGuid or 
		[MasterCharacterGuid] = @MasterCharGuid
	)
	BEGIN
		SET @Err = 1;--Duplicate
		GOTO __rollback_tran;
	END

	INSERT INTO [DBO].[TB_Guild_Basic_Info]
		([GuildGuid], [MasterCharacterGuid], [GuildName], [CurrentLevel], [CurrentExp], [Emblem], [CreateDate], [TaxExpRate])
		VALUES (@GuildGuid, @MasterCharGuid, @GuildName, 1, 0, @GuildEmblem, GetDate(), 0);
	IF @@error <> 0
	BEGIN
		SET @Err = 2; --Step
		GOTO __rollback_tran;
	END

	--  Extern Info ����
	INSERT INTO [DBO].[TB_Guild_Extern_Info] ([GuildGuid], [Notice]) VALUES (@GuildGuid, '');
	IF @@error <> 0
	BEGIN
		SET @Err = 3; --Step
		GOTO __rollback_tran;
	END

	--  Member Grade ���� ����
	INSERT INTO [DBO].[TB_Guild_Member_Grade]
		([GuildGuid], [GradeGroupLevel], [GradeName01], [GradeName02], [GradeName03], [GradeName04], [GradeName05]) --, [LastModifyDate])
		VALUES (@GuildGuid, 0, @GradeName1, @GradeName2, @GradeName3, @GradeName4, @GradeName5);--, GetDate());
	IF @@error <> 0
	BEGIN
		SET @Err = 4; --Step
		GOTO __rollback_tran;
	END

	--  Master Char Member ���
	INSERT INTO [DBO].[TB_Guild_Member] ([CharacterGuid], [GuildGuid], [MemberLevel])
		VALUES (@MasterCharGuid, @GuildGuid, 0);
	IF @@error <> 0
	BEGIN
		SET @Err = 5; --Step
		GOTO __rollback_tran;
	END

__commit_tran:
BEGIN
	COMMIT TRAN
	SELECT @Err, @CommandType, @GuildGuid, @GuildName
	--RETURN @Err
	RETURN 
END

__rollback_tran:
BEGIN
	ROLLBACK TRAN
	SELECT @Err, @CommandType, @GuildGuid, @GuildName
	--RETURN @Err --Success = 0
	RETURN 
END
