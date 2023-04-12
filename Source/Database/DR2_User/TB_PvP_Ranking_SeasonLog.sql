USE [DR2_User]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TB_PvP_Ranking_SeasonLog](
	[Season] [int]	NOT NULL,
	[Cycle] [int]	NOT NULL,
	[BeginDate] [datetime] NOT NULL,
	[Event] [tinyint] NULL
CONSTRAINT [IX_NC_TB_PvP_Ranking_SeasonLog] UNIQUE NONCLUSTERED 
(
	[Season]	ASC,
	[Cycle]		ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
