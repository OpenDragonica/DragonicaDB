USE [DR2_User]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_SaveEmporia_ChallengeBattle]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_SaveEmporia_ChallengeBattle]
GO

CREATE PROCEDURE [dbo].[up_SaveEmporia_ChallengeBattle]
/*
////////////////////////////////////////////////////////////////////////
//
// ���ν����� : �������� ��Ż�� ��û
// �� �� �� : YonMy
// �� �� �� : 2009-06-10
// ���������� :
// �� �� �� : 2010-07-11
// �� �� �� : ���強
// N O T E : ������� ����(����ġ->�����)�� ���� ����
//
////////////////////////////////////////////////////////////////////////
*/
(
	@EmporiaID uniqueidentifier,
	@BattleID uniqueidentifier,
	@GuildID uniqueidentifier,
	@Cost bigint,
	@RegistDate datetime,
	@State tinyint
)
AS
SET XACT_ABORT ON
SET NOCOUNT ON
SET LOCK_TIMEOUT 3000

DECLARE @Err int
Set @Err = 0

BEGIN TRAN
		
	INSERT INTO [dbo].[TB_Emporia_ChallengeBattle]
	(
		[EmporiaID]
	,	[BattleID]
	,	[GuildID]
	,	[Exp]
	,	[RegistDate]
	,	[State]
	)
	values
	(
		@EmporiaID
	,	@BattleID
	,	@GuildID
	,	@Cost
	,	@RegistDate
	,	@State
	)

	if @@ERROR <> 0
	BEGIN
		Set @Err = 99
		GOTO ErrorHandler		
	END

COMMIT TRAN
SELECT @Err, @Cost
RETURN @Err

ErrorHandler:
ROLLBACK TRAN
SELECT @Err
RETURN @Err
GO
