USE [DR2_Def]
GO
/****** Object:  Table [dbo].[TB_DefMonsterEnchantGrade]    Script Date: 02/06/2010 20:19:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- drop table [dbo].[TB_DefMonsterEnchantGrade]
IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TB_DefMonsterEnchantGrade]') AND [type] in (N'U'))
BEGIN
	CREATE TABLE [dbo].[TB_DefMonsterEnchantGrade](
		[f_MonsterEnchant_GradeNo] [int] NOT NULL,
		[f_EnchantLevel] [int] NOT NULL,
		[f_Memo] [nvarchar](50) NULL,
		[f_Prefix_Name] [int] NULL,
		[f_StatusEffect_ID1] [nvarchar](50) NULL,
		[f_StatusEffect_Root1] [nvarchar](50) NULL,
		[f_StatusEffect_ID2] [nvarchar](50) NULL,
		[f_StatusEffect_Root2] [nvarchar](50) NULL,
		[f_StatusEffect_ID3] [nvarchar](50) NULL,
		[f_StatusEffect_Root3] [nvarchar](50) NULL,
		[f_AddAbil01] [int] NOT NULL,
		[f_AddAbil02] [int] NOT NULL,
		[f_AddAbil03] [int] NOT NULL,
		[f_AddAbil04] [int] NOT NULL,
		[f_AddAbil05] [int] NOT NULL,
		[f_AddAbil06] [int] NOT NULL,
		[f_AddAbil07] [int] NOT NULL,
		[f_SetAbil01] [int] NOT NULL,
		[f_SetAbil02] [int] NOT NULL,
		[f_SetAbil03] [int] NOT NULL,
	 CONSTRAINT [PK_TB_DefMonsterEnchantGrade] PRIMARY KEY CLUSTERED 
	(
		[f_MonsterEnchant_GradeNo] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY]
END