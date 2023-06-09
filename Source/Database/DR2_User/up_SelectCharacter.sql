USE [DR2_User]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_SelectCharacter]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[up_SelectCharacter]
END
GO

CREATE PROCEDURE [dbo].[up_SelectCharacter]
/*
////////////////////////////////////////////////////////////////////////
//
// 프로시져명 : 게임 로그인시 초기 캐릭터 리스팅
// 작 성 자 : Richard Kim(tigerjune@barunsoninter.com)
// 작 성 일 : 2008-10-02
// 최종수정자 : YonMy
// 수 정 일 : 2009-02-12
// 파 일 명 : 
// N O T E : 
//
//	2008-10-09 : Eric Kim, 프로그램에서 output param이 안되어서 select 문의로 character count 받도록 수정
//	2008-10-23 : YonMy, output param을 SELECT로 다시 변경
//	2008-12-11 : 이훈, DB 모듈 기능 수정으로 리턴 결과 개수 사용 가능 다시 수정됨
//	2009-02-12 : YonMy, GMLevel 제거
//	2009-04-15 : EricKim, 최대레벨 보다 작은 캐릭터만 나오도록 하기
//  2009-08-21 : 윤상현, ColorGuid 추가
//  2011-04-11 : 조현건, 캐릭터 선택창 슬롯 위치 추가
//  2011-05-30 : 김종수, 캐릭터 마지막 채널 정보 추가.
//  2012-01-10 : 심헌섭, 점핑 캐릭터 이벤트 정보 추가.
//  2012-08-06 : ITEM 정보 쿼리 성능 최적화
//  2012-08-08 : 범준피엠님 최적화 작업 롤백(버그 있음)
////////////////////////////////////////////////////////////////////////
*/
(
	@MemberID	uniqueidentifier,
	@MaxLevel smallint,	-- 최대 레벨 제한
	@JumpingEventNo int	-- 점핑캐릭터
)
AS
SET NOCOUNT ON
SET XACT_ABORT ON
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

DECLARE @Err int
SET @Err = 0

DECLARE @NullGuid uniqueidentifier
SET @NullGuid = N'00000000-0000-0000-0000-000000000000'

--MemberID에 해당하는 전체 캐릭터셋
SELECT	@MemberID
	,	A.[CharacterID]
	,	A.[State]
	,	A.[Name]			
	,	A.[Gender]			-- 5
	,	A.[Race]
	,	B.[Class]
	,	B.[Lv]
	,	B.[Exp]				
	,	B.[Money]			-- 10
	,	B.[HP]
	,	B.[MP]
	,	A.[HairColor]
	,	A.[HairStyle]
	,	A.[Face]			-- 15
	,	A.[Jacket]
	,	A.[Pants]
	,	A.[Shoes]
	,	A.[Gloves]			
	,	ISNULL(C.[CoupleCharGuid], @NullGuid)	-- 20
	,	ISNULL(D.[GuildGuid], @NullGuid)
	,	B.[RecentMap]
	,	B.[RecentLocX]
	,	B.[RecentLocY]		
	,	B.[RecentLocZ]		-- 25
	,	B.[LastVillage]
	,	B.[LastVillageLocX]
	,	B.[LastVillageLocY]
	,	B.[LastVillageLocZ]
	,	A.[BirthDate]		-- 30
	,	B.[TotalPlayTimeSec]
	,	A.[FiveElementBody]	-- 32
	,	ISNULL(C.[ColorGuid], @NullGuid)
	,	C.[Status]
	,	B.[f_CharactorSlot]
	,	B.[f_RecentChannel]
	,	B.[f_RecentChannelMap]
	,	B.[f_RecentChannelLocX]
	,	B.[f_RecentChannelLocY]
	,	B.[f_RecentChannelLocZ]
	,	B.[f_RecentChannelState]
FROM dbo.TB_CharacterBasic  A
INNER JOIN TB_CharacterSub B  ON A.CharacterID = B.CharacterID
LEFT JOIN TB_UserCouple C  ON B.CharacterID = C.CharacterGuid
LEFT JOIN TB_Guild_Member D  ON C.CharacterGuid = D.CharacterGuid
WHERE A.[MemberID] = @MemberID AND A.[State] <> 1 AND (B.[Lv] <= @MaxLevel)

--캐릭별 장착중인 아이템
SELECT B.[ItemGuid], B.[OwnerGuid], B.[InvType], B.[InvPos],B.[ItemNo], B.[Count]
		, ISNULL(C.[Enchant_01],0) AS Enchant_01, ISNULL(C.[Enchant_02],0) AS Enchant_02
		, ISNULL(C.[Enchant_03],0) AS Enchant_03, ISNULL(C.[Enchant_04],0) AS Enchant_04
		, B.[State], B.[CreateDate]
FROM dbo.TB_UserItem B
JOIN TB_CharacterBasic AS A ON B.OwnerGuid = A.CharacterID
LEFT JOIN dbo.TB_UserItem_Enchant AS C ON B.ItemGuid = C.ItemGuid
WHERE A.[MemberID] = @MemberID AND A.[State] <> 1 and (B.InvType = 7 or B.InvType = 11)

--점핑이벤트체크
--LevelLimit체크는 프로그램에서 함.
SELECT RewardCount --남은 수량
FROM TB_JumpingCharEvent_State
WHERE EventNo = @JumpingEventNo AND MemberID = @MemberID

RETURN @Err
