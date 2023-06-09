IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UP_LoadDefQuestResetSchedule]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[UP_LoadDefQuestResetSchedule]
GO

/****** Object:  StoredProcedure [dbo].[UP_LoadDefQuestResetSchedule]    Script Date: 07/09/2009 11:25:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UP_LoadDefQuestResetSchedule]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT [f_QuestID]
      ,[f_ResetBaseDate]
      ,[f_ResetLoopDay]
	FROM [dbo].[TB_DefQuest_ResetSchedule]
END

GO