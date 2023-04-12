USE [DR2_User]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
go

IF EXISTS(SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Item_Select]'))
BEGIN
	DROP PROCEDURE [dbo].[up_Item_Select]
END
GO

CREATE PROCEDURE [dbo].[up_Item_Select]
/*
////////////////////////////////////////////////////////////////////////
//
// ���ν����� : ������ ���μ���
// �� �� �� : YonMy(yonmy@barunsoninter.com)
// �� �� �� : 2009-08-25
// ���������� : 
// �� �� �� :
// �� �� �� : 
// N O T E : 
// 2009-09-22, YonMy, Pet Skill CoolTime �߰�
// 2010-02-17, YonMy, Pet ���� ����
////////////////////////////////////////////////////////////////////////
*/ 
	@OwnerGuid	uniqueidentifier
AS
SET Nocount ON
SET Xact_Abort ON

-- 1. ������ ���̽�
SELECT	A.[ItemGuid]
	,	A.[OwnerGuid]
	,	A.[InvType]
	,	A.[InvPos]
	,	A.[ItemNo]
	,	A.[Count]
	,	ISNULL(B.[Enchant_01],0) AS Enchant_01
	,	ISNULL(B.[Enchant_02],0) AS Enchant_02
	,	ISNULL(B.[Enchant_03],0) AS Enchant_03
	,	ISNULL(B.[Enchant_04],0) AS Enchant_04
	,	A.[State]
	,	A.[CreateDate]
FROM	[dbo].[TB_UserItem]	AS A
	LEFT JOIN [dbo].[TB_UserItem_Enchant] AS B
		ON A.[ItemGuid] = B.[ItemGuid]
WHERE OwnerGuid = @OwnerGuid

-- 2. �����۾���ε�Ⱓ����Ʈ
SELECT 	[ItemGuid]
,		[UnbindDate]
FROM 	[dbo].[TB_UserItem_UnbindDate]
WHERE	[CharacterGuid] = @OwnerGuid

-- 3. ������ �߰� ������ (����ġ ī��)
SELECT	A.[ITEMGUID]
	,	A.[CUREXP]
	,	A.[MAXEXP]
	,	A.[ExpPer]
FROM [dbo].[TB_ExpCard] AS A
	LEFT JOIN dbo.TB_UserItem B
		ON A.ItemGuid = B.ItemGuid
WHERE B.[OwnerGuid] = @OwnerGuid

-- 4.��
SELECT	A.[PetID]
	, 	A.[Class]
	,	A.[Lv]
	,	A.[Name]
	,	A.[Exp]
	,	A.[MP]
	,	A.[Health]
	,	A.[Mental]
	,	A.[Color]
	,	A.[Skill01]
	,	A.[Skill02]
	,	A.[Skill03]
FROM [dbo].[TB_Pet] AS A
	LEFT JOIN [dbo].[TB_UserItem] AS B
		ON A.[PetID] = B.[ItemGuid]
WHERE B.[OwnerGuid] = @OwnerGuid 
	AND B.[State] = 1

-- 5. �Ⱓ�� ���� ī�� ����
SELECT	A.[ITEMGUID]
	,	A.[LimitTime]
FROM [dbo].[TB_UserItem_MonsterCard] AS A
	LEFT JOIN dbo.TB_UserItem B
		ON A.ItemGuid = B.ItemGuid
WHERE B.[OwnerGuid] = @OwnerGuid
