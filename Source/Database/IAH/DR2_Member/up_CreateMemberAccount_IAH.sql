USE [DR2_Member]
GO
/****** Object:  StoredProcedure [dbo].[up_CreateMemberAccount_IAH]    Script Date: 06/25/2009 18:07:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Object:  StoredProcedure [dbo].[up_CreateMemberAccount_IAH]    Script Date: 06/25/2009 18:07:54 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_CreateMemberAccount_IAH]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_CreateMemberAccount_IAH]
GO

-- 컬럼명 교체에 따른 프로시져 수정
CREATE PROC [dbo].[up_CreateMemberAccount_IAH]
/*
////////////////////////////////////////////////////////////////////////
//
// 프로시져명 : [dbo].[up_CreateMemberAccount_IAH]
// 작 성 자 : 
// 작 성 일 : 
// 최종수정자 : YonMy
// 수 정 일 : 2009-02-12
// 파 일 명 : 
// N O T E :  Create New Member (IAH 연동)
//		2009-06-25 : Eric Kim, BasePW 삭제, PW 값이 MD5로 encrypt
//		2009-06-29 : Eric Kim, PW 검사를 게임서버에서 하도록 변경
//		2009-12-22 : Eric Kim, @ID Length(20->50), @PW Length(20->64)
////////////////////////////////////////////////////////////////////////
*/  (
      @UID INT,			-- Member unique id (only for NC_Korea)
      @ID NVARCHAR(50),	-- Member login id
      @PW NVARCHAR(64),	-- Member login password
      @Gender TINYINT,		-- Member Gender (0:unknown, 1:Male, 2:Female)
      @Birthday NVARCHAR(40)
    )
AS

SET nocount ON
DECLARE @MemberKey UNIQUEIDENTIFIER
DECLARE @Err INT

SET @MemberKey = NEWID()
SET @Err = 0

IF EXISTS (SELECT 1 FROM dbo.Member WHERE [ID] = @ID) 
BEGIN 
	SET @MemberKey = '00000000-0000-0000-0000-000000000000'
	SET @Err = 99
END
ELSE 
BEGIN
	INSERT  INTO [dbo].[Member]
		(
			[UID]
		,	[MemberKey]
		,	[ID]
		,	[PW]
		,	[Gender]
		,	[CreateDate]
		,	[GMLevel]
		,	[Block]
		,	[Cash]
		,	[TotalConnectTime]
		,	[AccDisconnectTime]
		,	[AccConnectTime]
		,	[LastLoginDate]
		,	[LastLogoutDate]
		,	[BirthDay]
		)
        VALUES
        (
			@UID
		,	@MemberKey
		,	@ID
		,	HashBytes('MD5', REVERSE(UPPER(@ID)) + @PW)
		,	@Gender
		,	GETDATE()
		,	0
		,	0
		,	0
		,	0
		,	0
		,	0
		,	NULL
		,	NULL
		,	@Birthday
		)
	IF @@ERROR <> 0 
	BEGIN
		SET @Err = 1001
	END
END

SELECT  @Err, @MemberKey, @ID, @Gender, @Birthday, @UID
RETURN @Err
