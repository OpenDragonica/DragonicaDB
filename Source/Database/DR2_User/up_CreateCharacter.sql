USE [DR2_User]
GO
/****** Object:  StoredProcedure [dbo].[up_CreateCharacter]    Script Date: 07/28/2009 20:00:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Object:  StoredProcedure [dbo].[up_CreateCharacter]    Script Date: 07/28/2009 20:10:59 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_CreateCharacter]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[up_CreateCharacter]
GO


CREATE PROC [dbo].[up_CreateCharacter]
/*
////////////////////////////////////////////////////////////////////////
//
// ���ν�����: ĳ���ͻ���
// �ۼ���: Richard Kim(tigerjune@barunsoninter.com)
// �ۼ���: 2008-10-02
// ����������: YonMy
// ������: 2009-02-12
// ���ϸ�: 
//	[PARAMETER]
//	@Mode : ĳ���� �̸� �ߺ� �˻� ���
//		0 == ������ ĳ���͸��� �˻� ����.
//		2 == ������ ĳ���͸� �˻�
// N O T E : 
//	2008-10-28 ������, �������ֱ���ġ, �ֱٸ���0�����λ����ϵ��ϼ���
//	2008-11-14 �����, �⺻��������ϴ�INSERT����Column name �����ϵ��ϼ���
//	2008-12-09 : ��������������Ʈ��������ø�
//  2009-01-03 : �ֿ���, ���ϰ����̸��߰�
//	2009-02-12 : YonMy, GMLevel ����
//	2009-03-12 : ������ ���� ������ ���� 241 -> 281
//	2009-03-12 : �ι��丮Ȯ��/��������߰�
//	2009-03-30 : ������ �̸� �˻翡, State�� 0 �� ĳ���� �鸸 �˻� �ϵ���
//	2009-03-30 : ������ �̸� �˻翡, State�� 0, 100, 101 �� ĳ���� �鸸 �˻� �ϵ���
//	2009-04-22 : Eric Kim, �̸� �ߺ� �˻� �� �� @Mode ������, ������ ĳ���͵� �˻� �� ���ΰ� �����ϱ�
//	2009-08-09 : Eric Kim,	������ �������� �ʱ⿡ ������ �� �ֵ��� �ϱ�.
//	2012-01-10 : ���強, ���� ĳ���� �̺�Ʈ ������ �޾Ƽ� ĳ�� ������ �� �ֵ��� ����
////////////////////////////////////////////////////////////////////////
*/
(
	@Mode	TINYINT,	-- ĳ���� ���� ���
	@MemberID	UNIQUEIDENTIFIER,	-- MemberGuid
	@Name		NVARCHAR(20),	-- ĳ�����̸�
	@InGender	TINYINT,		-- ����
	@InBaseClass	INT,		-- Ŭ������ȣ(�⺻)
	@InClass		INT,		-- Ŭ������ȣ(����)
	@HairStyle	INT,			-- �Ӹ����
	@HairColor	INT,			-- �Ӹ�����
	@Face		INT,			-- ��ǥ��
	@Jacket		INT,			-- ����
	@Gloves		INT,			-- �尩
	@Pants		INT,			-- ����
	@Shoes		INT,				-- �Ź�
	@FiveElementBody		TINYINT	,-- 5�Ӽ�.
	@f_State TINYINT,
	@f_Race INT,
	@f_Lv SMALLINT,	
	@f_Exp BIGINT,	
	@f_Money BIGINT,
	@f_HP INT,
	@f_MP INT,
	@f_CP INT,
	@f_ExtraSkillPoint SMALLINT,
	@f_Skills BINARY(450),
	@f_QuickSlot BINARY(281),
	@f_IngQuest BINARY(300),
	@f_EndQuest BINARY(130),
	@f_EndQuest2 BINARY(130),
	@f_EndQuestExt BINARY(260),
	@f_EndQuestExt2 BINARY(480),
	@f_InvExtend BINARY(40),
	@JumpingEventNo INT,
	@JumpingMaxRewardCount INT,
	@JumpingCharEventItemGroupNo INT,
	@MapNo INT,
	@MaxCharacterNum INT		--	�ִ� ĳ���� ���� ���� ����
)
AS
SET NOCOUNT ON
SET XACT_ABORT ON

