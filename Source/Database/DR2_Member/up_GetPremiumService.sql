USE [DR2_Member]
GO
/****** Object:  StoredProcedure [dbo].[UP_PremiumService_Update]    Script Date: 08/08/2011 18:45:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_GetPremiumService]'))
BEGIN
	DROP PROCEDURE [dbo].[up_GetPremiumService]
END
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[up_GetPremiumService]
	@MemberGUID	uniqueidentifier
AS
BEGIN
	SET NOCOUNT ON;

DECLARE @Err int
SET @Err = 0

	SELECT [PremiumServiceNo], [StartDate], [EndDate]
	FROM [dbo].[TB_PremiumMember]
	WHERE [MemberKey] = @MemberGUID
	
RETURN @ERR
END
