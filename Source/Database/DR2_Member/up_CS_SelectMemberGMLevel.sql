USE [DR2_Member]
GO

/****** Object:  StoredProcedure [dbo].[up_CS_SelectMemberGMLevel]    Script Date: 05/13/2009 14:29:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_CS_SelectMemberGMLevel]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_CS_SelectMemberGMLevel]

/****** Object:  StoredProcedure [dbo].[up_CS_SelectMemberCash]    Script Date: 05/13/2009 14:26:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[up_CS_SelectMemberGMLevel]
@MemberGuId uniqueidentifier

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT @MemberGuId, GMLevel FROM dbo.Member WHERE MemberKey = @MemberGuId

END
