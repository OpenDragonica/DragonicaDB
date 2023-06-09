USE [DR2_Member]
GO

/****** Object:  StoredProcedure [dbo].[up_AddMemberCash]    Script Date: 08/14/2009 18:36:49 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_AddMemberCash]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_AddMemberCash]
GO

/****** Object:  StoredProcedure [dbo].[up_AddMemberCash]    Script Date: 08/14/2009 18:22:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[up_AddMemberCash]
/*
////////////////////////////////////////////////////////////////////////
//
// 프로시져명 : [dbo].[up_AddMemberCash]
// 작 성 자 : 
// 작 성 일 :
// 최종수정자 : 최연승
// 수 정 일 :  2009-01-09
// 파 일 명 : 
// N O T E :  리턴 값에 이전 캐쉬 포인트, 추가된 포인트 추가
//	2009-01-16 : Eric Kim, Return 값에 Uid 값 추가
//	2009-02-18 : 김범준, Cash DataType 변경
//	2009-08-14 : Eric Kim, CashLog 남기도록 수정
//	2009-12-22 : Eric Kim, ID length 20 -> 50
////////////////////////////////////////////////////////////////////////
*/ 
(
	@ID	NVARCHAR(50),	-- Member ID
	@iCash BIGINT				-- Cash to add
)
AS
SET NOCOUNT ON
BEGIN
	DECLARE @Err INT
	DECLARE @OldCash INT
	DECLARE @Uid INT
	DECLARE @MemberGuid uniqueidentifier
	DECLARE @CharGuid uniqueidentifier
	SET @CharGuid = N'00000000-0000-0000-0000-000000000000'

	BEGIN TRAN
	SELECT @UID=[UID], @OldCash=[Cash], @MemberGuid = [MemberKey] FROM dbo.Member WHERE [ID] = @ID
	IF @@ROWCOUNT = 1 
	BEGIN
		UPDATE dbo.Member SET [Cash] = [Cash] + @iCash WHERE [ID] = @ID
		SET @Err = @@ERROR
		IF @Err = 0
		BEGIN
			-- f_Type = ECASH_TRAN_TYPE (3=GMServer)
			-- f_Status = ECASH_LOG_STATE (1=CashAdd)
			INSERT INTO [dbo].[tbl_CashLog] (MemberKey,CharacterID,f_Type,f_Status,f_amount,f_current,f_date,f_usedmileage,f_newmileage,f_curmileage)
			VALUES(@MemberGuid,@CharGuid,3,1,@iCash,@OLDCASH+@iCash,GETDATE(),0,0,0)
		END
	END
	ELSE
	BEGIN
		SET @Err = 1000
	END

	IF @Err = 0
	BEGIN
		COMMIT TRAN
	END
	ELSE
	BEGIN
		ROLLBACK TRAN
	END
	SELECT @Err, @ID, @OldCash, @iCash, @Uid
END

