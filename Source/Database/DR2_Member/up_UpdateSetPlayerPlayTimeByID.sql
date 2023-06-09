USE [DR2_Member]
GO
/****** 개체:  StoredProcedure [dbo].[up_UpdateSetPlayerPlayTimeByID]    스크립트 날짜: 11/13/2009 16:46:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_UpdateSetPlayerPlayTimeByID]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_UpdateSetPlayerPlayTimeByID]
GO

/*
	2009-12-22 : Eric Kim, @ID Length(20->50)
*/
CREATE PROCEDURE [dbo].[up_UpdateSetPlayerPlayTimeByID]
(
	@ID			nvarchar(50),
	@AccConSec	int,
	@AccDicSec	int
)
AS	
BEGIN
	SET NOCOUNT ON;

	DECLARE @Err int
	SET @Err = 0

	UPDATE [dbo].[Member] 
		SET	[AccDisconnectTime] = @AccDicSec
			,[AccConnectTime] = @AccConSec
	WHERE [ID] = @ID

	IF @@error <> 0
	BEGIN
		SET @Err = 1
	END

	SELECT @Err
END


