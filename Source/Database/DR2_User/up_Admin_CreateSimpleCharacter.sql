USE [DR2_User]
GO
/****** Object:  StoredProcedure [dbo].[up_Admin_CreateSimpleCharacter2]    Script Date: 07/28/2009 16:34:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Object:  StoredProcedure [dbo].[up_Admin_CreateSimpleCharacter2]    Script Date: 07/28/2009 16:40:35 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Admin_CreateSimpleCharacter2]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_Admin_CreateSimpleCharacter2]
GO


/****** Object:  StoredProcedure [dbo].[up_Admin_CreateSimpleCharacter]    Script Date: 07/28/2009 16:40:35 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Admin_CreateSimpleCharacter]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_Admin_CreateSimpleCharacter]
GO

CREATE PROC [dbo].[up_Admin_CreateSimpleCharacter]
/*
////////////////////////////////////////////////////////////////////////
//
// 프로시져명: [dbo].[UP_Admin_CreateSimpleCharacter]
// 작성자: Eric Kim
// 작성일: 2006-11-08
// 파일명: 
// N O T E :  테스트를위한Character 를생성한다.
//	2008-10-10 : Eric Kim, TB_Def2.TB_DefBaseCharacter2 참조하도록수정
//	2008-12-01 : Eric Kim, [dbo].[up_CreateCharacter2] 호출하도록수정
//	2008-12-09 : 육정범종료퀘스트저장공간늘림
//	2008-12-10 : 육정범, [dbo].[up_CreateCharacter3] 호출하도록수정
//	2009-01-15 : Eric Kim, up_CreateCharacter3 parameter 변경된것적용
//	2009-07-28 : Eric Kim, 최신 Character 정보에 맞도록 수정
////////////////////////////////////////////////////////////////////////
*/ 
@MemberID	UNIQUEIDENTIFIER,	-- MemberGuid
@Name		NVARCHAR(20),	-- 캐릭터이름
@InClass	INT			-- 클래스번호

AS
SET nocount ON

DECLARE @f_CharacterID	UNIQUEIDENTIFIER
DECLARE @f_Gender			TINYINT
DECLARE @f_Race			INT
DECLARE @f_Class			INT
DECLARE @f_Lv				SMALLINT
DECLARE @f_Exp			BIGINT
DECLARE @f_Money			BIGINT
DECLARE @f_HP				INT
DECLARE @f_MP				INT
DECLARE @f_ExtraSkillPoint	SMALLINT
DECLARE @f_Skills			BINARY(450)
DECLARE @f_PartyID		UNIQUEIDENTIFIER
DECLARE @f_GuildID		UNIQUEIDENTIFIER
DECLARE @f_RecentMap		INT
DECLARE @f_RecentLocX		FLOAT
DECLARE @f_RecentLocY		FLOAT
DECLARE @f_RecentLocZ		FLOAT
DECLARE @f_IngQuest		BINARY(160)
DECLARE @f_EndQuest		BINARY(130)
DECLARE @f_EndQuest2		BINARY(130)
DECLARE @f_QuickSlot		BINARY(240)
DECLARE @Err			INT
DECLARE @BasicGuid		UNIQUEIDENTIFIER
--------------------
DECLARE @f_InGender	TINYINT		-- 성별
DECLARE @f_HairStyle	INT			-- 머리모양
DECLARE @f_HairColor	INT			-- 머리색깔
DECLARE @f_Face		INT			-- 얼굴표정
DECLARE @f_Jacket		INT			-- 상의
DECLARE @f_Gloves		INT			-- 장갑
DECLARE @f_Pants		INT			-- 하의
DECLARE @f_Shoes		INT				-- 신발

DECLARE	@f_FiveElementBody		TINYINT	-- 5속성.
DECLARE	@f_State TINYINT
DECLARE	@f_GMLevel TINYINT
DECLARE	@f_CP INT
DECLARE	@f_LastVillage INT
DECLARE	@f_LastVillageLocX FLOAT
DECLARE	@f_LastVillageLocY FLOAT

DECLARE	@f_LastVillageLocZ FLOAT
DECLARE @f_InvExtend BINARY(40)

------------------------------------
PRINT '캐릭터메이크스타트'

SET @f_CharacterID	= NEWID()		
SET @f_FiveElementBody = 0
--SET @f_InGender = 1

