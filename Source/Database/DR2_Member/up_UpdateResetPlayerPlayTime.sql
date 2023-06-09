USE [DR2_Member]
GO
/****** 개체:  StoredProcedure [dbo].[up_UpdateResetPlayerPlayTime]    스크립트 날짜: 11/09/2009 16:15:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_UpdateResetPlayerPlayTime]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_UpdateResetPlayerPlayTime]
GO

CREATE PROCEDURE [dbo].[up_UpdateResetPlayerPlayTime]
AS
	SET NOCOUNT ON
	DECLARE @Err int
	SET @Err = 0

	UPDATE [dbo].[Member] 
		SET	[AccDisconnectTime] = 0
			,[AccConnectTime] = 0

	IF @@error <> 0
	BEGIN
		SET @Err = 1
	END

	UPDATE [dbo].[TB_DefPlayerPlayTime]
		SET	[LastApplyTime] = GETDATE()

	SELECT @Err
RETURN
