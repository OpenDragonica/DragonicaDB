USE [DR2_Def]
GO
/****** Object:  Table [dbo].[TB_DefMonsterGradeProbabilty]    Script Date: 02/06/2010 20:28:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--drop table [dbo].[TB_DefMonsterGradeProbabilty]
IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.TB_DefMonsterGradeProbabilty') AND [type] in (N'U'))
BEGIN
	CREATE TABLE [dbo].[TB_DefMonsterGradeProbabilty](
		[f_Probablity_Group] [int] NOT NULL,
		[f_Probabilty] [int] NOT NULL,
		[f_MonsterEnchant_Grade] [int] NOT NULL,
		[f_Memo] [nvarchar](50) NULL,
	 CONSTRAINT [PK_TB_DefMonsterGradeProbabilty] PRIMARY KEY CLUSTERED 
	(
		[f_Probablity_Group] ASC,
		[f_Probabilty] ASC,
		[f_MonsterEnchant_Grade] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY]
END