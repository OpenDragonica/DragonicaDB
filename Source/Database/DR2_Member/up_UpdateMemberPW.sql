USE [DR2_Member]
GO
/****** Object:  StoredProcedure [dbo].[up_UpdateMemberPW]    Script Date: 12/23/2009 00:18:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_UpdateMemberPW]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[up_UpdateMemberPW]
GO

CREATE Proc [dbo].[up_UpdateMemberPW]
/*
=============================================
Last Update by :	Eric Kim
Update date: 2008-06-27
Description:	
PARAMETER :
RETURN : change password in binary format (encrypted format)
=============================================
//	2009-12-22 : @PW Length(147->60)
*/
(
	@MemberGUID	uniqueidentifier,
	@PW	binary(60)
)
AS
SET NOCOUNT ON

begin

DECLARE @Err int
SET @Err = 0

UPDATE [dbo].[Member] SET [PW] = @PW WHERE [MemberKey] = @MemberGUID

return @ERR
end

