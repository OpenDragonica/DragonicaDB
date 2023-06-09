USE [DR2_Member]
GO
/****** Object:  StoredProcedure [dbo].[up_ChagneUserBirthday]    Script Date: 12/22/2009 23:32:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Object:  StoredProcedure [dbo].[up_ChagneUserBirthday]    Script Date: 12/22/2009 23:33:48 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_ChagneUserBirthday]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[up_ChagneUserBirthday]
GO

CREATE PROC [dbo].[up_ChagneUserBirthday]
/*
////////////////////////////////////////////////////////////////////////
//
// 프로시져명 : [dbo].[up_ChagneUserBirthday]
// 작 성 자 : 최연승
// 작 성 일 : 2008-09-05
// 최종수정자 : 최연승
// 수 정 일 : 2009-01-22
// 파 일 명 : 
// N O T E :  계정에 저장된 생일 변경
// * 리턴 값에 계정 추가
//
//	2009-12-22 : Eric Kim, @Account nvarchar(40) -> nvarchar(50)
////////////////////////////////////////////////////////////////////////
*/
(
	@Account		nvarchar(50),
	@Birthday		nvarchar(40)
)
AS
SET NOCOUNT ON
BEGIN
	DECLARE @Err			int
	SET @Err = 0
	
	if(NOT EXISTS(select 1 from Member where ID = @Account))
	begin
	  SET @Err = 1;
	  goto ErrorHandler;
	end

	Update Member
		Set [Birthday] = @Birthday
		where [ID] = @Account
	if @@error <> 0
	begin
		SET @Err = 2;
		goto ErrorHandler;
	end

ErrorHandler:
	select @Err, @Account
	return @Err
END



