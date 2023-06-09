USE [DR2_User]
GO

IF EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'up_Change_Character_IngQuest') AND [TYPE] in (N'P'))
BEGIN
	DROP PROCEDURE [dbo].[up_Change_Character_IngQuest]
END

/****** Object:  StoredProcedure [dbo].[up_Change_Character_IngQuest]    Script Date: 10/08/2009 18:14:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<육정범>
-- Create date: <08/09/20>
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[up_Change_Character_IngQuest]
@CharGuid UNIQUEIDENTIFIER,
@IngQuest BINARY(350)
AS
BEGIN
	SET NOCOUNT ON;
	UPDATE [dbo].[TB_CharacterSub] SET [IngQuest] = @IngQuest WHERE [CharacterID] = @CharGuid;
	select @@error
END

