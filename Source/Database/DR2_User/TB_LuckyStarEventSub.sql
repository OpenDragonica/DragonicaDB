USE [DR2_User]
GO
/****** Object:  Table [dbo].[TB_LuckyStarEventSub]    Script Date: 09/18/2009 00:10:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_LuckyStarEventSub](
	[EventId] [int] NOT NULL,
	[EventState] [tinyint] NULL,
	[SendResultType] [tinyint] NULL,
	[LastRewardId] [int] NULL,
	[EventCount] [int] NULL,
	[LastResultStar] [int] NULL,
	[EventFlag] [int] NULL,
 CONSTRAINT [PK_TB_LuckyStarEventSub] PRIMARY KEY CLUSTERED 
(
	[EventId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
