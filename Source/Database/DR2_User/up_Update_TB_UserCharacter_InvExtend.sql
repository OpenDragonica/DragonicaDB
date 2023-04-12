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
// ���ν����� : up_Update_TB_UserCharacter_InvExtend
// �� �� �� : ����
// �� �� �� : 2009-03-12
// ���������� :
// �� �� �� : 
// �� �� �� : 
// N O T E : �κ��丮 Ȯ������ ����
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