DECLARE @RegistDate DATETIME
DECLARE @CharacterID UNIQUEIDENTIFIER
DECLARE @Err INT
SET @Err = 0

--1. ĳ�����̸��ߺ��˻�
IF @Mode = 2
BEGIN
	-- ������ ĳ���Ϳ����� �ߺ� �˻��ϱ�
	IF EXISTS (SELECT 1 FROM dbo.TB_CharacterBasic WHERE [Name] = @Name)
	BEGIN
		SET @Err = 100  -- �ߺ��Ǵ�ĳ�����̸�������(C�ҽ��Ϳ�����ȣ����CCR_OVERLAP_NAME)
		GOTO ErrorReturn
	END
END
ELSE -- @Mode = 0
BEGIN
	-- ������ ĳ���ʹ� �ߺ��˻� ���� ����.
	IF EXISTS (SELECT 1 FROM dbo.TB_CharacterBasic WHERE [Name] = @Name AND [State] <> 1 )
	BEGIN
		SET @Err = 100  -- �ߺ��Ǵ�ĳ�����̸�������(C�ҽ��Ϳ�����ȣ����CCR_OVERLAP_NAME)
		GOTO ErrorReturn
	END
END

-- ĳ�� ���������� Ȯ���� ���� ����
DECLARE @MAX_CHARACTER_NUM INT
SET @MAX_CHARACTER_NUM = @MaxCharacterNum
SELECT @MAX_CHARACTER_NUM = @MAX_CHARACTER_NUM + isnull(ExtendCharacterNum,0) FROM dbo.TB_Member_ShareData where MemberKey = @MemberID

DECLARE @CUR_CHARACTER_NUM INT
SELECT @CUR_CHARACTER_NUM = COUNT(*) FROM dbo.TB_CharacterBasic WHERE MemberID = @MemberID AND [State] <> 1

--2. ĳ������3���ʰ�üũ
IF @MAX_CHARACTER_NUM <= @CUR_CHARACTER_NUM
BEGIN
	SET @Err = 200--ĳ���Ͱ����������ʰ��Ͽ���(max : 5��) (C�ҽ��Ϳ�����ȣ����CCR_MAX_LIMINT)
	GOTO ErrorReturn
END

--3. ĳ�������ͻ���
SET @RegistDate = GETDATE()
SET @CharacterID = NEWID()

--����ĳ���� �̺�Ʈ �˻�
IF @JumpingEventNo > 0
BEGIN
	DECLARE @RemainRewardCount INT

	SELECT @RemainRewardCount = RewardCount
	FROM TB_JumpingCharEvent_State
	WHERE EventNo = @JumpingEventNo AND MemberID = @MemberID
	
	IF @JumpingMaxRewardCount<>0
	BEGIN
		IF @RemainRewardCount IS NULL
		BEGIN
			INSERT INTO TB_JumpingCharEvent_State
				   ([EventNo],[MemberID],[RewardCount])
			 VALUES
				   (@JumpingEventNo, @MemberID, @JumpingMaxRewardCount)
		END
		ELSE IF @RemainRewardCount <= 0
		BEGIN
			SET @Err = 401--���� �̺�Ʈ ĳ���͸� ���̻� ���� �� �����ϴ�.
			GOTO ErrorReturn
		END
	END
END

