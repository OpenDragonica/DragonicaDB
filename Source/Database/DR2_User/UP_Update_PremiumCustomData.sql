USE [DR2_User]
GO
/****** Object:  StoredProcedure [dbo].[UP_Update_PremiumCustomData]    Script Date: 08/08/2011 18:45:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UP_Update_PremiumCustomData]'))
BEGIN
	DROP PROCEDURE [dbo].[UP_Update_PremiumCustomData]
END
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UP_Update_PremiumCustomData]
	@CharGUID	uniqueidentifier,
	@CustomData [varbinary](max)
AS
BEGIN
	SET NOCOUNT ON;

DECLARE @Err int
SET @Err = 0

	UPDATE [dbo].[TB_UserCharacter_Extern]
	   SET [PremiumCustomData] = @CustomData
	 WHERE [CharacterID] = @CharGUID
	
RETURN @ERR
END
