USE [DR2_User]
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

/****** Object:  StoredProcedure [dbo].[up_Couple_Proc_UpdateColorInfo]    Script Date: 08/16/2009 15:23:52 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Couple_Proc_UpdateColorInfo]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[up_Couple_Proc_UpdateColorInfo]
END
GO

/*
////////////////////////////////////////////////////////////////////////
//
// ���ν����� : up_Couple_Proc_UpdateColorInfo
// �� �� �� : �� �� ��
// �� �� �� : 2009-8-16
// ���������� : 
// �� �� �� : 
// �� �� �� : 
// N O T E : ���̺��� �ش� �÷����� �����Ѵ�.
//
////////////////////////////////////////////////////////////////////////
*/

CREATE PROC [dbo].[up_Couple_Proc_UpdateColorInfo] 
	@CharacterID uniqueidentifier,
	@ColorValue uniqueidentifier = '00000000-0000-0000-0000-000000000000'
AS
SET NOCOUNT ON
SET XACT_ABORT ON	

UPDATE [dbo].[TB_UserCouple]
	SET 
		[ColorGuid]					= @ColorValue
	WHERE
		[CharacterGuid]				= @CharacterID

GO
