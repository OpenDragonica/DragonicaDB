USE [DR2_Member]
GO

/****** Object:  StoredProcedure [dbo].[up_Admin_ClearAllMember]    Script Date: 04/09/2009 15:56:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Admin_ClearAllMember]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_Admin_ClearAllMember]

/****** Object:  StoredProcedure [dbo].[up_Admin_ClearAllMember]    Script Date: 04/09/2009 15:48:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Proc [dbo].[up_Admin_ClearAllMember]
/*
////////////////////////////////////////////////////////////////////////
//
// 프로시져명 : [dbo].[up_Admin_ClearAllMember]
// 작 성 자 : Eric Kim
// 작 성 일 : 
// 최종수정자 : 
// 수 정 일 : 
// 파 일 명 : 
// N O T E :  Delete All Member information
// 2009-5-6, YonMy 수정
////////////////////////////////////////////////////////////////////////
*/ 
(
	@Confirm nvarchar(20),	-- 실수를 방지하기 위한 확인 메시지 입력
	@bRemoveCharacter tinyint
)
as
set nocount on
BEGIN
	
	IF @Confirm = 'ImSure'
	BEGIN
		-- DR2_Member Clear
		BEGIN TRAN
		
		DELETE FROM [dbo].[Member]
		IF @@ERROR <> 0
		BEGIN
			GOTO ErrorHandler
		END
		
		DELETE FROM [dbo].[TB_MemberSub]
		IF @@ERROR <> 0
		BEGIN
			GOTO ErrorHandler
		END
		
		DELETE FROM [dbo].[TB_DefGMAccountLinkIP]
		IF @@ERROR <> 0
		BEGIN
			GOTO ErrorHandler
		END

		DELETE FROM [dbo].[TB_Event_Coupon] WHERE f_OwnerMemberGuid IS NOT NULL
		IF @@ERROR <> 0
		BEGIN
			GOTO ErrorHandler
		END

		DELETE FROM [dbo].[tbl_CashLog]
		IF @@ERROR <> 0
		BEGIN
			GOTO ErrorHandler
		END
		
		COMMIT TRAN

	END
	ELSE IF @Confirm = 'ImSurePerfect'
	BEGIN
		-- DR2_Member Clear
		BEGIN TRAN
		
		TRUNCATE TABLE [dbo].[Member]
		IF @@ERROR <> 0
		BEGIN
			GOTO ErrorHandler
		END
		
		TRUNCATE TABLE [dbo].[TB_MemberSub]
		IF @@ERROR <> 0
		BEGIN
			GOTO ErrorHandler
		END
		
		TRUNCATE TABLE [dbo].[TB_DefGMAccountLinkIP]
		IF @@ERROR <> 0
		BEGIN
			GOTO ErrorHandler
		END

		TRUNCATE TABLE [dbo].[TB_Event_Coupon] WHERE f_OwnerMemberGuid IS NOT NULL
		IF @@ERROR <> 0
		BEGIN
			GOTO ErrorHandler
		END

		TRUNCATE TABLE [dbo].[tbl_CashLog]
		IF @@ERROR <> 0
		BEGIN
			GOTO ErrorHandler
		END
		
		COMMIT TRAN
	END
	ELSE
	BEGIN
		print('This procedure will delete ALL MEMBER and CHARACTER')
		print('If you are convinced that you know well what you will do and you are sure')
		print('EXEC UP_ClearAllMember ImSure or ImSurePerfect')
		RETURN 0
	END

	
	IF @bRemoveCharacter = 1
	BEGIN
		EXEC [DR2_User].[dbo].[up_Admin_ClearAllCharacter] @Confirm
	END
	RETURN 0

ErrorHandler:
	ROLLBACK TRAN
	RETURN 0
END

