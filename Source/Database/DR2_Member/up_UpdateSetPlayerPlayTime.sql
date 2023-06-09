USE [DR2_Member]
GO
/****** 개체:  StoredProcedure [dbo].[up_UpdateSetPlayerPlayTime]    스크립트 날짜: 11/12/2009 14:56:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_UpdateSetPlayerPlayTime]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_UpdateSetPlayerPlayTime]
GO

CREATE PROCEDURE [dbo].[up_UpdateSetPlayerPlayTime]
(
	@MemberGuid	uniqueidentifier,
	@AccConSec		int,
	@AccDicSec		int
)
AS	
BEGIN
	SET NOCOUNT ON;

	DECLARE @Err int
	SET @Err = 0

	UPDATE [dbo].[Member] 
		SET	[AccDisconnectTime] = @AccDicSec
			,[AccConnectTime] = @AccConSec
	WHERE [MemberKey] = @MemberGuid

	IF @@error <> 0
	BEGIN
		SET @Err = 1
	END

	SELECT @Err
END


