USE [DR2_User]
GO

/****** Object:  StoredProcedure [dbo].[up_Update_LuckyStarJoinedUser]    Script Date: 09/09/2009 11:31:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Update_LuckyStarJoinedUser]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_Update_LuckyStarJoinedUser]
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[up_Update_LuckyStarJoinedUser]
	@EventID INT,
	@MemberID	UNIQUEIDENTIFIER,
	@CharacterID	UNIQUEIDENTIFIER,
	@State TINYINT,
	@Star INT,
	@Step INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF (SELECT MemberID FROM [dbo].[TB_LuckyStarJoinedUser] WHERE MemberID = @MemberID) IS NULL
	BEGIN
		INSERT INTO [dbo].[TB_LuckyStarJoinedUser]
			   ([EventId]
			   ,[MemberID]
			   ,[CharacterID]
			   ,[State]
			   ,[Star]
			   ,[Step])
		 VALUES
			   (@EventId
			   ,@MemberID
			   ,@CharacterID
			   ,@State
			   ,@Star
			   ,@Step)
	END
	ELSE
	BEGIN
		UPDATE [dbo].[TB_LuckyStarJoinedUser]
		   SET [EventId] = @EventId
			  ,[CharacterID] = @CharacterID
			  ,[State] = @State
			  ,[Star] = @Star
			  ,[Step] = @Step
		 WHERE MemberID = @MemberID
	END

END
