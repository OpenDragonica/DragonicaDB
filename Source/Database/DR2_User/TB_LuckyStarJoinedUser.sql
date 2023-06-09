USE [DR2_User]
GO
/****** Object:  Table [dbo].[TB_LuckyStarJoinedUser]    Script Date: 09/09/2009 11:30:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_LuckyStarJoinedUser](
	[EventId] [int] NOT NULL,
	[MemberID] [uniqueidentifier] NOT NULL,
	[CharacterID] [uniqueidentifier] NOT NULL,
	[State] [tinyint] NOT NULL,
	[Star] [tinyint] NOT NULL,
	[Step] [int] NOT NULL,
 CONSTRAINT [PK_TB_LuckyStarUserInfo] PRIMARY KEY CLUSTERED 
(
	[MemberID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[TB_LuckyStarJoinedUser] ALTER COLUMN [Star] [int] NOT NULL
GO