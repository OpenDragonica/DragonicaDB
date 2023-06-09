USE [DR2_User]
GO

/****** Object:  StoredProcedure [dbo].[UP_Load_LuckyStarJoinedUser]    Script Date: 09/09/2009 11:30:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UP_Load_LuckyStarJoinedUser]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[UP_Load_LuckyStarJoinedUser]
GO

CREATE proc [dbo].[UP_Load_LuckyStarJoinedUser]
	@EventId INT
as
begin
	SELECT [EventId]
		  ,[MemberID]
		  ,[CharacterID]
		  ,[Star]
		  ,[Step]
	  FROM [dbo].[TB_LuckyStarJoinedUser]
	  Where EventId = @EventId and [State] = 1
end
