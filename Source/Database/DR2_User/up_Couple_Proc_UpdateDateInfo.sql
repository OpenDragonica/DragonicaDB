USE [DR2_User]
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

/****** Object:  StoredProcedure [dbo].[up_Couple_Proc_UpdateDateInfo]    Script Date: 07/10/2009 15:23:52 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Couple_Proc_UpdateDateInfo]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[up_Couple_Proc_UpdateDateInfo]
END
GO

/*
////////////////////////////////////////////////////////////////////////
//
// ���ν����� : up_Couple_Proc_UpdateDateInfo
// �� �� �� : �� �� ��
// �� �� �� : 2009-7-10
// ���������� : 
// �� �� �� : 
// �� �� �� : 
// N O T E : ���̺��� �ش� �÷����� �����Ѵ�.
//
////////////////////////////////////////////////////////////////////////
*/

CREATE PROC [dbo].[up_Couple_Proc_UpdateDateInfo] 
	@CharacterID uniqueidentifier,
	@DateValue DATETIME = NULL
AS
SET NOCOUNT ON
SET XACT_ABORT ON	

UPDATE [dbo].[TB_UserCouple]
	SET 
		[CouplePanaltyLimitDate]	= @DateValue
	WHERE
		[CharacterGuid]				= @CharacterID

GO
