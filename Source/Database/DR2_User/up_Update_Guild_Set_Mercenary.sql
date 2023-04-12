USE [DR2_User]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Update_Guild_Set_Mercenary]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[up_Update_Guild_Set_Mercenary]
END
GO

CREATE PROCEDURE [dbo].[up_Update_Guild_Set_Mercenary]
/*
////////////////////////////////////////////////////////////////////////
//
// ���ν����� : up_Update_Guild_Set_Mercenary
// �� �� �� : YonMy
// �� �� �� : 2010-02-05
// ���������� : 
// �� �� �� : 
// �� �� �� : YonMy
// N O T E : 
////////////////////////////////////////////////////////////////////////
*/
(
	@GuildGuid		uniqueidentifier,
	@ClassLimit		bigint,
	@LevelLimit		smallint
)
AS
SET XACT_ABORT ON
SET NOCOUNT ON

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

DECLARE @Ret int
SET @Ret = 0

BEGIN
	
	IF NOT EXISTS (SELECT 1 FROM [dbo].[TB_Guild_Set_Mercenary] WHERE [GuildGuid] = @GuildGuid)
	BEGIN
	
		INSERT INTO [dbo].[TB_Guild_Set_Mercenary]
		(
			[GuildGuid],
			[ClassLimit],
			[LevelLimit]
		)
		VALUES
		(
			@GuildGuid,
			@ClassLimit,
			@LevelLimit
		)
		
	END
	ELSE
	BEGIN
	
		UPDATE	[dbo].[TB_Guild_Set_Mercenary]
		SET		[ClassLimit] = @ClassLimit
			,	[LevelLimit] = @LevelLimit
		WHERE	[GuildGuid] = @GuildGuid
		
	END
	
END
RETURN @Ret
GO
