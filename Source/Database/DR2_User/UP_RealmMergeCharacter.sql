USE [DR2_User]
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UP_RealmMergeCharacter]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[UP_RealmMergeCharacter]
END
GO

set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

CREATE PROC [dbo].[UP_RealmMergeCharacter]
/*
////////////////////////////////////////////////////////////////////////
//
// ���ν�����: ĳ���͸� ����
// �ۼ���: ������
// �ۼ���: 2009-03-30
// ���ϸ�: 
// N O T E : 
//	2009-03-30 ĳ���� �̸��� ���� �� �� �ֵ���
//  2011-08-29 ������ : Ȯ�� ���� ���� üũ �߰�.
////////////////////////////////////////////////////////////////////////
*/
(
	@MemberID		UNIQUEIDENTIFIER,	-- MemberGuid
	@CharacterID	UNIQUEIDENTIFIER,	-- CharacterGuid
	@NewName		NVARCHAR(20)	-- ĳ�����̸�
)
AS
SET NOCOUNT ON
SET XACT_ABORT ON

DECLARE @Err INT
DECLARE @OrgState tinyint
DECLARE @OrgName nvarchar(20)
DECLARE @Class smallint
DECLARE @LV	smallint
SET @Err = 0

DECLARE @BasicSlot	tinyint
SET @BasicSlot = 3
DECLARE @ExtendSlot	tinyint
SET @ExtendSlot = 0

IF NOT EXISTS (SELECT 1 FROM dbo.TB_CharacterBasic WHERE [MemberID] = @MemberID AND [CharacterID] = @CharacterID AND 0 <> ([State] & 0x0C) )
BEGIN
	SET @Err = 0  -- ���մ���� ĳ���Ͱ� �ƴ�(C�ҽ��Ϳ�����ȣ���� UCRR_None)
	GOTO ErrorReturn
END

SELECT @OrgName = [Name], @OrgState = [State] FROM dbo.TB_CharacterBasic WHERE [CharacterID] = @CharacterID
SELECT @Class = [Class], @LV = [LV] FROM dbo.TB_Charactersub WHERE [CharacterID] = @CharacterID
SELECT @ExtendSlot = [ExtendCharacterNum] FROM dbo.TB_Member_ShareData WHERE MemberKey = @MemberID

--1. ĳ�����̸��ߺ��˻�
IF 0 <> (@OrgState & 0x04) AND EXISTS (SELECT 1 FROM dbo.TB_CharacterBasic WHERE [CharacterID] <> @CharacterID AND [Name] = @NewName AND [State] <> 1 )
BEGIN
	SET @Err = 3  -- �ߺ��Ǵ�ĳ�����̸�������(C�ҽ��Ϳ�����ȣ���� UCRR_Duplicate)
	GOTO ErrorReturn
END

--2. ĳ������ �ʰ�üũ
-- 2.1. ���� ������, �����ϴ� ���̶��, ���(0), �̸�������(4) ������ ĳ���͵��� 3�� ���Ͽ��� ��
-- 2.2. �̸� ���� ���̶��, ����
-- �߰� : dbo.TB_Member_ShareData.ExtendCharacterNum�� Ȯ���Ͽ� �߰� ������ �ִ��� üũ
-- ���� : �⺻ ���� ���� + Ȯ�� ���� ���Ժ��� ĳ���� ������ ���� �ʾƾ� �� - ���� ����
IF ((0 <> (@OrgState & 0x04)) OR (0 <> (@OrgState & 0x08))) AND 1 = (SELECT (CASE WHEN COUNT(1) > (@BasicSlot+@ExtendSlot) THEN 1 ELSE 0 END) FROM dbo.TB_CharacterBasic WHERE MemberID = @MemberID AND [State] in (0))
BEGIN
	SET @Err = 6--ĳ���Ͱ����������ʰ��Ͽ���(max : 5��) (C�ҽ��Ϳ�����ȣ���� UCRR_MaxSlot)
	GOTO ErrorReturn
END


BEGIN TRAN
	IF 0 <> (@OrgState & 0x04)
	BEGIN
		UPDATE dbo.TB_CharacterBasic
			SET [Name] = @NewName, [State] = 0
			WHERE [CharacterID] = @CharacterID
	END
	ELSE
	BEGIN
		UPDATE dbo.TB_CharacterBasic
			SET [State] = 0
			WHERE [CharacterID] = @CharacterID

		SET @NewName = @OrgName
	END
		
	COMMIT TRAN
	SET @Err = 1 -- ���� (UCCR_Success)
	SELECT @Err, @CharacterID, @NewName, @OrgName, @Class, @LV
	RETURN

--ErrorHandler:
--BEGIN
--	ROLLBACK TRAN
--	SELECT @Err, @CharacterID, @NewName, @OrgName, @Class, @LV
--	RETURN
--END

ErrorReturn:
BEGIN
	SELECT @Err, @CharacterID, @NewName, @OrgName, @Class, @LV
	RETURN
END
GO