BEGIN TRAN
	--���� �̺�Ʈ ĳ���� ������Ʈ, �׳� ������ -1��Ŵ
	IF @JumpingEventNo > 0 AND @JumpingMaxRewardCount > 0
	BEGIN
		UPDATE TB_JumpingCharEvent_State
		   SET [RewardCount] = [RewardCount]-1
		 WHERE [EventNo] = @JumpingEventNo AND [MemberID] = @MemberID
	END

	
	--�⺻ĳ������
	INSERT dbo.TB_CharacterBasic  ([MemberID],[CharacterID],[State],[Name],[Gender],[Race],[FiveElementBody],[HairStyle]
           ,[HairColor],[Face],[Jacket],[Gloves],[Pants],[Shoes],[BirthDate])
	VALUES (@MemberID, @CharacterID, @f_State, @Name, @InGender,	@f_Race, @FiveElementBody, 
		@HairStyle, @HairColor, @Face, @Jacket, @Gloves, @Pants, @Shoes, @RegistDate)
	IF @@error <> 0
	BEGIN
		SET @Err = 300-- TB_CharacterUser ��insert ����(C�ҽ��Ϳ�����ȣ����CCR_DB_ERR_1)
		GOTO ErrorHandler
	END

	--��������
	INSERT INTO [dbo].[TB_CharacterSub]
           ([CharacterID],[Class],[Lv],[Exp],[Money],[HP],[MP],[CP],[ExtraSkillPoint],[Skills]
		   ,[RecentMap],[RecentLocX],[RecentLocY],[RecentLocZ]
           ,[LastVillage],[LastVillageLocX],[LastVillageLocY],[LastVillageLocZ]
           ,[QuickSlot],[IngQuest],[EndQuest],[EndQuest2],[f_EndQuestExt],[f_EndQuestExt2],[Cash],[TotalPlayTimeSec],[Fran],[TacticsLevel],[TacticsExp]
           ,[InvExtend])
	VALUES 
		(@CharacterID, @InClass, @f_Lv, @f_Exp, @f_Money, @f_HP, @f_MP, @f_CP, @f_ExtraSkillPoint, @f_Skills, 	
		@MapNo, 0, 0, 0, 0, 0, 0, 0,
		@f_QuickSlot, @f_IngQuest, @f_EndQuest, @f_EndQuest2, @f_EndQuestExt, @f_EndQuestExt2, 0, 0, 0, 1, 0,@f_InvExtend)
	IF @@error <> 0
	BEGIN
		SET @Err = 300-- TB_CharacterUser ��insert ����(C�ҽ��Ϳ�����ȣ����CCR_DB_ERR_1)
		GOTO ErrorHandler
	END

	-- Default Given Item
	DECLARE @ITEM_TABLE TABLE(InvType tinyint, InvPos tinyint, ItemNo int, [Count] smallint, Enchant_01 bigint, Enchant_02 bigint, Enchant_03 bigint, Enchant_04 bigint, [State] tinyint)
	INSERT INTO @ITEM_TABLE
	SELECT InvType, InvPos, ItemNo, [Count], Enchant_01, Enchant_02, Enchant_03, Enchant_04, [State] FROM TB_JumpingCharEvent_Item WHERE ItemGroupNo = @JumpingCharEventItemGroupNo

	INSERT INTO @ITEM_TABLE
	SELECT f_InvType, f_InvPos, f_ItemNo, f_Count, f_Enchant_01, f_Enchant_02, f_Enchant_03, f_Enchant_04, f_State FROM [dbo].[TB_DefBaseUserItem]
	 WHERE f_Class = @InBaseClass
		 AND NOT ((f_InvType in (SELECT InvType FROM @ITEM_TABLE)) AND (f_InvPos in (SELECT InvPos FROM @ITEM_TABLE)))

	DECLARE @item_InvType tinyint
	DECLARE @item_InvPos tinyint
	DECLARE @item_ItemNo int
	DECLARE @item_Count smallint
	DECLARE @item_Enchant_01 bigint
	DECLARE @item_Enchant_02 bigint
	DECLARE @item_Enchant_03 bigint
	DECLARE @item_Enchant_04 bigint
	DECLARE @item_State tinyint
	DECLARE @Item_GUID UNIQUEIDENTIFIER
	DECLARE Item_Cursor CURSOR FOR

	SELECT * FROM @ITEM_TABLE
	OPEN Item_Cursor
	FETCH NEXT FROM Item_Cursor
		INTO @item_InvType, @item_InvPos, @item_ItemNo, @item_Count, @item_Enchant_01, @item_Enchant_02, @item_Enchant_03, @item_Enchant_04, @item_State
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @item_GUID = NEWID()
	INSERT [dbo].[TB_UserItem] 
		([ItemGuid] ,[OwnerGuid] ,[InvType]  ,[InvPos] ,[ItemNo]
		,[Count] ,[State] ,[CreateDate])
			VALUES (@item_GUID, @CharacterID, @item_InvType, @item_InvPos, @item_ItemNo
			,@item_Count, @item_State, @RegistDate)
	IF @@error <> 0
	BEGIN
		SET @Err = 300-- TB_CharacterUser ��insert ����(C�ҽ��Ϳ�����ȣ����CCR_DB_ERR_1)
			GOTO Error_UserItem
	END
		IF (@item_Enchant_01 <> 0 OR @item_Enchant_02 <> 0 OR @item_Enchant_03 <> 0 OR @item_Enchant_04 <> 0)
		BEGIN
	INSERT [dbo].[TB_UserItem_Enchant]
		([ItemGuid], [Enchant_01], [Enchant_02], [Enchant_03], [Enchant_04])
				VALUES (@item_GUID, @item_Enchant_01, @item_Enchant_02, @item_Enchant_03, @item_Enchant_04)
	IF @@error <> 0
	BEGIN
		SET @Err = 300-- TB_CharacterUser ��insert ����(C�ҽ��Ϳ�����ȣ����CCR_DB_ERR_1)
				GOTO Error_UserItem
			END
		END

		-- NEXT Fetch
		FETCH NEXT FROM Item_Cursor
			INTO @item_InvType, @item_InvPos, @item_ItemNo, @item_Count, @item_Enchant_01, @item_Enchant_02, @item_Enchant_03, @item_Enchant_04, @item_State
	END
