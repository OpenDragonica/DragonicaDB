USE [DR2_User]
GO

/****** Object:  StoredProcedure [dbo].[up_SaveEffect]    Script Date: 03/24/2009 15:16:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_SaveEffect]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_SaveEffect]

/****** Object:  StoredProcedure [dbo].[up_SaveEffect]    Script Date: 03/24/2009 15:13:20 ******/
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
////////////////////////////////////////////////////////////////////////
*/
CREATE PROCEDURE [dbo].[up_SaveEffect]
(
	@CharacterID UNIQUEIDENTIFIER,
	@Effect BINARY(200)
)
AS
SET NOCOUNT ON

DECLARE @iErr INT
SET @iErr = 0

	UPDATE dbo.TB_CharacterSub SET [Effect] = @Effect WHERE CharacterID = @CharacterID
	
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
