USE [DR2_Member]
GO
/****** Object:  StoredProcedure [dbo].[up_ChangeMemberSub_ExtVar_ByID]    Script Date: 12/22/2009 23:36:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Object:  StoredProcedure [dbo].[up_ChangeMemberSub_ExtVar_ByID]    Script Date: 12/22/2009 23:36:55 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_ChangeMemberSub_ExtVar_ByID]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[up_ChangeMemberSub_ExtVar_ByID]
GO

CREATE PROCEDURE [dbo].[up_ChangeMemberSub_ExtVar_ByID]
/*
////////////////////////////////////////////////////////////////////////
//
// 프로시져명 : [dbo].[up_ChangeMemberSub_ExtVar_ByID]
// 작 성 자 : 
// 작 성 일 : 
// 최종수정자 : YonMy
// 수 정 일 : 2009-03-06
// 파 일 명 : 
// N O T E :  GF(대만 SoftWorld용 핸드폰락 사용유무수정)
//	2009-12-22 : Eric Kim, @ID nvarchar(20) -> nvarchar(50)
////////////////////////////////////////////////////////////////////////
*/  
(
      @ID		NVARCHAR(50),-- MemberID
      @ExtVar	SMALLINT
)
AS

SET nocount ON
DECLARE @Err INT

SET @Err = 0

BEGIN TRAN

	DECLARE @MemberKey UNIQUEIDENTIFIER
	SELECT @MemberKey = [MemberKey] FROM [dbo].[Member] WHERE [ID] = @ID
	
	IF @@ROWCOUNT = 0
	BEGIN 
		SET @Err = 99
		GOTO __ERROR
	END
	
	UPDATE	[dbo].[TB_MemberSub]
	SET		[ExtVar] = @ExtVar
	WHERE	[MemberKey] = @MemberKey
	
	IF @@ERROR <> 0
	BEGIN
		SET @Err = 99
		GOTO __ERROR
	END
	
COMMIT TRAN
SELECT @Err
RETURN @Err

__ERROR:

ROLLBACK TRAN
SELECT @Err
RETURN @Err
