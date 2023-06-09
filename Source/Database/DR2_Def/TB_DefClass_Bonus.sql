USE [DR2_Def]
GO

/****** Object:  Table [dbo].[TB_DefClass_Bonus]    Script Date: 09/25/2009 15:20:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_DefClass_Bonus](
	[Class] [int] NOT NULL,
	[Level] [smallint] NOT NULL,
	[BonusStatus] [smallint] NOT NULL CONSTRAINT [DF_TB_DefClass_Bonus_BonusStatus]  DEFAULT ((0)),
	[Limit_STR_ADD] [smallint] NOT NULL CONSTRAINT [DF_TB_DefClass_Bonus_Limit_STR_ADD]  DEFAULT ((0)),
	[Limit_INT_ADD] [smallint] NOT NULL CONSTRAINT [DF_TB_DefClass_Bonus_Limit_INT_ADD]  DEFAULT ((0)),
	[Limit_CON_ADD] [smallint] NOT NULL CONSTRAINT [DF_TB_DefClass_Bonus_Limit_CON_ADD]  DEFAULT ((0)),
	[Limit_DEX_ADD] [smallint] NOT NULL CONSTRAINT [DF_TB_DefClass_Bonus_Limit_DEX_ADD]  DEFAULT ((0))
) ON [PRIMARY]
