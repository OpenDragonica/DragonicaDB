USE [DR2_Member]
GO
/****** Object:  StoredProcedure [dbo].[up_SelectMemberCash]    Script Date: 12/23/2009 00:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Object:  StoredProcedure [dbo].[up_SelectMemberCash]    Script Date: 12/23/2009 00:12:33 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_SelectMemberCash]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_SelectMemberCash]
GO

CREATE Proc [dbo].[up_SelectMemberCash]
/*
=============================================
Last Update by :	Eric Kim
Update date: 2008-08-19
Description: Get Cash of member
PARAMETER :
	@ID : member login id
RETURN :
	Erro code
//	2009-12-22 : Eric Kim, @ID Length(20->50)
=============================================
*/
(
	@ID	nvarchar(50)
)
AS
SET NOCOUNT ON
BEGIN
	DECLARE @Err int
	SET @Err = 0

	SELECT @ID, [Cash] FROM dbo.Member WHERE [ID] = @ID

	return @ERR
END

