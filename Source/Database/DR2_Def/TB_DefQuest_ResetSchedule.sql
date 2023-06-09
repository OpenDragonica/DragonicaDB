USE [DR2_Def]
GO

IF NOT EXISTS(SELECT 1 FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[TB_DefQuest_ResetSchedule]'))
BEGIN
	SET ANSI_NULLS ON
	SET QUOTED_IDENTIFIER ON
	CREATE TABLE [dbo].[TB_DefQuest_ResetSchedule](
		[f_QuestID] [int] NOT NULL,
		[f_ResetBaseDate] [datetime] NOT NULL,
		[f_ResetLoopDay] [int] NOT NULL
	) ON [PRIMARY]
END

GO