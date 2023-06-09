USE DR2_User

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Update_TB_UserCharacter_InvExtend]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[up_Update_TB_UserCharacter_InvExtend]
END 
GO


CREATE PROC [dbo].[up_Update_TB_UserCharacter_InvExtend] 
/*
////////////////////////////////////////////////////////////////////////
//
// 프로시져명 : up_Update_TB_UserCharacter_InvExtend
// 작 성 자 : 이훈
// 작 성 일 : 2009-03-12
// 최종수정자 :
// 수 정 일 : 
// 파 일 명 : 
// N O T E : 인벤토리 확장정보 저장
//
////////////////////////////////////////////////////////////////////////
*/
	@CharacterID uniqueidentifier,
	@Value BINARY(40)
AS
SET NOCOUNT ON
SET LOCK_TIMEOUT 5000
SET XACT_ABORT ON	
SET NOCOUNT ON
SET XACT_ABORT ON	

UPDATE dbo.TB_CharacterSub Set InvExtend = @Value Where CharacterID = @CharacterID


GO