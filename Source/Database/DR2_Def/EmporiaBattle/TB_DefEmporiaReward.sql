USE [DR2_Def]
GO
/****** Object:  Table [dbo].[TB_DefEmporiaReward]    Script Date: 02/08/2010 23:26:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TB_DefEmporiaReward]') AND [type] = N'U')
BEGIN
CREATE TABLE [dbo].[TB_DefEmporiaReward](
	[EmporiaID] [uniqueidentifier] NOT NULL,
	[Memo] [nvarchar](200) NULL,
	[FromNo] [int] NOT NULL,
	[TitleNo] [int] NOT NULL,
	[BodyNo] [int] NOT NULL,
	[QuarterItem][int] NULL,	[QuarterAchieve][int] NULL,	[QuarterGradeTextNo][int] NULL,
	[SemiItem] 	 [int] NULL,	[SemiAchieve]   [int] NULL,	[SemiGradeTextNo] 	[int] NULL,
	[SecondItem] [int] NULL,	[SecondAchieve] [int] NULL,	[SecondGradeTextNo] [int] NULL,
	[WinnerItem] [int] NULL,	[WinnerAchieve] [int] NULL,	[WinnerGradeTextNo] [int] NULL,
	[Grade1_Item][int] NULL,	[Grade1_Achieve][int] NULL,	[Grade1_TextNo] 	[int] NULL,
	[Grade2_Item][int] NULL,	[Grade2_Achieve][int] NULL,	[Grade2_TextNo] 	[int] NULL,
	[Grade3_Item][int] NULL,	[Grade3_Achieve][int] NULL,	[Grade3_TextNo] 	[int] NULL,
	[Grade4_Item][int] NULL,	[Grade4_Achieve][int] NULL,	[Grade4_TextNo] 	[int] NULL,
	[Grade5_Item][int] NULL,	[Grade5_Achieve][int] NULL,	[Grade5_TextNo] 	[int] NULL,
	[LimitDay] [smallint] NOT NULL,
 CONSTRAINT [PK_TB_DefEmporiaReward] PRIMARY KEY CLUSTERED 
(
	[EmporiaID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TB_DefEmporiaReward_LimitDay]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TB_DefEmporiaReward] DROP CONSTRAINT [DF_TB_DefEmporiaReward_LimitDay]
END
GO

ALTER TABLE [dbo].[TB_DefEmporiaReward] ALTER COLUMN [LimitDay] [smallint] NOT NULL
GO

ALTER TABLE [dbo].[TB_DefEmporiaReward] ADD CONSTRAINT [DF_TB_DefEmporiaReward_LimitDay] DEFAULT ((7)) FOR [LimitDay]
GO


IF EXISTS(SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'dbo.TB_DefEmporiaReward') AND [name] = N'QuarterAchieve')
	ALTER TABLE [dbo].[TB_DefEmporiaReward] DROP column [QuarterAchieve]

IF EXISTS(SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'dbo.TB_DefEmporiaReward') AND [name] = N'SemiAchieve')
	ALTER TABLE [dbo].[TB_DefEmporiaReward] DROP column [SemiAchieve]

IF EXISTS(SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'dbo.TB_DefEmporiaReward') AND [name] = N'SecondAchieve')
	ALTER TABLE [dbo].[TB_DefEmporiaReward] DROP column [SecondAchieve]

IF EXISTS(SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'dbo.TB_DefEmporiaReward') AND [name] = N'WinnerAchieve')
	ALTER TABLE [dbo].[TB_DefEmporiaReward] DROP column [WinnerAchieve]

IF EXISTS(SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'dbo.TB_DefEmporiaReward') AND [name] = N'Grade1_Achieve')
	ALTER TABLE [dbo].[TB_DefEmporiaReward] DROP column [Grade1_Achieve]

IF EXISTS(SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'dbo.TB_DefEmporiaReward') AND [name] = N'Grade2_Achieve')
	ALTER TABLE [dbo].[TB_DefEmporiaReward] DROP column [Grade2_Achieve]

IF EXISTS(SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'dbo.TB_DefEmporiaReward') AND [name] = N'Grade3_Achieve')
	ALTER TABLE [dbo].[TB_DefEmporiaReward] DROP column [Grade3_Achieve]

IF EXISTS(SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'dbo.TB_DefEmporiaReward') AND [name] = N'Grade4_Achieve')
	ALTER TABLE [dbo].[TB_DefEmporiaReward] DROP column [Grade4_Achieve]

IF EXISTS(SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'dbo.TB_DefEmporiaReward') AND [name] = N'Grade5_Achieve')
	ALTER TABLE [dbo].[TB_DefEmporiaReward] DROP column [Grade5_Achieve]
GO


IF NOT EXISTS(SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'dbo.TB_DefEmporiaReward') AND [name] = N'QuarterMoney')
	ALTER TABLE [dbo].[TB_DefEmporiaReward] ADD [QuarterMoney] int NOT NULL DEFAULT 0

IF NOT EXISTS(SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'dbo.TB_DefEmporiaReward') AND [name] = N'SemiMoney')
	ALTER TABLE [dbo].[TB_DefEmporiaReward] ADD [SemiMoney] int NOT NULL DEFAULT 0

IF NOT EXISTS(SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'dbo.TB_DefEmporiaReward') AND [name] = N'SecondMoney')
	ALTER TABLE [dbo].[TB_DefEmporiaReward] ADD [SecondMoney] int NOT NULL DEFAULT 0

IF NOT EXISTS(SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'dbo.TB_DefEmporiaReward') AND [name] = N'WinnerMoney')
	ALTER TABLE [dbo].[TB_DefEmporiaReward] ADD [WinnerMoney] int NOT NULL DEFAULT 0

IF NOT EXISTS(SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'dbo.TB_DefEmporiaReward') AND [name] = N'Grade1_Money')
	ALTER TABLE [dbo].[TB_DefEmporiaReward] ADD [Grade1_Money] int NOT NULL DEFAULT 0

IF NOT EXISTS(SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'dbo.TB_DefEmporiaReward') AND [name] = N'Grade2_Money')
	ALTER TABLE [dbo].[TB_DefEmporiaReward] ADD [Grade2_Money] int NOT NULL DEFAULT 0

IF NOT EXISTS(SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'dbo.TB_DefEmporiaReward') AND [name] = N'Grade3_Money')
	ALTER TABLE [dbo].[TB_DefEmporiaReward] ADD [Grade3_Money] int NOT NULL DEFAULT 0

IF NOT EXISTS(SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'dbo.TB_DefEmporiaReward') AND [name] = N'Grade4_Money')
	ALTER TABLE [dbo].[TB_DefEmporiaReward] ADD [Grade4_Money] int NOT NULL DEFAULT 0

IF NOT EXISTS(SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'dbo.TB_DefEmporiaReward') AND [name] = N'Grade5_Money')
	ALTER TABLE [dbo].[TB_DefEmporiaReward] ADD [Grade5_Money] int NOT NULL DEFAULT 0
GO
