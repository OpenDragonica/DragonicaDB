USE [DR2_User]
IF EXISTS(SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'up_FriendList_Modify_Modify'))
BEGIN
	DROP PROCEDURE [dbo].[up_FriendList_Modify_Modify]
END
GO

/****** Object:  StoredProcedure [dbo].[up_FriendList_Modify_Modify]    Script Date: 03/31/2009 14:04:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/*
////////////////////////////////////////////////////////////////////////
// Lasst Update by : ������
// Update date  : 2008-10-21
// Description : ģ�� DB������ ����
// [PARAMETER] : 
// [RETURN] : 
// [REMARK]
//	2008-10-21 : ������, ADD/ DEL/ MODIFY/ SELECT �� �и�
//	2008-10-07 : Eric Kim, Character DB �� �ѷ� �������� �� ����
//	2008-06-03 : <�Ͻº�>
////////////////////////////////////////////////////////////////////////
*/
CREATE PROCEDURE [dbo].[up_FriendList_Modify_Modify]
(
	@OwnerMemberGuid UNIQUEIDENTIFIER,
	@FriendGroupName nvarchar(20),
	@FriendMemberGuid UNIQUEIDENTIFIER,
	@ChatStatus INT
)
AS

SET XACT_ABORT ON;
SET NOCOUNT ON;
DECLARE @Err INT;
DECLARE @GuidRet UNIQUEIDENTIFIER;
DECLARE @StatusRet INT;
DECLARE @SystemError INT;


	SET @Err = 0;
	SET @StatusRet = 0;
	SET @GuidRet = NULL;

	--���� �� DB�� �ִ���?
	IF NOT EXISTS ( SELECT 1 FROM [dbo].[TB_CharacterBasic] WHERE [CharacterID] = @OwnerMemberGuid )
	BEGIN
		SET @Err = 301;--����
		GOTO __rollback_tran;
	END
	
	IF NOT EXISTS ( SELECT 1 FROM [dbo].[TB_UserFriend] WHERE [OwnerMemberGuid] = @OwnerMemberGuid AND [FriendMemberGuid] = @FriendMemberGuid )
	BEGIN
		SET @Err = 301;--����
		GOTO __rollback_tran;
	END

	UPDATE [dbo].[TB_UserFriend]
		SET [FriendStatus] = @ChatStatus, [FriendGroupName] = @FriendGroupName
		WHERE [OwnerMemberGuid] = @OwnerMemberGuid AND [FriendMemberGuid] = @FriendMemberGuid;
	IF @@rowcount <> 1
	BEGIN
		SET @Err = 301;--����
		GOTO __rollback_tran;
	END

	SET @Err = 1;
	GOTO __commit_tran;


__commit_tran:
BEGIN
	SELECT @Err, @OwnerMemberGuid, @SystemError
	RETURN @Err
END

__rollback_tran:
BEGIN
	SELECT @Err, @OwnerMemberGuid
	RETURN @Err
END



GO