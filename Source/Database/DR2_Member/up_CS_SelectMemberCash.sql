USE DR2_Member

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_CS_SelectMemberCash]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[up_CS_SelectMemberCash]
END

set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[up_CS_SelectMemberCash]

@MemberGuId uniqueidentifier

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT @MemberGuId,ISNULL(Cash,0),ISNULL(BONUSCASH,0) FROM dbo.Member WHERE MemberKey = @MemberGuId

END
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_CS_SelectMemberCash_ByID]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[up_CS_SelectMemberCash_ByID]
END
GO

CREATE PROCEDURE [dbo].[up_CS_SelectMemberCash_ByID]
/*
////////////////////////////////////////////////////////////////////////
//
// ���ν����� : [dbo].[up_SelectMemberID]
// �� �� �� : YonMy
// �� �� �� : 2009-03-09
// ���������� : YonMy
// �� �� �� : 
// �� �� �� : 
// N O T E : ID�� Cash������ ����
// 2009-03-26, YonMy, Bonus �߰�
////////////////////////////////////////////////////////////////////////
*/

@ID	nvarchar(20)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT @ID, ISNULL(Cash,0), ISNULL(BONUSCASH,0) FROM [dbo].[Member] WHERE ID = @ID

END
