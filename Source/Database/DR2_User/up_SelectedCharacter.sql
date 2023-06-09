USE [DR2_User]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_SelectedCharacter]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_SelectedCharacter]

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[up_SelectedCharacter]
/*
////////////////////////////////////////////////////////////////////////
//
// 프로시져명: 선택캐릭터값받기
// 작성자: Richard Kim(tigerjune@barunsoninter.com)
// 작성일: 2009-06-24
// 최종수정자:
// 수정일: 
// 파일명: 
// N O T E :
//	2008-10-29 : 이훈, RentalDate1,2,3 추가
//	2008-10-23 : YonMy OutPut사용없앰
//	2008-10-29 : 캐시로구입하는창고사용시간얻어오도록수정
//	2008-11-19 : 이훈오픈마켓쿼리문수정
//	2008-11-28 : 이훈SELECT COUNT(*) 쿼리삭제처리
//	2008-12-09 : 육정범종료퀘스트저장공간늘림
//	2009-02-04 : YonMy [TB_UserCharacter_Point]의Mail정보Select 제거
//	2009-02-06 : YonMy [TB_UserCharacter_Point]의CrystalStoneCount 정보제거
//	2009-02-12 : YonMy [GMLevel제거]
//	2009-03-03 : 이훈 아이템언바인드정보쿼리추가
//	2009-03-12 : 이훈 인밴토리 확장/축소 정보 추가
//	2009-03-13 : 이훈 캐릭터 카드 정보 쿼리 추가
//	2009-03-23 : 김승현, Buff(Effect) 정보 읽어 오기 추가
//	2009-06-23 : 윤상현, Mission_Event추가 (랭크)
//	2009-06-24 : YonMy, Pet 정보 읽어 오기 추가
// 	2009-08-21 : 윤상현, ColorGuid 추가
//	2009-08-21 : YonMy, Pet 2차 정보 추가
//	2009-08-25 : YonMy, 아이템 관련 정보 SP한개로 통합
//	2009-09-28 : EricKim, ActiveStatus 작업(STR, INT, DEX, CON 읽어오기)
//	2009-11-10 : 윤상현, Hidden_Open(히든 체크)
//	2010-01-18 : YonMy, 제2케릭터 생성유도 System(케릭터 Level순위 읽어오기)
//	2010-02-04 : 심헌섭, 스킬세트 정보 읽어 오기 추가
//  2010-02-11 : Acepm, 현상수배 퀘스트 완료 카운트 읽어오기 추가
//	2010-02-17 : gschool, 업적 사용 기간 추가
//	2010-03-31 : 심헌섭, 전략 스킬 구성 추가
//	2010-04-06 : 박정현, 캐릭터 갯수 초과 처리 추가
//	2010-11-22 : 조현건, 스킬 쿨타임 추가
//	2010-11-22 : 조현건, 로그아웃한 시점으로 부터 얼마나 지났는지 시간값 추가
//  2011-05-26 : 김종수, 원정대 채널로 이동 할 때 이전 채널정보(채널번호, 맵번호, 위치, 저장상태) 정보 읽어오기 추가.
//	2011-07-22 : 김종수, 전략 피로도 읽어오기 추가.
//	2012-01-04 : 김종수, 채팅 차단 리스트 읽어오기 추가.
////////////////////////////////////////////////////////////////////////
*/
(
	@CharacterID	UNIQUEIDENTIFIER,
	@PassTutorial	TINYINT,
	@MemberID		uniqueidentifier
--	@ItemCount int OUTPUT,
--	@AchieveCount int OUTPUT,
--	@HasMarket int OUTPUT,
--	@ArticleCount int OUTPUT,
--	@DealingCount int OUTPUT
)
AS
SET NOCOUNT ON
SET XACT_ABORT ON
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED


/*직업스킬 시작*/ 
declare @jCnt int
select   @jCnt =count(f_charguid)  from TB_UserJobSkill_Expertness
               where f_skillno in(
                           '85000100' , '85000200' , '85000300' , '85000400' ,  '85000500' , '85000600' , 
                           '85000700' , '85000800' ,  '85091601' , '85091701' ,  '85091901' , '85092001', 
						   '85092201'
                    ) and f_charguid = @CharacterID
