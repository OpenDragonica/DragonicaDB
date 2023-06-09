USE [DR2_Member]
GO
/****** Object:  StoredProcedure [dbo].[up_SelectMemberAuthData_ExtVar]    Script Date: 06/29/2009 17:10:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Object:  StoredProcedure [dbo].[up_SelectMemberAuthData_ExtVar]    Script Date: 06/29/2009 17:42:55 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_SelectMemberAuthData_ExtVar]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_SelectMemberAuthData_ExtVar]
GO

CREATE Proc [dbo].[up_SelectMemberAuthData_ExtVar]
/*
////////////////////////////////////////////////////////////////////////
//
// 프로시져명 : [dbo].[up_SelectMemberAuthData_ExtVar]
// 작 성 자 : YonMy
// 작 성 일 : 2009-03-06
// 최종수정자 :
// 수 정 일 : 
// 담 당 자 : 
// N O T E : GF용 Auth
//		2009-06-25 : Eric Kim, BasePW 삭제, PW 값이 MD5로 encrypt
//		2009-06-29 : Eric Kim, PW 검사를 게임서버에서 하도록 변경
//		2009-12-22 : Eric Kim, @ID Length(20->50), @PW Length(20->64)
////////////////////////////////////////////////////////////////////////
*/
(
	@ID	nvarchar(50),
	@PW NVARCHAR(64)
)
AS
SET NOCOUNT ON
BEGIN
	DECLARE @Err int
	SET @Err = 0
	
	SELECT		A.[MemberKey]
			,	A.[ID]
			,	A.[PW]
			,	A.[Gender]
			,	A.[BirthDay]
			,	A.[TotalConnectTime]
			,	A.[AccDisconnectTime]
			,	A.[AccConnectTime]
			,	A.[LastLoginDate]
			,	A.[LastLogoutDate]
			,	getdate()
			,	A.[GMLevel]
			,	A.[Block]
			,	A.[BlockStartTime]
			,	A.[BlockEndTime]
			,	A.[ConnectionChannel]
			,	A.[EventRewardKey]
			,	B.[ExtVar]
	FROM	[dbo].[Member] A
		LEFT JOIN [dbo].[TB_MemberSub] B 
			ON A.MemberKey = B.MemberKey
	WHERE	A.ID = @ID
	
	EXEC [dbo].[up_Select_DefGMAccountIP] @ID
	return @Err
END
