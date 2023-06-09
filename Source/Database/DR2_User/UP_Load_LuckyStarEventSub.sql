USE [DR2_User]
GO

/****** Object:  StoredProcedure [dbo].[UP_Load_LuckyStarEventSub]    Script Date: 09/18/2009 00:12:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UP_Load_LuckyStarEventSub]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[UP_Load_LuckyStarEventSub]

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROC [dbo].[UP_Load_LuckyStarEventSub]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT [EventId]
		  ,[EventState]
		  ,[SendResultType]
		  ,[LastRewardId]
		  ,[EventCount]
		  ,[LastResultStar]
		  ,[EventFlag]
	  FROM [dbo].[TB_LuckyStarEventSub]
  
END