if(@jCnt>0 and  @jCnt<13)
BEGIN
	DECLARE @skills varchar(max)
	SET @skills = '85000100850002008500030085000400850005008500060085000700850008008509160185091701850919018509200185092201'
	DECLARE @len int    
	SET @len = LEN(@skills)    

	DECLARE @i int    
	  
	DECLARE @skillno int    
	  
	SET @i = 1    
 
	 while(@i<@len) BEGIN   
             select @skillno =CONVERT(int, SUBSTRING(@skills, @i, 8))    
              
             SET @i =@i+8   
             if not exists(select * from TB_UserJobSkill_Expertness where f_charguid = @CharacterID and f_skillno =@skillno) 
             BEGIN
				 insert into dbo.TB_UserJobSkill_Expertness(f_charguid, f_skillno, f_expertness)
				 select @CharacterID, @skillno , 1000000 
             END 
			 
	END			     
END                  
                    
                    
/*직업스킬 끝*/  


DECLARE @CharacterCount int
DECLARE @ExternCount int
DECLARE @DefaultCount int

SELECT @CharacterCount = count(A.[MemberID]), @ExternCount = B.ExtendCharacterNum
FROM dbo.TB_CharacterBasic AS A
LEFT JOIN dbo.TB_Member_ShareData AS b ON B.[MemberKey] = A.[MemberID]
WHERE A.[STATE] = 0 AND A.[MemberID] = @MemberID		
group by A.[MemberID], B.ExtendCharacterNum

SET @DefaultCount = 4
IF @ExternCount IS NULL
BEGIN
	SET @ExternCount = 0
END

IF @CharacterCount > @DefaultCount+@ExternCount
BEGIN
	RETURN 99
END

SELECT @PassTutorial

SELECT
	A.[MemberID],						-- 1
	A.[CharacterID],
	A.[State],
	A.[Name],								
	A.[Gender],							-- 5
	A.[Race],
	B.[Class],
	B.[Lv],
	B.[Exp],							
	B.[Money],							-- 10
	B.[HP],
	B.[MP],
	B.[CP],
	B.[ExtraSkillPoint],				
	B.[Skills],							-- 15
	B.[SkillExtend],
	B.[Strategyfatigability],
	A.[HairColor],	-- >> 순서바꾸지마시오(클라이언트와맞음)
	A.[HairStyle],
	A.[Face],							-- 20
	A.[Jacket],							
	A.[Pants],
	A.[Shoes],
	A.[Gloves],
	G.CoupleCharGuid,					-- 25
	F.GuildGuid,												
	B.[RecentMap],
	B.[RecentLocX],
	B.[RecentLocY],
	B.[RecentLocZ],						-- 30
	B.[LastVillage],					
	B.[LastVillageLocX],
	B.[LastVillageLocY],
	B.[LastVillageLocZ],
	B.[IngQuest],						-- 35
	B.[EndQuest],				
	B.[EndQuest2],
	B.[f_EndQuestExt],
	B.[f_EndQuestExt2],
	B.[QuickSlot],						-- 40
	A.[BirthDate],
	B.[TotalPlayTimeSec],
	A.[FiveElementBody],
	B.[Fran],
	B.[TacticsLevel],					-- 45
	B.[TacticsExp],
	B.[RecommendPoint],
	B.[RefreshDate],
	B.[Effect],
	B.[Emoticon],						-- 50
	B.[Emotion],
	B.[Balloon],
	B.[BonusStatus], B.[AddedSTR], B.[AddedINT], B.[AddedCON], B.[AddedDEX], -- 53, 57
	ISNULL(J.[f_GuildLeaveDate], CONVERT(DATETIME, N'2000-01-01 00:00:00')),
	B.[f_itemGroupCoolTime],			
	C.[f_JobSkill_HistoryItem],			-- 60
	C.[PremiumCustomData],
	C.[PvP_Point],
	C.[PvP_Win],
	C.[PvP_Draw],						-- 65
	C.[PvP_Lose],
	C.[PvP_Kill],
	C.[PvP_Death],
	C.[PvP_Win_Exercise],
	C.[PvP_Draw_Exercise],				-- 70
	C.[PvP_Lose_Exercise],
	C.[World01],
	C.[OptionInfo],
	C.[Mission_01],
	C.[Mission_02],						-- 75
	C.[Achievements],
	D.[MaxCombo],
	ISNULL(B.[RentalSafeDate1],'2000 - 01 - 10'),
	ISNULL(B.[RentalSafeDate2],'2000 - 01 - 10'),
	ISNULL(B.[RentalSafeDate3],'2000 - 01 - 10'),					-- 80
	B.[InvExtend],
	C.[Mission_Event],
	B.[ExtendIdx],
	H.[StreetNo],
	H.[HouseNo],						-- 85
	G.[ColorGuid],
	I.[ExtendCharacterNum],
	ISNULL(I.[ShareRentalTime1],'2000 - 01 - 10'),
	ISNULL(I.[ShareRentalTime2],'2000 - 01 - 10'),
	ISNULL(I.[ShareRentalTime3],'2000 - 01 - 10'),					-- 90
	ISNULL(I.[ShareRentalTime4],'2000 - 01 - 10'),
	C.[Hidden_Open],
	ISNULL(C.[LastHiddenUpdate],'2000 - 01 - 10'),
	B.[SkillSetItemCount],
	B.[SkillTabOpen],					-- 95
	B.[SkillTabNo],	
	B.[ExtraSkillPoint_Sec],
	B.[Skills_Sec],
	B.[SkillExtend_Sec],
	B.[QuickSlot_Sec],					-- 100
	B.[f_RecentChannel],
	B.[f_RecentChannelMap],
	B.[f_RecentChannelLocX],
	B.[f_RecentChannelLocY],
	B.[f_RecentChannelLocZ],			-- 105
	B.[f_RecentChannelState]
