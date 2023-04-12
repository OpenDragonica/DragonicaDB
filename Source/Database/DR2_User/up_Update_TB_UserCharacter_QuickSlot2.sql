USE DR2_User

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Update_TB_UserCharacter_QuickSlot2]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[up_Update_TB_UserCharacter_QuickSlot2] 
END 


set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

CREATE PROC [dbo].[up_Update_TB_UserCharacter_QuickSlot2] 
/*
////////////////////////////////////////////////////////////////////////
//
// ���ν�����: DR2_User.dbo.up_Update_TB_UserCharacter_Field
// �ۼ���: Richard Kim(tigerjune@barunsoninter.com)
// �ۼ���: 2008-09-19
// ����������:
// ������: 
// ���ϸ�: 
// N O T E : ĳ�����̺����ش��÷����������Ѵ�.
//
//	2008-10-08 : Eric Kim, Character Table �ΰ��γ�������������
//	2009-04-01 : ���強, ������ų �߰��� Second ������ ������ �� �ֵ��� ����
////////////////////////////////////////////////////////////////////////
*/
	@CharacterID uniqueidentifier,
	@Second	tinyint,
	@QuickSlot	binary(281)
AS
SET NOCOUNT ON
SET XACT_ABORT ON	

IF 1 = @Second
BEGIN
	UPDATE dbo.TB_CharacterSub Set QuickSlot_Sec = @QuickSlot Where CharacterID = @CharacterID
END
ELSE
BEGIN
	UPDATE dbo.TB_CharacterSub Set QuickSlot = @QuickSlot Where CharacterID = @CharacterID
END


GO

