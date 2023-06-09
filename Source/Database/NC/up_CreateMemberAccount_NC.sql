USE [DR2_Member]
GO
/****** Object:  StoredProcedure [dbo].[up_CreateMemberAccount_NC]    Script Date: 06/25/2009 18:09:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Object:  StoredProcedure [dbo].[up_CreateMemberAccount_NC]    Script Date: 06/25/2009 18:09:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_CreateMemberAccount_NC]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_CreateMemberAccount_NC]
GO

CREATE Proc [dbo].[up_CreateMemberAccount_NC]
/*
////////////////////////////////////////////////////////////////////////
//
// 프로시져명 : [dbo].[up_CreateMemberAccountNC]
// 작 성 자 : 
// 작 성 일 : 
// 최종수정자 : YonMy
// 수 정 일 : 2009-02-12
// 파 일 명 : 
// N O T E :
//		2009-02-12 : YonMy, 컬럼명 변경 Grade -> GMLevel
//		2009-06-25 : Eric Kim, BasePW 삭제, PW 값이 MD5로 encrypt
//		2009-06-29 : Eric Kim, PW 검사를 게임서버에서 하도록 변경
//		2009-12-22 : Eric Kim, @ID Length(20->50), @PW Length(20->64)
////////////////////////////////////////////////////////////////////////
*/ 
(
	@UID		int,			-- Member unique id (only for NC_Korea)
	@ID			nvarchar(50),	-- Member login id
	@PW			nvarchar(64),	-- Member login password
	@Gender		tinyint	-- Member Gender (0:unknown, 1:Male, 2:Female)
)
AS
SET NOCOUNT ON
DECLARE @MemberKey	uniqueidentifier
DECLARE @Err		int

SET @Err = 0

SELECT @MemberKey = MemberKey FROM dbo.Member WHERE [ID] = @ID

IF(@@rowcount <> 0)
BEGIN 
	SET @Err = 99
END
ELSE
BEGIN
	SET @MemberKey = NewID()
	INSERT INTO [dbo].[Member]
			   ([UID], [MemberKey], [ID], [PW], 
				[Gender], [CreateDate], [GMLevel] , [Block], [Cash], 
				[TotalConnectTime], [AccDisconnectTime], [AccConnectTime], [LastLoginDate], [LastLogoutDate])
		VALUES(
		@UID, @MemberKey, @ID, HashBytes('MD5', REVERSE(UPPER(@ID)) + @PW)
		, @Gender, getdate(), 0, 0, 0
		, 0, 0, 0, NULL, NULL)

	if @@ERROR <> 0
	BEGIN
		SET @Err = 1001
	ENd
END

SELECT @Err, @MemberKey, @ID
RETURN @Err
