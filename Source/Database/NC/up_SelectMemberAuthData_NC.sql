USE [DR2_Member]
GO
/****** Object:  StoredProcedure [dbo].[UP_SelectMemberAuthData_NC]    Script Date: 06/25/2009 18:31:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Object:  StoredProcedure [dbo].[up_CreateMemberAccount_NC]    Script Date: 12/22/2009 23:52:12 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UP_SelectMemberAuthData_NC]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[UP_SelectMemberAuthData_NC]
GO

CREATE Proc [dbo].[UP_SelectMemberAuthData_NC]
/*
////////////////////////////////////////////////////////////////////////
//
// 프로시져명 : [dbo].[up_SelectMemberAuthData]
// 작 성 자 :
// 작 성 일 : 
// 최종수정자 : YonMy
// 수 정 일 : 2009-02-12
// 담 당 자 : 
// N O T E : 
//		2009-02-12 : YonMy, 컬럼명 변경 Grade -> GMLevel
//		2009-06-25 : Eric Kim, BasePW 삭제, PW 값이 MD5로 encrypt
//		2009-06-29 : Eric Kim, PW 검사를 게임서버에서 하도록 변경
//		2009-12-22 : Eric Kim, @ID Length(20->50), @PW Length(20->64)
////////////////////////////////////////////////////////////////////////
*/
(
	@UID	INT
,	@ID		NVARCHAR(50)
,	@PW NVARCHAR(64)
)
AS
SET NOCOUNT ON
BEGIN
	DECLARE @Err INT
	SET @Err = 0

	SELECT		[MemberKey]
			,	[ID]
			,	[PW]
			,	[Gender]
			,	[BirthDay]
			,	[TotalConnectTime]
			,	[AccDisconnectTime]
			,	[AccConnectTime]
			,	[LastLoginDate]
			,	[LastLogoutDate]
			,	getdate() AS NowTime
			,	[GMLevel]
			,	[Block]
			,	[BlockStartTime]
			,	[BlockEndTime]
	FROM		[dbo].[Member]
	WHERE		[ID] =@ID

	EXEC [dbo].[up_Select_DefGMAccountIP] @ID
	return @Err
END
