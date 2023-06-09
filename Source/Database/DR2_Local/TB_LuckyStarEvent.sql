USE [DR2_Local]
GO
/****** Object:  Table [dbo].[TB_LuckyStarEvent]    Script Date: 09/15/2009 10:51:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TB_EventUserState]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TB_LuckyStarEvent](
	[Idx] [int] IDENTITY(1,1) NOT NULL,
	[EventId] [int] NOT NULL,
	[Memo] [nvarchar](50) NULL,
	[EventState] [tinyint] NOT NULL,
	[UserLimit] [int] NULL,
	[CostMoney] [int] NULL,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
	[EventNotiClose] [nvarchar](200) NULL,
	[MailTitle] [nvarchar](50) NULL,
	[MailText] [nvarchar](200) NULL,
	[LastRewardId] [int] NULL,
	[EventCount] [int] NULL,
	[DelayTime] [int] NULL,
	[LimitTime] [int] NULL,
	[LuckyPoint] [int] NULL,
 CONSTRAINT [PK_TB_LuckeyStarEvent] PRIMARY KEY CLUSTERED 
(
	[Idx] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

ALTER TABLE [dbo].[TB_LuckyStarEvent] DROP
COLUMN [EventState],
COLUMN [LastRewardId],
COLUMN [EventCount]
GO