USE [DR2_User]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_CheckPenalty]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_CheckPenalty]
GO

CREATE PROCEDURE [dbo].[up_CheckPenalty]
/*
////////////////////////////////////////////////////////////////////////
//
// 프로시져명 : [up_CheckPenalty]
// 작 성 자 : YonMy
// 작 성 일 : 2009-05-31
// 최종수정자 : 
// 수 정 일 : 
// 담 당 자 : YonMy
// N O T E : 
//
////////////////////////////////////////////////////////////////////////
*/
(
	@CharacterID	UNIQUEIDENTIFIER,
	@Type			INT,
	@NowDate		DATETIME	
)
AS
SET Nocount ON
SET Xact_Abort ON

DECLARE @Ret int
SET @Ret = 0

DECLARE @EndDate DATETIME
SELECT @EndDate = [EndDate]
FROM [dbo].[TB_Penalty]
WHERE [CharacterID] = @CharacterID AND [Type] = @Type
	
IF @@ROWCOUNT > 0
BEGIN

	IF @EndDate <= @NowDate
	BEGIN
		-- Clear 한다.
		EXEC [dbo].[up_DeletePenalty] @CharacterID, @Type
	END
	ELSE
	BEGIN
		SET @Ret = 1
	END
	
END

SELECT @EndDate
RETURN @Ret
