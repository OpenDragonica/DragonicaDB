USE [DR2_Member]
GO
/****** Object:  StoredProcedure [dbo].[up_CS_SelectMemberCash_ByID]    Script Date: 12/23/2009 00:06:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Object:  StoredProcedure [dbo].[up_CS_SelectMemberCash_ByID]    Script Date: 12/23/2009 00:06:32 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_CS_SelectMemberCash_ByID]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[up_CS_SelectMemberCash_ByID]
GO

CREATE PROCEDURE [dbo].[up_CS_SelectMemberCash_ByID]
/*
////////////////////////////////////////////////////////////////////////
//
// 프로시져명 : [dbo].[up_SelectMemberID]
// 작 성 자 : YonMy
// 작 성 일 : 2009-03-09
// 최종수정자 : YonMy
// 수 정 일 : 
// 담 당 자 : 
// N O T E : ID로 Cash가지고 오기
// 2009-03-26, YonMy, Bonus 추가
//	2009-12-22, Eric Kim, @ID Length(20->50)
////////////////////////////////////////////////////////////////////////
*/

@ID	nvarchar(50)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT @ID, ISNULL(Cash,0), ISNULL(BONUSCASH,0) FROM [dbo].[Member] WHERE ID = @ID

END
