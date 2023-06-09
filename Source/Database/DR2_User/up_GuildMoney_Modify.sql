USE [DR2_User]
GO
/****** Object:  StoredProcedure [dbo].[up_Money_Modify]    Script Date: 05/14/2010 17:53:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_GuildMoney_Modify]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_GuildMoney_Modify]
GO

CREATE PROCEDURE [dbo].[up_GuildMoney_Modify]
(
	@GuildGuid		uniqueidentifier,
	@Money			bigint
)
AS
BEGIN
	SET NOCOUNT ON
	UPDATE dbo.TB_Guild_Basic_Info SET [CurrentMoney] = @Money WHERE GuildGuid = @GuildGuid
	SELECT @@error
END
