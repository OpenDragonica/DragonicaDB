USE [DR2_Member]
GO

/****** Object:  StoredProcedure [dbo].[up_AddMemberCash_IAH]    Script Date: 03/31/2009 17:52:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_AddMemberCash_IAH]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_AddMemberCash_IAH]


/****** Object:  StoredProcedure [dbo].[up_CS_AddMemberCash]    Script Date: 03/31/2009 16:27:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
	2009-12-22 : Eric Kim, @ID nvarchar(20) -> nvarchar(50)
*/
CREATE PROCEDURE [dbo].[up_AddMemberCash_IAH]
@ID nvarchar(50),
@AddCash bigint,
@AddPoint bigint,
@CashCode nvarchar(255)

AS
SET NOCOUNT ON
BEGIN

DECLARE @ERROR INT

BEGIN TRAN

	DECLARE @OldCash BIGINT, @OldBonus BIGINT
	DECLARE @MemberGuid uniqueidentifier

	-- @ID 를 key로 update 하면 혹시 문제 생길지 몰라, MemberGuid 를 다시 얻어 오도록 한다.
	SELECT @MemberGuid=[MemberKey], @OldCash=[Cash], @OldBonus=[BonusCash] FROM dbo.Member WHERE [ID] = @ID
	IF @@ROWCOUNT <> 1
	BEGIN
		SET @ERROR = 1002
		GOTO __ERROR
	END

	IF (@CashCode IS NOT NULL) AND EXISTS(SELECT 1 FROM [dbo].[TBL_CashLog] WHERE [f_CashCode] = @CashCode)
	BEGIN
		SET @Error = 99
		GOTO __ERROR;
	END

	UPDATE [dbo].[Member] SET [Cash] = [Cash] + @AddCash,  [BonusCash] = [BonusCash] +  @AddPoint WHERE [MemberKey] = @MemberGuid
	IF @@ERROR <> 0
	BEGIN
		SET @ERROR = 1001
		GOTO __ERROR
	END


	-- LOG ---------------------------
	INSERT INTO [dbo].[TBL_CashLog]
		(MemberKey, CharacterID, f_Type, f_Status, f_amount,
		f_current,f_date,f_usedmileage,f_newmileage,f_curmileage, f_CashCode)
		VALUES(@MemberGuid, NULL, 4, 0, @AddCash,
			@OldCash+@AddCash, GETDATE(), 0,@AddPoint, @OldBonus+@AddPoint, @CashCode)
	IF @@ERROR <> 0
	BEGIN 
		SET @ERROR = 1001
		GOTO __ERROR
	END

COMMIT TRAN

RETURN 0

__ERROR:

ROLLBACK TRAN
RETURN @ERROR

END
