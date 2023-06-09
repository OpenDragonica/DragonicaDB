USE [DR2_Member]
GO
/****** Object:  StoredProcedure [dbo].[up_CS_CashTran]    Script Date: 06/06/2009 22:20:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Object:  StoredProcedure [dbo].[up_CS_CashTran]    Script Date: 06/06/2009 22:33:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_CS_CashTran]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_CS_CashTran]
GO

/*	
	GALA 같이 외부 캐시 사용할 경우 CashTransaction log 남기기 위한 함수
///////////////////////////////////////////////////////////////////////////////////////
	2009-07-10 Eric Kim : 최초작성
///////////////////////////////////////////////////////////////////////////////////////
*/
CREATE PROCEDURE [dbo].[up_CS_CashTran]
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
SET @ERROR = 0

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
		END
	END


SELECT @ERROR, @Status, @Cash, @Bonus, @AddBonus
RETURN 0
END
