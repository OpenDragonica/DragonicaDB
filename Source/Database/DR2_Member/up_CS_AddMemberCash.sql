USE [DR2_Member]
GO
/****** Object:  StoredProcedure [dbo].[up_CS_AddMemberCash]    Script Date: 06/06/2009 22:20:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Object:  StoredProcedure [dbo].[up_CS_AddMemberCash]    Script Date: 06/06/2009 22:33:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_CS_AddMemberCash]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_CS_AddMemberCash]
GO

/*	
///////////////////////////////////////////////////////////////////////////////////////
	2009-06-06 Eric Kim : ErrorCode 를 프로그램에서 쓰는 코드와 일치 (ECashShopResult)
	2009-07-06 Eric Kim : Return 정보로 AddBonus 추가
	2009-07-07 Eric Kim : parameter 에 TranGuid 추가, return 정보에 @Status 추가
///////////////////////////////////////////////////////////////////////////////////////
*/
CREATE PROCEDURE [dbo].[up_CS_AddMemberCash]
@MemberGuid uniqueidentifier,
@CharGuid UNIQUEIDENTIFIER,
@Cash BIGINT,				-- Cash to add
@Bonus BIGINT,				-- 마일리지 추가
@AddBonus BIGINT,			-- 새로 추가되는 마일리지
@Type TINYINT,
@Status TINYINT,
@TranGuid UNIQUEIDENTIFIER	-- TB_CashTran key value
AS
SET NOCOUNT ON
BEGIN

DECLARE @ERROR INT

BEGIN TRAN

	DECLARE @OLDCASH BIGINT, @OLDBONUS BIGINT
	SELECT @OLDCASH = ISNULL([CASH],0),@OLDBONUS = ISNULL([BONUSCASH],0) FROM DBO.MEMBER WHERE MEMBERKEY = @MEMBERGUID

	IF (@OLDCASH + @Cash < 0) OR (@OLDBONUS + @BONUS < 0)
	BEGIN
		SET @ERROR = 2	--CSR_NOT_ENOUGH_CASH		
		GOTO __ERROR
	END

	DECLARE @NEWBONUS BIGINT
	SET @NEWBONUS = @OLDBONUS + @Bonus + @AddBonus

	UPDATE dbo.Member 
	SET 
	[Cash] = [Cash] + @Cash ,
	[BonusCash] = @NEWBONUS
	WHERE MemberKey = @MemberGuId
	IF @@ERROR <> 0
	BEGIN 
		SET @ERROR = 17 --CSR_SYSTEM_ERROR
		GOTO __ERROR
	END


	INSERT INTO [dbo].[tbl_CashLog] (MemberKey,CharacterID,f_Type,f_Status,f_amount,f_current,f_date,f_usedmileage,f_newmileage,f_curmileage)
	VALUES(@MEMBERGUID,@CharGuid,@Type,@Status,@Cash,@OLDCASH + @Cash,GETDATE(),@Bonus,@AddBonus,@NEWBONUS)
	IF @@ERROR <> 0
	BEGIN 
		SET @ERROR = 17 --CSR_SYSTEM_ERROR
		GOTO __ERROR
	END

	-- TB_CashTran
	IF (@Status = 2)	-- rollback
	BEGIN
		--EXEC dbo.up_CS_CashTranCommit @TranGuid
		DELETE FROM [dbo].[TB_CashTran] WHERE [TranGuid] = @TranGuid
	END
	ELSE IF (@Status = 0)	-- Cash 차감 (Cash 누적에 대해서는 transaction 처리 하지 않는다.)
	BEGIN
		INSERT INTO [dbo].[TB_CashTran] ([TranGuid], [MemberGuid], [CharacterGuid], [CashUse], [MileageUse],
			[AddedMileage], [TranType], [CreateDate])
			VALUES (@TranGuid, @MemberGuid, @CharGuid, @Cash, @Bonus,
			@AddBonus, @Type, GETDATE())
		IF @@ERROR <> 0
		BEGIN 
			SET @ERROR = 17 --CSR_SYSTEM_ERROR
			GOTO __ERROR
		END
	END


COMMIT TRAN

SELECT @ERROR,@MEMBERGUID,@OLDCASH,isnull([CASH],0),@CASH,@OLDBONUS,ISNULL([BONUSCASH],0),@BONUS, @AddBonus, @Status
	FROM dbo.Member WHERE MemberKey = @MemberGuId

RETURN 0

__ERROR:

ROLLBACK TRAN

SELECT @ERROR,@MEMBERGUID,@OLDCASH,isnull([CASH],0),@CASH,@OLDBONUS,ISNULL([BONUSCASH],0),@BONUS, @AddBonus, @Status
	FROM dbo.Member WHERE MemberKey = @MemberGuId

RETURN @ERROR

END
