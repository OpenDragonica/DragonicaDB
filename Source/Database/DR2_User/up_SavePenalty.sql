USE [DR2_User]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_SavePenalty]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_SavePenalty]
GO

CREATE PROCEDURE [dbo].[up_SavePenalty]
/*
////////////////////////////////////////////////////////////////////////
//
// 프로시져명 : [up_SavePenalty]
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
	@Value			INT,
	@BeginDate		DATETIME,
	@EndDate		DATETIME	
)
AS
SET Nocount ON
SET Xact_Abort ON

DECLARE @Err int
SET @Err = 0

BEGIN
	INSERT INTO [dbo].[TB_Penalty]
	(
		[CharacterID]
	,	[Type]
	,	[Value]
	,	[BeginDate]
	,	[EndDate]
	)VALUES(
		@CharacterID
	,	@Type
	,	@Value
	,	@BeginDate
	,	@EndDate
	)
	
	IF @@ERROR <> 0
	BEGIN

		UPDATE [dbo].[TB_Penalty]
		SET		[Value] = @Value
			,	[BeginDate] = @BeginDate
			,	[EndDate] = @EndDate
		WHERE [CharacterID] = @CharacterID AND [Type] = @Type
		
		IF @@ERROR <> 0
		BEGIN
			SET @Err = 2
		END
		ELSE
		BEGIN
			SET @Err = 1
		END
	END
END

SELECT @Err
RETURN @Err
