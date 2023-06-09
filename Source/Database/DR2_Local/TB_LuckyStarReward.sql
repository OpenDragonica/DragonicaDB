USE [DR2_Local]
GO
/****** Object:  Table [dbo].[TB_LuckyStarReward]    Script Date: 09/09/2009 11:27:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_LuckyStarReward](
	[Idx] [int] IDENTITY(1,1) NOT NULL,
	[RewardId] [int] NOT NULL,
	[Memo] [nvarchar](50) NULL,
	[Step] [int] NOT NULL,
	[Money] [int] NULL,
	[ItemNo] [int] NULL,
	[ItemCount] [smallint] NULL,
 CONSTRAINT [PK_TB_LuckeyStarReward] PRIMARY KEY CLUSTERED 
(
	[Idx] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