FROM dbo.TB_CharacterBasic  A 
JOIN dbo.TB_CharacterSub B ON  A.[CharacterID] = B.[CharacterID]
JOIN [dbo].[TB_UserCharacter_Extern] C ON  A.[CharacterID] = C.[CharacterID]
JOIN [dbo].[TB_UserCharacter_Point] D ON  A.[CharacterID] = D.[CharacterID]
LEFT JOIN dbo.TB_Guild_Member F ON A.[CharacterID] = F.CharacterGuid
LEFT JOIN dbo.TB_UserCouple G ON A.[CharacterID] = G.CharacterGuid
LEFT JOIN dbo.TB_User_MyHome_Base H ON A.[CharacterID] = H.[OwnerGuid]
LEFT JOIN dbo.TB_Member_ShareData I ON A.[MemberID] = I.[MemberKey]
LEFT JOIN dbo.TB_UserCharacter_DateContents AS J ON A.[CharacterID] = J.[f_CharacterID]
WHERE A.[CharacterID] = @CharacterID AND A.[State] = 0 AND B.[CharacterID] = @CharacterID
AND C.[CharacterID] = @CharacterID AND D.[CharacterID] = @CharacterID

IF @@ROWCOUNT <> 1
BEGIN
	RETURN 99
END

--2.현상수배 퀘스트
SELECT [QuestID],[ClearCount] FROM dbo.TB_UserWantedQuest WHERE CharacterID = @CharacterID

--3.아이템
EXEC [dbo].[up_Item_Select] @CharacterID
EXEC [dbo].[up_Item_Select] @MemberID
	
--4. 업적
--SELECT @AchieveCount = count(*) from dbo.tb_UserAchievements where charguid = @CharacterID
SELECT [type], [value] FROM dbo.tb_UserAchievements WHERE charguid = @CharacterID
select [Achievementidx], [TimeLimit] from dbo.TB_UserAchievement_TimeLimit where ownerguid = @CharacterID
select Category, Point FROM dbo.TB_UserAchievementRank WHERE OwnerGuid = @CharacterID

--5. 유저 저장 포탈 위치
SELECT [PortalGuid]
      ,[Comment]
      ,[GroundNo]
      ,[x]
      ,[y]
      ,[z]
  FROM [dbo].[TB_UserPortal] WHERE CharacterGuid = @CharacterID

--6. 캐릭터 카드
SELECT	[CharacterGuid],[Year],[Sex],[Local],[PopularPoint],[TodayPopularPoint],[Comment],[Enable],
		[Constellation],[Blood],[Hobby],[Style],[BGndNo]
		FROM [dbo].[TB_UserCharacter_Card] WHERE CharacterGuid = @CharacterID

--7. SkillSet
SELECT [SetNo],[TabNo]
      ,[Delay01],[Type01],[SkillNo01] ,[Delay02],[Type02],[SkillNo02] ,[Delay03],[Type03],[SkillNo03]
      ,[Delay04],[Type04],[SkillNo04] ,[Delay05],[Type05],[SkillNo05] ,[Delay06],[Type06],[SkillNo06]
      ,[Delay07],[Type07],[SkillNo07] ,[Delay08],[Type08],[SkillNo08] ,[Delay09],[Type09],[SkillNo09]
      ,[Delay10],[Type10],[SkillNo10]
