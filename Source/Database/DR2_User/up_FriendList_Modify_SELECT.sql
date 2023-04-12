USE [DR2_User]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_FriendList_Modify_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_FriendList_Modify_SELECT]
GO

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
CREATE PROCEDURE [dbo].[up_FriendList_Modify_SELECT]
(
	@OwnerMemberGuid UNIQUEIDENTIFIER
)
AS

SET NOCOUNT ON;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT 
		[FriendGroupName], 
		[FriendMemberGuid], 
		B.[Name], 
		[FriendStatus],
		C.StreetNo,
		C.HouseNo
		FROM [dbo].[TB_UserFriend] AS A
		INNER JOIN [dbo].[TB_CharacterBasic] AS B ON A.FriendMemberGuid = B.CharacterID
		left join dbo.TB_User_MyHome_Base AS C on A.FriendMemberGuid = C.OwnerGuid
		WHERE [OwnerMemberGuid] = @OwnerMemberGuid;

	RETURN @@rowcount





