USE [DR2_User]
GO
/****** Object:  StoredProcedure [dbo].[up_CleanDeleteCharacter]    Script Date: 01/25/2011 17:06:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_CleanDeleteCharacter]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_CleanDeleteCharacter]
GO

/*
////////////////////////////////////////////////////////////////////////
// Description : 오래된 삭제된 Character 실제로 지우기
// [PARAMETER] : 
// [RETURN] : 
// [REMARK]
//	2009-01-26 : Eric Kim, 
//	2011-01-25 : 커서 Close, Deallocate
////////////////////////////////////////////////////////////////////////
*/
CREATE Proc [dbo].[up_CleanDeleteCharacter]
(
	@MaxDelayDay int
)
AS

BEGIN
	DECLARE @CharacterGuid uniqueidentifier
	DECLARE @Today datetime

	SET @Today = GETDATE()
	DECLARE Delete_Cursor CURSOR FOR
		SELECT CharacterID  FROM [dbo].[TB_CharacterBasic] WHERE State = 1 and DATEDIFF(d, ISNULL([DeleteDate], @Today), @Today) > @MaxDelayDay
	OPEN Delete_Cursor;
	FETCH NEXT FROM Delete_Cursor
	INTO @CharacterGuid

	WHILE @@FETCH_STATUS = 0
	BEGIN
		EXEC dbo.[UP_DeleteUserCharacterSub] @CharacterGuid, 100

		DELETE [dbo].[TB_CharacterSub] WHERE CharacterID = @CharacterGuid;
		DELETE [dbo].[TB_CharacterBasic] WHERE CharacterID = @CharacterGuid;
		
		FETCH NEXT FROM Delete_Cursor
		INTO @CharacterGuid
	END
	
	CLOSE Delete_Cursor
	DEALLOCATE Delete_Cursor
END


