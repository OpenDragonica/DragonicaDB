USE DR2_User

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_DeleteUserCharacterSub]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[up_DeleteUserCharacterSub]
END 

set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

/*
////////////////////////////////////////////////////////////////////////
// Lasst Update by : Eric Kim
// Update date  : 2008-08-07
// Description : ĳ�����Ǻμ��������������
// [PARAMETER] : 
//	@CharacterGuid : character guid to delete
//  @RemoveAllData :
//		= 0 : DB����Character���������������ʰ�, ����ǥ�ø��ϴ°��
//		= 100 : DB����Character �������������������Ҷ�
// [RETURN] : 
// [REMARK]
// ����: ĳ���ͻ����ù��������߾������ִ¸������ݼ�ó���ϵ��ϼ���
// ����: ������ ���ε� ���� ����
// ����: ĳ���� ī�� ���� �߰�
// ����: ĳ���� ��Ż ���� �߰�

////////////////////////////////////////////////////////////////////////
*/
set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go


/*
////////////////////////////////////////////////////////////////////////
// Lasst Update by : Eric Kim
// Update date  : 2008-08-07
// Description : ĳ�����Ǻμ��������������
// [PARAMETER] : 
//	@CharacterGuid : character guid to delete
//  @RemoveAllData :
//		= 0 : DB����Character���������������ʰ�, ����ǥ�ø��ϴ°��
//		= 100 : DB����Character �������������������Ҷ�
// [RETURN] : 
// [REMARK]
// ����: ĳ���ͻ����ù��������߾������ִ¸������ݼ�ó���ϵ��ϼ���
// ����: ĳ���� ī�� ���� �߰�
// ����: ĳ���� ��Ż ���� �߰�
// ����: ���� ���� ���� ���̺��� ������ ����°� ����
// 2009-03-26 : Eric Kim, ������ TB_UserMailIndex ���̺� ����
// 2009-08-21 : YonMy, Pet�� ������ ������ �����ϰ� ����

////////////////////////////////////////////////////////////////////////
*/
CREATE PROCEDURE [dbo].[up_DeleteUserCharacterSub]
	@CharacterID uniqueidentifier,
	@RemoveAllData tinyint
AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN TRAN

	-- �ڽſ������۵ȸ����������ð�����������Ų��.
	-- �ݼ�/������ų���ֵ�����ó���½��������Ͱ������ǵ�ȵǵ絿���ؾ���
	UPDATE [dbo].[tb_UserMail] SET LIMITTIME = GETDATE() WHERE toguid = @CharacterID

	IF @RemoveAllData = 100
	BEGIN
		-- �Ʒ���������Character ��������¥��DB���������ɶ���������.
		DELETE FROM [dbo].[TB_UserCharacter_Point] WHERE [CharacterID] = @CharacterID
		DELETE FROM [dbo].[TB_UserCharacter_Extern] WHERE [CharacterID] = @CharacterID
	
		DELETE FROM [dbo].[TB_UserItem_Enchant]
			WHERE [ItemGuid] IN
			(SELECT ItemGuid FROM [dbo].[TB_UserItem] WHERE [OwnerGUID] = @CharacterID)

		DELETE FROM [dbo].[TB_ExpCard] 
			WHERE [ItemGuid] IN
			(SELECT ItemGuid FROM [dbo].[TB_UserItem] WHERE [OwnerGUID] = @CharacterID)
			
		DELETE FROM [dbo].[TB_UserItem]
			WHERE [OwnerGUID] IN
			(SELECT PetID FROM [dbo].[TB_Pet] A INNER JOIN [dbo].[TB_UserItem] B ON A.[PetID] = B.[OwnerGUID] WHERE B.[OwnerGUID] = @CharacterID)
				
		DELETE FROM [dbo].[TB_Pet] 
			WHERE [PetID] IN
			(SELECT ItemGuid FROM [dbo].[TB_UserItem] WHERE [OwnerGUID] = @CharacterID)

		DELETE FROM [dbo].[TB_UserItem] WHERE [OwnerGUID] = @CharacterID

		DELETE FROM [dbo].[TB_Mission_Rank] WHERE [CharacterID] = @CharacterID

	-- �ٸ�����̺��������߿�÷�ι���������ݼ�ó����Ų��.
		declare @curdate datetime
		set @curdate = dateadd(day,3,getdate())

		insert into dbo.tb_usermail 
		SELECT	newid() as [mailguid],[FromGuid]
		,[FromGuid],[Title],[Note],[PaymentType],[ItemGuid],[Money],[SendTime],@curdate
		,0 as [ReadBit],1 as [ReturnBit],[AnnexBit],0 as [PaymentBit], [FromName]
		FROM [dbo].[TB_UserMail]
		WHERE 
		toguid = @CharacterID and annexbit = 0 and 
		(itemguid <> '00000000-0000-0000-0000-000000000000' or money <> 0) and ReturnBit = 0

		DELETE FROM [dbo].[TB_UserMail] WHERE [ToGuid] = @CharacterID
		DELETE FROM [dbo].[TB_UserMail] WHERE [FromGuid] = @CharacterID

		DELETE FROM [dbo].[TB_UserAchievements] WHERE [CharGuId] = @CharacterID
		DELETE FROM [dbo].[TB_UserCash_Rank] WHERE [CharGuId] = @CharacterID
		DELETE FROM [dbo].[TB_UserCashGift] WHERE [CharGuId] = @CharacterID
		DELETE FROM [dbo].[TB_UserDealings] WHERE [CharacterGuid] = @CharacterID
		DELETE FROM [dbo].[TB_UserMarket] WHERE [SellerGuid] = @CharacterID
		DELETE FROM [dbo].[TB_UserMarketInfo2] WHERE [CharGuId] = @CharacterID
		DELETE FROM [dbo].[TB_UserCouple] WHERE [CharacterGuid] = @CharacterID
		DELETE FROM [dbo].[TB_UserItem_UnbindDate] WHERE [CharacterGuid] = @CharacterID
		DELETE FROM [dbo].[TB_UserCharacter_Card] WHERE [CharacterGuid] = @CharacterID
		DELETE FROM [dbo].[TB_UserPortal] WHERE [CharacterGuid] = @CharacterID
		
		IF EXISTS(SELECT 1 FROM [dbo].[TB_UserJobSkill_Expertness] WHERE [f_CharGuid] = @CharacterID)
		BEGIN
			DELETE FROM [dbo].[TB_UserJobSkill_Expertness] WHERE [f_CharGuid] = @CharacterID
		END
		
	END

	DELETE FROM [dbo].[TB_Guild_Member] WHERE [CharacterGUID] = @CharacterID
	
	DELETE FROM [dbo].[TB_UserFriend] WHERE [OwnerMemberGuid] = @CharacterID OR [FriendMemberGuid] = @CharacterID
	IF EXISTS(SELECT 1 FROM [dbo].[TB_UserJobSkill_Exhaustion] WHERE [f_CharGuid] = @CharacterID)
	BEGIN
		DELETE FROM [dbo].[TB_UserJobSkill_Exhaustion] WHERE [f_CharGuid] = @CharacterID
	END
Commit Tran
















