USE [DR2_Member]
GO

/****** Object:  StoredProcedure [dbo].[up_UpdateMemberPWByID_IAH]    Script Date: 03/26/2009 13:56:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_UpdateMemberPWByID_IAH]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_UpdateMemberPWByID_IAH]

/****** Object:  StoredProcedure [dbo].[up_UpdateMemberPWByID_IAH]    Script Date: 03/26/2009 13:56:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[up_UpdateMemberPWByID_IAH]
/*
=============================================
Last Update by :	Eric Kim
Update date: 2008-06-27
Description:	
PARAMETER :
RETURN : change password in text format
// IAH 연동 함수
//	2009-06-29 : Eric Kim, PW 검사를 게임서버에서 하도록 변경
//	2009-12-22 : Eric Kim, @ID Length(20->50), @PW Length(20->64)
=============================================
*/
(
	@ID	nvarchar(50),
	@PW	nvarchar(64)
)
AS
SET NOCOUNT ON

BEGIN

DECLARE @Err int
SET @Err = 0

UPDATE [dbo].[Member] Set [PW] = HashBytes('MD5', REVERSE(UPPER(@ID)) + @PW) WHERE [ID] = @ID
IF @@ROWCOUNT <> 1
BEGIN
		SET @ERR = 99
END

SELECT @ERR, @ID
RETURN @ERR

end


