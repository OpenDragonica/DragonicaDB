USE [DR2_Member]
GO
/****** Object:  StoredProcedure [dbo].[UP_PremiumService_Update]    Script Date: 08/08/2011 18:45:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UP_PremiumService_Update]'))
BEGIN
	DROP PROCEDURE [dbo].[UP_PremiumService_Update]
END
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UP_PremiumService_Update]
	@MemberGUID	uniqueidentifier,
	@PremiumServiceNo [int],
	@StartDate [datetime],
	@EndDate [datetime]
AS
BEGIN
	SET NOCOUNT ON;

DECLARE @Err int
SET @Err = 0

	IF NOT EXISTS( SELECT 1 FROM dbo.[TB_PremiumMember] WHERE [MemberKey] = @MemberGUID )
	BEGIN
		INSERT INTO [dbo].[TB_PremiumMember]
			   ([MemberKey]
			   ,[PremiumServiceNo]
			   ,[StartDate]
			   ,[EndDate])
		 VALUES
			   (@MemberGUID
			   ,@PremiumServiceNo
			   ,@StartDate
			   ,@EndDate)
	END
	ELSE
	BEGIN
		UPDATE [dbo].[TB_PremiumMember]
		   SET [PremiumServiceNo] = @PremiumServiceNo
			  ,[StartDate] = @StartDate
			  ,[EndDate] = @EndDate
		 WHERE [MemberKey] = @MemberGUID
	END
	
RETURN @ERR
END
