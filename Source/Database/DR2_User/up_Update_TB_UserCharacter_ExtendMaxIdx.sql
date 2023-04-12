USE [DR2_User]
GO
/****** Object:  StoredProcedure [dbo].[up_Update_TB_UserCharacter_ExtendMaxIdx]    Script Date: 07/13/2009 20:58:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Update_TB_UserCharacter_ExtendMaxIdx]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_Update_TB_UserCharacter_ExtendMaxIdx]

USE [DR2_User]
GO
/****** Object:  StoredProcedure [dbo].[up_Update_TB_UserCharacter_ExtendMaxIdx]    Script Date: 07/13/2009 20:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROC [dbo].[up_Update_TB_UserCharacter_ExtendMaxIdx] 
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

UPDATE dbo.TB_CharacterSub Set ExtendIdx = @Value Where CharacterID = @CharacterID


