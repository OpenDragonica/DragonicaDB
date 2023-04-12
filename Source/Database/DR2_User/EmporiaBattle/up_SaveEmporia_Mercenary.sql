USE [DR2_User]
GO
/****** Object:  StoredProcedure [dbo].[up_SaveEmporia_Mercenary]    Script Date: 02/12/2010 15:05:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_SaveEmporia_Mercenary]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_SaveEmporia_Mercenary]
GO

CREATE PROCEDURE [dbo].[up_SaveEmporia_Mercenary]
/*
////////////////////////////////////////////////////////////////////////
//
// ���ν����� : [up_SaveEmporia_Mercenary]
// �� �� �� : Sim HeonSeop
// �� �� �� : 2010-02-12
// ���������� :
// �� �� �� :
// �� �� �� : 
// N O T E : 
//
////////////////////////////////////////////////////////////////////////
*/
(
	@EmporiaID uniqueidentifier,
	@BattleID uniqueidentifier,
	@Index smallint,
	@JoinGuidID uniqueidentifier,
	@CharacterGuid uniqueidentifier
)
AS
SET XACT_ABORT ON
SET NOCOUNT ON
SET LOCK_TIMEOUT 3000

DECLARE @Err int
SET @Err = 0

BEGIN
	
	INSERT [dbo].[TB_Emporia_Mercenary] ([EmporiaID],[BattleID],[Index],[JoinGuidID],[CharacterGuid])
	VALUES ( @EmporiaID, @BattleID, @Index, @JoinGuidID, @CharacterGuid )	 
	
	IF @@ERROR <> 0
	BEGIN
		SET @Err = 99
	END
END
RETURN @Err

