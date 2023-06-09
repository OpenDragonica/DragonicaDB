USE [DR2_User]
GO

IF EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UP_Change_Character_EndQuest3]') AND [type] in (N'P'))
BEGIN
	DROP PROCEDURE [dbo].[UP_Change_Character_EndQuest3]
END

IF EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UP_Change_Character_EndQuest]') AND [type] in (N'P'))
BEGIN
	DROP PROCEDURE [dbo].[UP_Change_Character_EndQuest]
END

/****** Object:  StoredProcedure [dbo].[UP_Change_Character_EndQuest3]    Script Date: 10/13/2009 12:10:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/*
//=============================================
// Author:		<육정범>
// Create date: <08/09/20>
// Update : <Eric Kim> 2008.10.07
// Description:	<퀘스트 End만 저장하도록 Binary(130)>
//	2008.10.07 : Table 이름변경 적용
//	2008-12-09 : 종료 퀘스트 저장공간 늘림
//	2009-10-xx : 종료 퀘스트 저장공간 늘림
//=============================================
*/
CREATE PROCEDURE [dbo].[UP_Change_Character_EndQuest]
@CharGuid UNIQUEIDENTIFIER,
@EndQuest BINARY(130),
@EndQuest2 BINARY(130),
@EndQuestExt BINARY(260),
@EndQuestExt2 BINARY(480)
AS
BEGIN
	SET NOCOUNT ON;
	UPDATE [dbo].[TB_CharacterSub]
		SET
			[EndQuest] = @EndQuest,
			[EndQuest2] = @EndQuest2,
			[f_EndQuestExt] = @EndQuestExt,
			[f_EndQuestExt2] = @EndQuestExt2
		WHERE [CharacterID] = @CharGuid;
END
