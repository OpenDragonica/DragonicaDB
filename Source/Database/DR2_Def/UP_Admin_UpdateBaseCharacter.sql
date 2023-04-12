IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UP_UpdateBaseCharacter3]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[UP_UpdateBaseCharacter3]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UP_Admin_UpdateBaseCharacter]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[UP_Admin_UpdateBaseCharacter]
GO


/****** Object:  StoredProcedure [dbo].[UP_UpdateBaseCharacter3]    Script Date: 07/09/2009 11:25:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create PROCEDURE [dbo].[UP_Admin_UpdateBaseCharacter]
/*
////////////////////////////////////////////////////////////////////////
//
// ���ν�����: [dbo].[UP_UpdateBaseCharacter]
// �ۼ���: �����(eric@barunsoninter.com)
// �ۼ���: 2008-06-25
// ����������: 
// ������: 
// ���ϸ�: 
// N O T E : �ۼ��س���Base Character ������BaseCharacter Table���Űܳ��·���
//		���ӳ��ο���ȣ������ʰ�, ���Ƿ�ȣ�����־���Ѵ�.
//
//	2008-10-10 : Face,Hair ��⺻����������߰�
//	2008-12-09 : ��������������Ʈ��������ø�
//	2008-12-12 : Eric Kim, ����Ʈ���������¹������ʱ�ȭ�ǵ��Ϻ���
//	2009-03-12 : �����ι��丮Ȯ�������߰�
////////////////////////////////////////////////////////////////////////
*/
(
@CharName nvarchar(20)	-- Character Nickname
)
AS
BEGIN

	DECLARE @Error int

	DECLARE @CharacterGuid uniqueidentifier
	DECLARE @Class tinyint
	DECLARE @State tinyint
	DECLARE @Race int
	DECLARE @Lv int
	DECLARE @Exp bigint
	DECLARE @Money bigint
	DECLARE @HP int
	DECLARE @MP int
	DECLARE @ExtraSkillPoint smallint
	DECLARE @Skills binary(450)
	DECLARE @RecentMap int
	DECLARE @RecentLocX float
	DECLARE @RecentLocY float
	DECLARE @RecentLocZ float
	DECLARE @LastVillage int
	DECLARE @LastVillageLocX float
	DECLARE @LastVillageLocY float
	DECLARE @LastVillageLocZ float
	DECLARE @QuickSlot binary(281)
	DECLARE @IngQuest binary(160)
	DECLARE @EndQuest binary(130)
	DECLARE @EndQuest2 binary(130)
	DECLARE @Gender tinyint
	DECLARE @HairStyle int
	DECLARE @HairColor int
	DECLARE @Face int
	DECLARE @Jacket int
	DECLARE @Gloves int
	DECLARE @Pants int
	DECLARE @Shoes int
	DECLARE @InvExtend BINARY(40)

	SET @Error = 0

	-- Get Character information
	SELECT
		@CharacterGuid = [TB_CharBasic].[CharacterID]
		,@Class = [TB_CharSub].[Class]
		,@State = [TB_CharBasic].[State]
		,@Race = [TB_CharBasic].[Race]
		,@Lv = [TB_CharSub].[Lv]
		,@Exp = [TB_CharSub].[Exp]
		,@Money = [TB_CharSub].[Money]
		,@HP = [TB_CharSub].[HP]
		,@MP = [TB_CharSub].[MP]
		,@ExtraSkillPoint = [TB_CharSub].[ExtraSkillPoint]
		,@Skills = [TB_CharSub].[Skills]
		,@RecentMap = [TB_CharSub].[RecentMap]
		,@RecentLocX = [TB_CharSub].[RecentLocX]
		,@RecentLocY = [TB_CharSub].[RecentLocY]
		,@RecentLocZ = [TB_CharSub].[RecentLocZ]
		,@LastVillage = [TB_CharSub].[LastVillage]
		,@LastVillageLocX = [TB_CharSub].[LastVillageLocX]
		,@LastVillageLocY = [TB_CharSub].[LastVillageLocY]
		,@LastVillageLocZ = [TB_CharSub].[LastVillageLocZ]
		,@QuickSlot = [TB_CharSub].[QuickSlot]
		,@IngQuest = [TB_CharSub].[IngQuest]
		,@EndQuest = [TB_CharSub].[EndQuest]
		,@EndQuest2 = [TB_CharSub].[EndQuest2]
		,@Gender = [TB_CharBasic].[Gender]
		,@HairStyle = [TB_CharBasic].[HairStyle]
		,@HairColor = [TB_CharBasic].[HairColor]
		,@Face = [TB_CharBasic].[Face]
		,@Jacket = [TB_CharBasic].[Jacket]
		,@Gloves = [TB_CharBasic].[Gloves]
		,@Pants = [TB_CharBasic].[Pants]
		,@Shoes = [TB_CharBasic].[Shoes]
		,@InvExtend = [TB_CharSub].[InvExtend]
		FROM [DR2_User].[dbo].[TB_CharacterBasic] AS TB_CharBasic
			INNER JOIN [DR2_User].[dbo].[TB_CharacterSub] AS TB_CharSub ON [TB_CharBasic].[CharacterID] = [TB_CharSub].[CharacterID]
		WHERE [TB_CharBasic].[Name] = @CharName
	IF @@ROWCOUNT = 0 OR @Class <= 0
	BEGIN
		SET @Error = 1
		GOTO ErrorHandler
	END

	-- Making Base_Character
	IF EXISTS ( SELECT 1 FROM [DR2_Def].[dbo].[TB_DefBaseCharacter2] WHERE f_Class = @Class )
	BEGIN
		-- DELETE
		DELETE FROM [DR2_Def].[dbo].[TB_DefBaseCharacter2] WHERE f_Class = @Class
		DELETE FROM [DR2_User].[dbo].[TB_DefBaseUserItem] WHERE f_Class = @Class
	END

	-- ���ο�ĳ���Ͱ�ó�������ϴ�Map��Tutorial_Indun_Map �̵Ǿ�
	-- @LastVillage ����������0���μ����Ѵ�.
	SET @RecentMap = 9910100
	SET @RecentLocX = 0
	SET @RecentLocY = 0
	SET @RecentLocZ = 0
	SET @LastVillage = 0
	SET @LastVillageLocX = 0
	SET @LastVillageLocY = 0
	SET @LastVillageLocZ = 0
	SET @IngQuest = 0
	SET @EndQuest = 0
	SET @EndQuest2 = 0
	INSERT INTO [dbo].[TB_DefBaseCharacter2]
		([f_Class] ,[f_State] ,[f_Race] ,[f_Lv] ,[f_Exp]
		,[f_Money] ,[f_HP] ,[f_MP] ,[f_ExtraSkillPoint] ,[f_Skills]
		,[f_RecentMap] ,[f_RecentLocX] ,[f_RecentLocY] ,[f_RecentLocZ] ,[f_LastVillage]
		,[f_LastVillageLocX] ,[f_LastVillageLocY] ,[f_LastVillageLocZ] ,[f_QuickSlot] ,[f_IngQuest]
		,[f_EndQuest], [f_EndQuest2], [f_Gender], [f_HairStyle], [f_HairColor],
		[f_Face], [f_Jacket] ,[f_Gloves] ,[f_Pants] ,[f_Shoes],[f_InvExtend])
		VALUES (
		@Class, @State, @Race, @Lv, @Exp,
		@Money, @HP, @MP, @ExtraSkillPoint, @Skills,
		@RecentMap, @RecentLocX, @RecentLocY, @RecentLocZ, @LastVillage,
		@LastVillageLocX, @LastVillageLocY, @LastVillageLocZ, @QuickSlot, @IngQuest,
		@EndQuest, @EndQuest2, @Gender, @HairStyle, @HairColor,
		@Face, @Jacket ,@Gloves ,@Pants ,@Shoes,@InvExtend)
	IF @@ROWCOUNT <> 1
	BEGIN
		SET @Error = 2
		GOTO ErrorHandler
	END

	INSERT INTO [DR2_User].[dbo].[TB_DefBaseUserItem]
		([f_Class] ,[f_InvType] ,[f_InvPos] ,[f_ItemNo] ,[f_Count]
		,[f_Enchant_01] ,[f_Enchant_02] ,[f_State])
		SELECT @Class ,[InvType] ,[InvPos] ,[ItemNo] ,[Count]
			,[Enchant_01],[Enchant_02],[State]
			FROM [DR2_User].[dbo].[TB_UserItem]
			WHERE [OwnerGuid] = @CharacterGuid

	return @Error

ErrorHandler:
	return @Error
	
END

GO