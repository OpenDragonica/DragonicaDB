USE [DR2_Member]
GO
/****** Object:  StoredProcedure [dbo].[up_SelectMemberID]    Script Date: 06/29/2009 21:00:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Object:  StoredProcedure [dbo].[up_SelectMemberID]    Script Date: 06/29/2009 21:01:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_SelectMemberID]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_SelectMemberID]
GO

CREATE Proc [dbo].[up_SelectMemberID]
/*
////////////////////////////////////////////////////////////////////////
//
// 프로시져명 : [dbo].[up_SelectMemberID]
// 작 성 자 : YonMy
// 작 성 일 : 2009-03-06
// 최종수정자 : YonMy
// 수 정 일 : 
// 담 당 자 : 
// N O T E : 계정사용 여부 확인
//	2009-12-22 : Eric Kim, @ID length(20->50)
////////////////////////////////////////////////////////////////////////
*/
(
	@ID	nvarchar(50)
)
AS
SET NOCOUNT ON
BEGIN
	DECLARE @Err int
	SET @Err = 0
	
	IF EXISTS (SELECT 1 FROM dbo.Member WHERE [ID] = @ID) 
	BEGIN
		SELECT	@Err
			,	[ID]
			,	[PW]
		FROM	[dbo].[Member]
		WHERE	[ID] = @ID
	END
	ELSE
	BEGIN
		SET @Err = 99
		SELECT @Err
	END

	RETURN @Err
END

