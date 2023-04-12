USE [DR2_User]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_SaveEmporia_BattleRefundExp]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_SaveEmporia_BattleRefundExp]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_SaveEmporia_BattleRefundCost]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_SaveEmporia_BattleRefundCost]
GO

CREATE PROCEDURE [dbo].[up_SaveEmporia_BattleRefundCost]
/*
////////////////////////////////////////////////////////////////////////
//
// ���ν����� : ��Ż�� ����ġ ȯ��
// �� �� �� : YonMy
// �� �� �� : 2009-06-10
// ���������� : ���強
// �� �� �� : 2010-07-11
// �� �� �� : ���強
// N O T E : ������� ����(����ġ->�����)�� ���� ����
//
////////////////////////////////////////////////////////////////////////
*/
(
	@BattleID uniqueidentifier,
	@GuildID uniqueidentifier
)
AS
SET XACT_ABORT ON
SET NOCOUNT ON
SET LOCK_TIMEOUT 3000

DECLARE @Err int
Set @Err = 0

BEGIN TRAN
	DECLARE @RefundCost BIGINT
	
	SELECT	@RefundCost = [Exp]
	FROM	[dbo].[TB_Emporia_ChallengeBattle]
	WHERE	[GuildID] = @GuildID AND [BattleID] = @BattleID
	
	IF @@ERROR <> 0 or @@ROWCOUNT = 0
	BEGIN
		SET @Err = 99
		GOTO ErrorHandler		
	END
	
	DELETE	[dbo].[TB_Emporia_ChallengeBattle]
	WHERE	[GuildID] = @GuildID AND [BattleID] = @BattleID
	
COMMIT TRAN
SELECT @Err, @RefundCost
RETURN @Err

ErrorHandler:
ROLLBACK TRAN
SELECT @Err
RETURN @Err
GO