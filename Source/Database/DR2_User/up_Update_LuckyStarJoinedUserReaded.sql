USE [DR2_User]
GO

/****** Object:  StoredProcedure [dbo].[up_Update_LuckyStarJoinedUserReaded]    Script Date: 09/09/2009 11:31:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Update_LuckyStarJoinedUserReaded]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_Update_LuckyStarJoinedUserReaded]
GO

CREATE proc [dbo].[up_Update_LuckyStarJoinedUserReaded]
	@EventId INT
as
begin
	UPDATE [dbo].[TB_LuckyStarJoinedUser] Set [State] = 0 Where EventId = @EventId
end