Error_UserItem:
	CLOSE Item_Cursor;
	DEALLOCATE Item_Cursor;

	IF (@Err <> 0)
	BEGIN
		GOTO ErrorHandler
	END
	
	-- Extern
	INSERT INTO [dbo].[TB_UserCharacter_Extern]	(	[CharacterID], [LastUpdate] )	VALUES ( @CharacterID, @RegistDate )
	IF @@error <> 0
	BEGIN
		SET @Err = 300-- TB_CharacterUser ��insert ����(C�ҽ��Ϳ�����ȣ����CCR_DB_ERR_1)
		GOTO ErrorHandler
	END

	-- Point
	INSERT INTO [dbo].[TB_UserCharacter_Point] (	[CharacterID] )	VALUES ( @CharacterID )
	IF @@error <> 0
	BEGIN
		SET @Err = 300-- TB_CharacterUser ��insert ����(C�ҽ��Ϳ�����ȣ����CCR_DB_ERR_1)
		GOTO ErrorHandler
	END
		
	COMMIT TRAN
	SELECT @Err, @CharacterID, @InGender, @InClass, @Name, @JumpingEventNo
	RETURN


ErrorHandler:
BEGIN
	ROLLBACK TRAN
	SET @CharacterID = N'00000000-0000-0000-0000-000000000000'
	SET @InClass = 0;
	SET @InGender = 0;
	SELECT @Err, @CharacterID, @InGender, @InClass, @Name, @JumpingEventNo
	RETURN
END

ErrorReturn:
BEGIN
	SET @CharacterID = N'00000000-0000-0000-0000-000000000000'
	SET @InClass = 0;
	SET @InGender = 0;
	SELECT @Err, @CharacterID, @InGender, @InClass, @Name, @JumpingEventNo
	RETURN
END

GO

