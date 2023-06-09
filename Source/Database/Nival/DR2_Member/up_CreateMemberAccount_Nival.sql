USE [DR2_Member]
GO

/****** Object:  StoredProcedure [dbo].[up_CreateMemberAccount_Nival]    Script Date: 04/16/2009 22:47:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_CreateMemberAccount_Nival]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[up_CreateMemberAccount_Nival]

/****** Object:  StoredProcedure [dbo].[up_CreateMemberAccount]    Script Date: 04/16/2009 22:38:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- 컬럼명 교체에 따른 프로시져 수정
CREATE PROC [dbo].[up_CreateMemberAccount_Nival]
/*
////////////////////////////////////////////////////////////////////////
//
// 프로시져명 : [dbo].[up_CreateMemberAccount_GALA]
// N O T E :  Create New Member (Called by Game Server)
//		2009-09-14 : Eric Kim, up_CreateMemberAccount_GALA 것 그대로 복사하여 사용
//		2009-12-22 : Eric Kim, @ID Length(20->50), @PW Length(20->64)
////////////////////////////////////////////////////////////////////////
*/  (
      @UID INT,			-- Member unique id
      @ID NVARCHAR(50),	-- Member login id
      @PW NVARCHAR(64),	-- Member login password
      @Gender TINYINT,		-- Member Gender (0:unknown, 1:Male, 2:Female)
	  @GMLevel TINYINT	-- GMLevel
    )
AS

SET nocount ON
DECLARE @MemberKey UNIQUEIDENTIFIER
DECLARE @Err INT
DECLARE @Today datetime
SET @Today = GETDATE()


SET @MemberKey = NEWID()
SET @Err = 0

IF EXISTS (SELECT 1 FROM dbo.Member WHERE [ID] = @ID) 
BEGIN 
	--UPDATE [dbo].[Member] SET [UID]=@UID, [PW]=HashBytes('MD5', REVERSE(UPPER(@ID)) + @PW), [GMLevel]=@GMLevel
	--	WHERE [ID] = @ID
	UPDATE [dbo].[Member] SET [UID]=@UID, [PW]=HashBytes('MD5', REVERSE(UPPER(@ID)) + @PW)
		WHERE [ID] = @ID
	IF @@ERROR <> 0
	BEGIN
		SET @Err = 1001
	END
	ELSE
	BEGIN
		SET @Err = 1
	END

	IF @GMLevel > 0
	BEGIN
		UPDATE [dbo].[Member] SET [GMLevel]=@GMLevel WHERE [ID] = @ID
	END
END
ELSE 
BEGIN
	INSERT INTO [dbo].[Member]
		([UID],[MemberKey],[ID],[PW],
			[Gender],[CreateDate],[GMLevel],[Block],[Cash],
			[TotalConnectTime],[AccDisconnectTime],[AccConnectTime],[LastLoginDate],[LastLogoutDate],
			[BirthDay])
			VALUES(
			@UID,@MemberKey,@ID,HashBytes('MD5', REVERSE(UPPER(@ID)) + @PW),
			@Gender,@Today,0,0,0,
			0,0,0,NULL,NULL,
			@Today)
	IF @@ERROR <> 0 
	BEGIN
		SET @Err = 1001
	END
END

-- 최초 Login 이후에 GMLevel이 변동될 수 있으니므로, [TB_DefGMAccountLinkIP] 도 계속 update 해 주어야 한다.
IF @Err < 100	-- ERROR 없고
BEGIN
	IF EXISTS(SELECT 1 FROM [dbo].[TB_DefGMAccountLinkIP] WHERE [ID] = @ID)
	BEGIN
		IF @GMLevel = 0
		BEGIN
			DELETE FROM [dbo].[TB_DefGMAccountLinkIP] WHERE [ID] = @ID
		END
		ELSE
		BEGIN
			UPDATE [dbo].[TB_DefGMAccountLinkIP] SET [GMLevel] = @GMLevel WHERE [ID] = @ID
		END
	END
	ELSE
	BEGIN
		-- [dbo].[TB_DefGMAccountLinkIP]에서 못 찾았다.
		IF @GMLevel <> 0
		BEGIN
			INSERT INTO [dbo].[TB_DefGMAccountLinkIP]
				([ID],[IP],[SubNetMask],[GMLevel],[Memo])
				VALUES (@ID, N'0.0.0.0', N'0.0.0.0', @GMLevel, N'Create by [up_CreateMemberAccount_GALA]')
		END
	END
END

SELECT  @Err, @MemberKey, @ID, @Gender, @Today, @UID
RETURN @Err