FROM [dbo].[TB_UserSkillSet]
WHERE [CharacterID] = @CharacterID

--8-1. 접속시간 유지시 지급되는 이벤트 보상.
SELECT [LastRewardCount], [LastRewardTime], [IsKeepConn] FROM dbo.TB_SpecificReward
WHERE [CharacterID] = @CharacterID AND [Type] = 50602

--8-2. 1일 1회 지급되는 보급상자를 마지막으로 지급 받은 시간
SELECT [LastRewardTime] FROM dbo.TB_SpecificReward
WHERE [CharacterID] = @CharacterID AND [Type] = 50600

--9. Penalty
SELECT [Type], [Value], [EndDate]
FROM [dbo].[TB_Penalty]
WHERE [CharacterID] = @CharacterID

--10. Character 생성 유도 System
DECLARE @Lv SMALLINT

SELECT	@Lv = [Lv]
FROM	[dbo].[TB_CharacterSub]
WHERE	[CharacterID] = @CharacterID

IF 1 = @@ROWCOUNT 
BEGIN
	EXEC [dbo].[up_SelectCharacterLevel_Rank] @MemberID, @Lv
END
ELSE
BEGIN
	SELECT 0
END

--11. JobSkill
SELECT [f_Exhaustion], [f_LastResetExhaustionTime], [f_BlessPoint] ,[f_LastResetBlessPointTime] FROM [dbo].[TB_UserJobSkill_Exhaustion] WHERE [f_CharGuid] = @CharacterID
SELECT [f_SkillNo] ,[f_Expertness] FROM [dbo].[TB_UserJobSkill_Expertness] WHERE [f_CharGuid] = @CharacterID

-- 12. 로그아웃한 시간과 현재 시간의 갭
DECLARE @NowTime DATETIME
DECLARE @SavedTime DATETIME
SET @NowTime = GETDATE()
SELECT DATEDIFF(second, [f_LogOutTime], @NowTime) FROM [dbo].[TB_CharacterSub] WHERE [CharacterID] = @CharacterID

-- 13.Skill CoolTime
SELECT [SkillNo] ,[CoolTime] FROM [dbo].[TB_User_Skill_CoolTime] WHERE [CharacterID] = @CharacterID

--14. 채팅차단 정보.

SELECT [BlockName], [BlockType]
FROM [dbo].[TB_user_ChatBlock]
WHERE CharacterID = @CharacterID

--15. 오픈마켓정보 (Last)
--SELECT @HasMarket = COUNT(*) FROM [dbo].[TB_UserMarketInfo] WHERE CharGuid = @CharacterID
SELECT A.[CharGuid],A.[MarketName],B.[Name],A.[Grade],A.[State],A.[GenTime],A.[OfflineCloseTime],A.[OnlineCloseTime],A.[MarketCloseTime],A.[MarketHP] 
FROM [dbo].[TB_UserMarketInfo2] AS A
INNER JOIN [dbo].[TB_CharacterBasic] AS B ON A.CharGuid = B.CharacterID
WHERE CharGuid = @CharacterID

--SELECT @ArticleCount = COUNT(*) FROM [dbo].[TB_UserMarket] WHERE [SellerGuid] = @CharacterID
SELECT	[SellCost],[CostType],[ItemGuid],[ItemName],[ItemGrade],[LimitLevel],[InvType],[ItemType],[ClassLimit]
FROM [dbo].[TB_UserMarket] WHERE [SellerGuid] = @CharacterID

--SELECT @DealingCount = COUNT(*) FROM [dbo].[TB_UserDealings] WHERE [CharacterGuid] = @CharacterID
SELECT [ItemGuid],isnull(DealerName,B.[Name]),[ItemNo],[ItemNum],[Enchant_01],[Enchant_02],[Enchant_03],[Enchant_04],[SellCost],[CostType],[ItemState],[ItemGenTime],[CostRate]
FROM [dbo].[TB_UserDealings] AS A
INNER JOIN [dbo].[TB_CharacterBasic] AS B ON B.CharacterID = A.CharacterGuid
WHERE [CharacterGuid] = @CharacterID

RETURN 0







