USE [DR2_User]
GO

IF EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_SaveSelectedSlot]') AND [TYPE] in (N'P'))
BEGIN
	DROP PROCEDURE [dbo].[up_SaveSelectedSlot]
END

/****** Object:  StoredProcedure [dbo].[up_SaveSelectedSlot]    Script Date: 11/04/2011 18:37:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
////////////////////////////////////////////////////////////////////////
// Lasst Update by : 
// Update date  : 
// Description : 
// [PARAMETER] : 
// [RETURN] : 
// [REMARK]
//	2008-12-09 : ������ ���� ����Ʈ ������� �ø�
//	2008-12-29 : Eric Kim, ContentsServer �� Data�� �����ϵ��� ����
//	2010-03-31 : ���強, ��ų���� ���� ����
//	2010-11-22 : ������, ĳ���� ��������ð� ����
////////////////////////////////////////////////////////////////////////
*/
CREATE PROCEDURE [dbo].[up_SaveSelectedSlot]
(
	@CharacterID UNIQUEIDENTIFIER,		--1
	@CharactorSlot TINYINT
)
AS
SET NOCOUNT ON

DECLARE @iErr INT
SET @iErr = 0

	UPDATE dbo.TB_CharacterSub SET
		f_CharactorSlot = @CharactorSlot
		WHERE CharacterID = @CharacterID
	
	IF @@ROWCOUNT <> 1
	BEGIN
		SET @iErr = 99
	END	

	ELSE
	BEGIN
		SET @iErr = 1
	END	

SELECT @iErr
RETURN @iErr