SET @Err			= 0 -- 함부로바꾸지마시오C소스에서도0을사용함

	-- 캐릭터이름중복검사(서버에서도하지만DB에서한번더하자)
	DECLARE @count INT
	SET @count = 0
	SELECT @count = COUNT(1) FROM [dbo].[TB_CharacterBasic] WHERE Name = @Name
	IF @count > 0
	BEGIN
		SET @Err = 100-- 중복되는캐릭터이름이있음(C소스와에러번호같음CCR_OVERLAP_NAME)
		GOTO __rollback_tran
	END

	SELECT @count = COUNT(1) FROM [dbo].[TB_CharacterBasic] WHERE MemberID = @MemberID AND [State] = 0
	IF @count >= 4
	BEGIN
		SET @Err = 200--캐릭터갯수제한을초과하였음(max : 4개) (C소스와에러번호같음CCR_MAX_LIMINT)
		GOTO __rollback_tran
	END

	-- 기본지급Item/Skill 구하기
	SELECT @f_State=[f_State]
		,@f_Race = [f_Race]
		,@f_Lv = [f_Lv]
		,@f_Exp = [f_Exp]
		,@f_Money = [f_Money]
		,@f_HP = [f_HP]
		,@f_MP = [f_MP]
		,@f_CP = [f_CP]
		,@f_ExtraSkillPoint = [f_ExtraSkillPoint]
		,@f_Skills = [f_Skills]
		,@f_RecentMap = [f_RecentMap]
		,@f_RecentLocX = [f_RecentLocX]
		,@f_RecentLocY = [f_RecentLocY]
		,@f_RecentLocZ = [f_RecentLocZ]
		,@f_LastVillage = [f_LastVillage]
		,@f_LastVillageLocX = [f_LastVillageLocX]
		,@f_LastVillageLocY = [f_LastVillageLocY]
		,@f_LastVillageLocZ = [f_LastVillageLocZ]
		,@f_QuickSlot = [f_QuickSlot]
		,@f_IngQuest = [f_IngQuest]
		,@f_EndQuest = [f_EndQuest]
		,@f_EndQuest2 = [f_EndQuest2]
		,@f_InGender = [f_Gender]
		,@f_HairStyle = [f_HairStyle]
		,@f_Gender = [f_Gender]
		,@f_HairColor = [f_HairColor]
		,@f_Face = [f_Face]
		,@f_Jacket = [f_Jacket]
		,@f_Gloves = [f_Gloves]
		,@f_Pants = [f_Pants]
		,@f_Shoes = [f_Shoes]
		,@f_InvExtend = [f_InvExtend]
		FROM [DR2_Def].[dbo].[TB_DefBaseCharacter2] WHERE f_Class = @InClass
	IF @@rowcount <> 1 
	BEGIN
		SET @Err = 300-- TB_CharacterUser 에insert 실패(C소스와에러번호같음CCR_DB_ERR_1)
		GOTO __rollback_tran
	END

	EXEC [dbo].[up_CreateCharacter] 2, @MemberID, @Name, @f_InGender, @InClass, @f_HairStyle, 
		@f_HairColor, @f_Face, @f_Jacket, @f_Gloves, @f_Pants, @f_Shoes,
		@f_FiveElementBody,	@f_State,@f_Race,@f_Lv,@f_Exp,@f_Money ,@f_HP,@f_MP,
		@f_CP,@f_ExtraSkillPoint,@f_Skills,@f_QuickSlot,@f_IngQuest,@f_EndQuest,@f_EndQuest2,
		@f_InvExtend, 4
	SELECT @f_CharacterID = CharacterID FROM [dbo].[TB_CharacterBasic] WHERE [Name] = @Name
	IF @@ROWCOUNT <> 1
	BEGIN
		SET @Err = 400
		GOTO __rollback_tran
	END
	UPDATE [dbo].[TB_CharacterSub] SET RecentMap = @f_RecentMap, RecentLocX = @f_RecentLocX, RecentLocY = @f_RecentLocY, RecentLocZ = @f_RecentLocz,
		LastVillage = @f_LastVillage, LastVillageLocX = @f_LastVillageLocX, LastVillageLocY = @f_LastVillageLocY, LastVillageLocZ = @f_LastVillageLocZ
		WHERE [CharacterID] = @f_CharacterID

__commit_tan:
BEGIN
--	commit tran
	SELECT @Err, @f_CharacterID
	RETURN
END

__rollback_tran:
BEGIN
--	rollback tran
	SET @f_CharacterID = NULL
	SELECT @Err, @f_CharacterID
	RETURN
END