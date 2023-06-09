/* Eric Kim, 2009-07-28 */
/* 	계정 생성과, 캐릭터 생성을 자동화 하기 위한 작업  */
USE [DR2_Def]
GO
/****** Object:  StoredProcedure [dbo].[UP_UpdateBaseCharacter]    Script Date: 07/28/2009 17:43:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Object:  StoredProcedure [dbo].[UP_UpdateBaseCharacter3]    Script Date: 07/28/2009 17:44:54 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UP_UpdateBaseCharacter3]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[UP_UpdateBaseCharacter3]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UP_Admin_UpdateBaseCharacter]') AND type in(N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[UP_Admin_UpdateBaseCharacter]
END
GO

CREATE PROCEDURE [dbo].[UP_Admin_UpdateBaseCharacter]
/*
////////////////////////////////////////////////////////////////////////
//
// 프로시져명: [dbo].[UP_UpdateBaseCharacter]
//	PARAMETER:
//	@CharName : 복사해 올 Character name
// N O T E : 작성해놓은Base Character 정보를BaseCharacter Table에옮겨놓는로직
//		게임내부에서호출되지않고, 임의로호출해주어야한다.
//
//	2008-10-10 : Face,Hair 등기본모양정보도추가
//	2008-12-09 : 육정범종료퀘스트저장공간늘림
//	2008-12-12 : Eric Kim, 퀘스트관련정보는무조건초기화되도록변경
//	2009-03-12 : 이훈인밴토리확장정보추가
//	2009-07-28 : Eric Kim, Level<>1 이 아닐 경우, RecentMap/RecentVillage 값도 복사하도록 수정
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
	DECLARE @CP int
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
	DECLARE @IngQuest binary(300)
	DECLARE @EndQuest binary(130)
	DECLARE @EndQuest2 binary(130)
	DECLARE @EndQuestExt binary(260)
	DECLARE @EndQuestExt2 binary(480)
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
		,@CP = [TB_CharSub].[CP]
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
		,@EndQuestExt = [TB_CharSub].[f_EndQuestExt]
		,@EndQuestExt2 = [TB_CharSub].[f_EndQuestExt2]
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
	IF EXISTS ( SELECT 1 FROM [dbo].[TB_DefBaseCharacter2] WHERE f_Class = @Class )
	BEGIN
		-- DELETE
		DELETE FROM [dbo].[TB_DefBaseCharacter2] WHERE f_Class = @Class
		DELETE FROM [DR2_User].[dbo].[TB_DefBaseUserItem] WHERE f_Class = @Class
	END

	IF @LV = 1
	BEGIN
		-- 새로운캐릭터가처음접속하는Map이Tutorial_Indun_Map 이되어
		-- @LastVillage 값을강제로0으로세팅한다.
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
	END
	INSERT INTO [dbo].[TB_DefBaseCharacter2]
		([f_Class] ,[f_State] ,[f_Race] ,[f_Lv] ,[f_Exp]
		,[f_Money] ,[f_HP] ,[f_MP] ,[f_CP], [f_ExtraSkillPoint] ,[f_Skills]
		,[f_RecentMap] ,[f_RecentLocX] ,[f_RecentLocY] ,[f_RecentLocZ] ,[f_LastVillage]
		,[f_LastVillageLocX] ,[f_LastVillageLocY] ,[f_LastVillageLocZ] ,[f_QuickSlot] ,[f_IngQuest]
		,[f_EndQuest], [f_EndQuest2], [f_EndQuestExt], [f_EndQuestExt2], [f_Gender], [f_HairStyle], [f_HairColor],
		[f_Face], [f_Jacket] ,[f_Gloves] ,[f_Pants] ,[f_Shoes],[f_InvExtend])
		VALUES (
		@Class, @State, @Race, @Lv, @Exp,
		@Money, @HP, @MP, @CP, @ExtraSkillPoint, @Skills,
		@RecentMap, @RecentLocX, @RecentLocY, @RecentLocZ, @LastVillage,
		@LastVillageLocX, @LastVillageLocY, @LastVillageLocZ, @QuickSlot, @IngQuest,
		@EndQuest, @EndQuest2, @EndQuestExt, @EndQuestExt2, @Gender, @HairStyle, @HairColor,
		@Face, @Jacket ,@Gloves ,@Pants ,@Shoes,@InvExtend)
	IF @@ROWCOUNT <> 1
	BEGIN
		SET @Error = 2
		GOTO ErrorHandler
	END

	INSERT INTO [DR2_User].[dbo].[TB_DefBaseUserItem]
		([f_Class] ,[f_InvType] ,[f_InvPos] ,[f_ItemNo] ,[f_Count]
		,[f_Enchant_01] ,[f_Enchant_02] ,[f_Enchant_03] ,[f_Enchant_04], [f_State])
		SELECT @Class, itemA.[InvType] ,itemA.[InvPos] ,itemA.[ItemNo] ,itemA.[Count]
			,ISNULL(itemB.[Enchant_01],0), ISNULL(itemB.[Enchant_02],0), ISNULL(itemB.[Enchant_03],0), ISNULL(itemB.[Enchant_04],0), itemA.[State] 
			FROM [DR2_User].[dbo].[TB_UserItem] AS itemA LEFT JOIN [DR2_User].[dbo].[TB_UserItem_Enchant] AS itemB 	ON itemA.[ItemGuid] = itemB.[ItemGuid]
			WHERE [OwnerGuid] = @CharacterGuid
	return @Error

ErrorHandler:
	return @Error
	
END

