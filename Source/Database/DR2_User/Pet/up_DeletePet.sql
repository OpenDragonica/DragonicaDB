USE [DR2_User]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_DeletePet]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_DeletePet]
GO

CREATE PROCEDURE [dbo].[up_DeletePet]
/*
////////////////////////////////////////////////////////////////////////
//
// ���ν�����: �� �����
// �ۼ���: YonMy(yonmy@barunsoninter.com)
// �ۼ���: 2009-06-23
// ����������: YonMy
// ������: 
// ���ϸ�: 
////////////////////////////////////////////////////////////////////////
*/
(
	@PetID			UNIQUEIDENTIFIER	-- Pet ID
)
AS
SET NOCOUNT ON
SET XACT_ABORT ON

DECLARE @Err INT
SET @Err = 0

BEGIN

	DELETE FROM [dbo].[TB_Pet]
	WHERE [PetID] = @PetID
	
	DELETE FROM [dbo].[TB_UserItem]
	WHERE [OwnerGUID] = @PetID
	
	IF @@ERROR <> 0
	BEGIN
		SET @Err = 1
	END
END

RETURN @Err