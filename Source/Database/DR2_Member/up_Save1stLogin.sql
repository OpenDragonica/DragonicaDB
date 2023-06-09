USE [DR2_Member]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Save1stLogin]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_Save1stLogin]
GO

CREATE PROCEDURE [dbo].[up_Save1stLogin]
/*
////////////////////////////////////////////////////////////////////////
//
// 프로시져명 : [dbo].[up_Save1stLogin]
// 작 성 자 : Eric
// 작 성 일 : 2009-01-14
// 최종수정자 : YonMy
// 수 정 일 : 2009-05-15
// 파 일 명 : 
// N O T E :  MemberSub table 저장하기
// 2009-03-09, YonMy, Return 추가
// 2009-05-15, YonMy, 에러 안나게 수정
////////////////////////////////////////////////////////////////////////
*/  
(
	@MemberID uniqueidentifier,
	@Address nvarchar(25),
	@LoginDate datetime
)
AS
SET NOCOUNT ON

DECLARE @Err INT
SET @Err = 0

BEGIN
	IF EXISTS (SELECT 1 FROM [dbo].[TB_MemberSub] WHERE [MemberKey] = @MemberID)
	BEGIN
		-- 이미 존재하는 것이므로 update
		UPDATE	[dbo].[TB_MemberSub] 
		SET		[1stLoginAddress] = @Address 
			,	[1stLoginDate] = @LoginDate
		WHERE	[MemberKey] = @MemberID
	
	END	
	ELSE
	BEGIN
	
		INSERT INTO	[dbo].[TB_MemberSub]
		(
			[MemberKey]
		,	[1stLoginAddress]
		,	[1stLoginDate]
		) 
		VALUES
		(
			@MemberID
		,	@Address
		,	@LoginDate
		)
		
	END
	
	IF @@ERROR <> 0
	BEGIN
		SET @Err = 99
	END
	
	RETURN @Err
END

