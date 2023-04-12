USE [DR2_User]
GO

IF EXISTS( SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[up_Guild_Inventory_Create]') AND  [type] in ('P') )
BEGIN
	DROP PROCEDURE [dbo].[up_Guild_Inventory_Create]
END

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
////////////////////////////////////////////////////////////////////////
// Lasst Update by : �赿ȯ
// Update date  : 2010-05-14
// Description : ���ݰ� ����
// [PARAMETER] : 
// [RETURN] : 
// [REMARK]
////////////////////////////////////////////////////////////////////////
*/
CREATE PROCEDURE [dbo].[up_Guild_Inventory_Create]
(	
	@GuildGuid UNIQUEIDENTIFIER	
)
AS
SET NOCOUNT ON;

DECLARE @Err int;
DECLARE @GuildInvExtend BINARY(40)  -- �⺻ 36ĭ���� ���ǵ� �κ��丮���� ����.
DECLARE @GuildInvExtendIdx BINARY(40) -- ���ϴ� ��.
DECLARE @GuildInvAurhority BINARY(4)

SET @Err = 0;
SET @GuildInvExtend = 0x010C022403240424050006000C000D000E0000000000000000000000000000000000000000000000
SET @GuildInvExtendIdx = 0x0100020003000400050006000C000D000E0000000000000000000000000000000000000000000000
SET @GuildInvAurhority = 0x01000200

BEGIN TRAN

--��� �ִ°�?
IF NOT EXISTS(SELECT 1 FROM [DBO].[TB_Guild_Basic_Info] WHERE [GuildGuid] = @GuildGuid)
BEGIN
	SET @Err = 1;
	GOTO __rollback_tran;
END

--����
UPDATE [DBO].[TB_Guild_Basic_Info]
	SET 	[GuildInvExtend] = @GuildInvExtend
			,[GuildInvExtendIdx] = @GuildInvExtendIdx
			,[GuildInvAuthority] = @GuildInvAurhority
	WHERE [GuildGuid] = @GuildGuid;
IF @@error <> 0
BEGIN
	SET @Err = 2;
	GOTO __rollback_tran;
END

SELECT @Err, @GuildInvExtend, @GuildInvExtendIdx, @GuildInvAurhority
COMMIT TRAN

__rollback_tran:
	SELECT @Err, @GuildInvExtend, @GuildInvExtendIdx, @GuildInvAurhority
	ROLLBACK TRAN
	RETURN