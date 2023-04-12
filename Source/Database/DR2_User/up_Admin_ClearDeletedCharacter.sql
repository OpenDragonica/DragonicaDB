IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Admin_ClearDeletedCharacter]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[up_Admin_ClearDeletedCharacter]
GO

/****** Object:  StoredProcedure [dbo].[up_Admin_ClearDeletedCharacter]    Script Date: 07/09/2009 11:30:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Proc [dbo].[up_Admin_ClearDeletedCharacter]
/*
////////////////////////////////////////////////////////////////////////
//
// ���ν����� : [dbo].[up_Admin_ClearDeletedCharacter]
// �� �� �� : Eric Kim
// �� �� �� : 2006-11-25
// �� �� �� : 
// N O T E :  ������������ ǥ�õ� Character�� DB���� ����
// RETURN : Error code
//
////////////////////////////////////////////////////////////////////////
*/
(
	@Confirm nvarchar(10)	-- �Ǽ��� �����ϱ� ���� Ȯ�� �޽��� �Է�
)
AS
SET NOCOUNT ON
begin
DECLARE @Err int
DECLARE @CharacterGuid uniqueidentifier
Set @Err = 0

	IF @Confirm  <> 'ImSure'
	BEGIN
		print('This procedure will delete ALL MEMBER and CHARACTER')
		print('If you are convinced that you know well what you will do and you are sure')
		print('EXEC UP_ClearAllMember ImSure')
		return
	END

-- Transaction �� ������ �ʿ䰡 ����.
-- Character Table ���� �ִµ� Member Table�� ���� Character ���� ���
DECLARE DelCursor1 CURSOR FOR
	SELECT CharacterID FROM [dbo].[TB_CharacterBasic] WHERE [State] = 1

OPEN DelCursor1;
FETCH NEXT FROM DelCursor1 INTO @CharacterGuid
WHILE (@@FETCH_STATUS = 0)
BEGIN
	EXEC [dbo].[up_DeleteUserCharacter] @CharacterGuid, 1, N'', 1
	FETCH NEXT FROM DelCursor1 INTO @CharacterGuid
END
CLOSE DelCursor1;
DEALLOCATE DelCursor1;


RETURN @ERR
end


GO