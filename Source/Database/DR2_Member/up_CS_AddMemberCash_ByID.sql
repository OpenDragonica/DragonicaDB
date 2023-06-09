IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_CS_AddMemberCash_ByID]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[up_CS_AddMemberCash_ByID]
END
GO

CREATE PROC  [dbo].[up_CS_AddMemberCash_ByID]
/*
////////////////////////////////////////////////////////////////////////
//
// 프로시져명 : [dbo].[up_CS_SelectMemberCash_ByID]
// 작 성 자 : YonMy
// 작 성 일 : 2009-03-09
// 최종수정자 : YonMy
// 수 정 일 : 
// 담 당 자 : 
// N O T E : ID로 Cash Add
// 2009-03-26, Bonus 추가에 따른 프로시져 수정
//	2009-07-07 Eric Kim : return 정보에 @Status 추가
//	2009-12-22 Eric Kim, @ID Length(20->50)
////////////////////////////////////////////////////////////////////////
*/
	@ID	NVARCHAR(50),
	@CharGuid UNIQUEIDENTIFIER,
	@Cash BIGINT,				-- Cash to add
	@Bonus BIGINT,				-- 마일리지 추가
	@AddBonus BIGINT,			-- 새로 추가되는 마일리지
	@Type TINYINT,
	@Status TINYINT
AS
SET NOCOUNT ON
BEGIN

DECLARE @ERROR INT
SET @ERROR = 0

BEGIN TRAN

	DECLARE @MemberGuId UNIQUEIDENTIFIER
	DECLARE @OLDCASH BIGINT, @OLDBONUS BIGINT
	
	SELECT @MemberGuId = [MemberKey], @OLDCASH = ISNULL([CASH],0), @OLDBONUS = ISNULL([BONUSCASH],0) FROM [dbo].[Member] WHERE [ID] = @ID

	IF (@OLDCASH + @Cash < 0) OR (@OLDBONUS + @BONUS < 0)
	BEGIN
		SET @ERROR = 1000		
		GOTO __ERROR
	END
	
	DECLARE @NEWBONUS BIGINT
	SET @NEWBONUS = @OLDBONUS + @Bonus + @AddBonus

	UPDATE [dbo].[Member]
	SET
		[Cash] = [Cash] + @Cash
	,	[BonusCash] = @NEWBONUS
	WHERE MemberKey = @MemberGuId
	IF @@ERROR <> 0
	BEGIN 
		SET @ERROR = 1001
		GOTO __ERROR
	END


	INSERT INTO [dbo].[tbl_CashLog] (MemberKey,CharacterID,f_Type,f_Status,f_amount,f_current,f_date,f_usedmileage,f_newmileage,f_curmileage)
	VALUES(@MemberGuId,@CharGuid,@Type,@Status,@Cash,@OLDCASH + @Cash,GETDATE(),@Bonus,@AddBonus,@NEWBONUS)
	IF @@ERROR <> 0
	BEGIN 
		SET @ERROR = 1001
		GOTO __ERROR
	END

COMMIT TRAN

SELECT @ERROR,@ID,@OLDCASH,isnull([CASH],0),@CASH,@OLDBONUS,ISNULL([BONUSCASH],0),@BONUS, @Status
	FROM [dbo].[Member] WHERE MemberKey = @MemberGuId
RETURN @ERROR

__ERROR:

ROLLBACK TRAN

SELECT @ERROR,@ID,@OLDCASH,isnull([CASH],0),@CASH,@OLDBONUS,ISNULL([BONUSCASH],0),@BONUS, @Status
	FROM [dbo].[Member] WHERE MemberKey = @MemberGuId
RETURN @ERROR

END