USE [DR2_User]
GO
/****** Object:  StoredProcedure [dbo].[up_CleanDeleteCharacter]    Script Date: 06/01/2009 17:51:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Object:  StoredProcedure [dbo].[up_UpdateDeletedCharacterName]    Script Date: 06/01/2009 18:11:41 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_UpdateDeletedCharacterName]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_UpdateDeletedCharacterName]
GO

/*
////////////////////////////////////////////////////////////////////////
// Description : 일정시간 지난 삭제된 Character 이름 변경 하기
// [PARAMETER] : 
// [RETURN] : 
// [REMARK]
//	2009-06-01 : Eric Kim, 
////////////////////////////////////////////////////////////////////////
*/
CREATE Proc [dbo].[up_UpdateDeletedCharacterName]
(
	@MaxDelayHour int
)
AS

BEGIN
	DECLARE @Today datetime
	SET @Today = GETDATE()

	UPDATE [dbo].[TB_CharacterBasic] SET [Name] = N'__D__' WHERE [State] = 1 and DATEDIFF(hh, ISNULL([DeleteDate], @Today), @Today) >= @MaxDelayHour AND [Name] <> N'__D__'
END

