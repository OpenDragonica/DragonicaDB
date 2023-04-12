USE [DR2_User]
GO

IF EXISTS( SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[up_Update_GuildInv_Authority]') AND  [type] in ('P') )
BEGIN
	DROP PROCEDURE [dbo].[up_Update_GuildInv_Authority]
END

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
////////////////////////////////////////////////////////////////////////
// Lasst Update by : �赿ȯ
// Update date  : 2010-05-14
// Description : ���ݰ� ���Ѽ���
// [PARAMETER] : 
// [RETURN] : 
// [REMARK]
////////////////////////////////////////////////////////////////////////
*/
CREATE PROCEDURE [dbo].[up_Update_GuildInv_Authority]
(	
	@GuildGuid uniqueidentifier,
	@Authority BINARY(4)
)
AS
SET NOCOUNT ON;

UPDATE[dbo].[TB_Guild_Basic_Info] SET [GuildInvAuthority] = @Authority WHERE [GuildGuid] = @GuildGuid
SELECT @GuildGuid, @Authority