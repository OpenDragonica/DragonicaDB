USE DR2_User
GO

set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Update_TB_Guild_Basic_Info_InvExtend_Tab]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[up_Update_TB_Guild_Basic_Info_InvExtend_Tab]
END
GO

CREATE PROCEDURE [dbo].[up_Update_TB_Guild_Basic_Info_InvExtend_Tab] 
/*
////////////////////////////////////////////////////////////////////////
//
// ���ν����� : up_Update_TB_Guild_Basic_Info_InvExtend_Tab
// �� �� �� : �赿ȯ
// �� �� �� : 2010-06-14
// ���������� :
// �� �� �� : 
// �� �� �� : 
// N O T E : ��� �κ��丮 Ȯ�� - �ݰ� �߰�( �� �ϳ� �߰� )
////////////////////////////////////////////////////////////////////////
*/
	@GuildGuid uniqueidentifier,	
	@Value BINARY(40)
AS
SET NOCOUNT ON
SET LOCK_TIMEOUT 5000
SET XACT_ABORT ON	
SET NOCOUNT ON
SET XACT_ABORT ON

UPDATE dbo.TB_Guild_Basic_Info Set [GuildInvExtend] = @Value Where [GuildGuid] = @GuildGuid