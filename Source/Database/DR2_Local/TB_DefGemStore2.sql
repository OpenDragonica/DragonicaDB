USE [DR2_Local]
GO
/****** Object:  Table [dbo].[TB_DefGemStore]    Script Date: 04/17/2013 18:38:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TB_GemStore2]') AND type in (N'U'))
BEGIN
CREATE TABLE [TB_GemStore2](
	[NationCodeStr] [nvarchar](50) NOT NULL,
	[Memo] [nvarchar](50) NULL,
	[NpcGuid] [uniqueidentifier] NOT NULL,
	[Menu] [int] NOT NULL,
	[OrderIndex] [int] NOT NULL,
	[ItemNo] [int] NOT NULL,
	[ItemCount] [int] NOT NULL,
	[Gem1] [int] NULL,
	[GemCount1] [smallint] NULL,
	[Gem2] [int] NULL,
	[GemCount2] [smallint] NULL,
	[Gem3] [int] NULL,
	[GemCount3] [smallint] NULL,
	[Gem4] [int] NULL,
	[GemCount4] [smallint] NULL,
	[Gem5] [int] NULL,
	[GemCount5] [smallint] NULL,
	[CP] [int] NULL
 CONSTRAINT [PK_TB_GemStore2] PRIMARY KEY CLUSTERED
(
	[NationCodeStr] ASC,
	[NpcGuid] ASC,
	[Menu] ASC,
	[OrderIndex] ASC,
	[ItemNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
