USE [DR2_Def]
GO
/****** Object:  Table [dbo].[TB_DefSuperGround]    Script Date: 02/06/2010 19:03:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--drop table [dbo].[TB_DefSuperGround]
IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TB_DefSuperGround]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[TB_DefSuperGround](
		[f_iSuperGroundNo] [int] NOT NULL,
		[f_iGroundNo] [int] NOT NULL,
		[f_iOrderNo] [int] NOT NULL,
		[f_Memo] [nvarchar](50) NULL,
		[f_Level1_MonsterEnchantGroupNo] [int] NOT NULL,
		[f_Level2_MonsterEnchantGroupNo] [int] NOT NULL,
		[f_Level3_MonsterEnchantGroupNo] [int] NOT NULL,
		[f_Level1_ItemRairityNo] [int] NOT NULL,
		[f_Level2_ItemRairityNo] [int] NOT NULL,
		[f_Level3_ItemRarityNo] [int] NOT NULL,
		[f_Level1_ItemEnchantControlNo] [int] NOT NULL,
		[f_Level2_ItemEnchantControlNo] [int] NOT NULL,
		[f_Level3_ItemEnchantControlNo] [int] NOT NULL,
		[f_Level1_BossItemContainerNo] [int] NOT NULL,
		[f_Level2_BossItemContainerNo] [int] NOT NULL,
		[f_Level3_BossItemContainerNo] [int] NOT NULL,
	) ON [PRIMARY]
	CREATE UNIQUE CLUSTERED INDEX IX_TB_DefSuperGround ON dbo.TB_DefSuperGround
		( f_iSuperGroundNo,f_iOrderNo,f_iGroundNo
		) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	CREATE UNIQUE NONCLUSTERED INDEX IX_TB_DefSuperGround_1 ON dbo.TB_DefSuperGround
		(
		f_iGroundNo
		) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
END
GO

IF EXISTS(SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'dbo.TB_DefSuperGround') and [name] = N'IX_TB_DefSuperGround')
BEGIN
	DROP INDEX IX_TB_DefSuperGround ON dbo.TB_DefSuperGround
END
GO

IF NOT EXISTS(SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'dbo.TB_DefSuperGround') and [name] = N'PK_TB_DefSuperGround')
BEGIN
	ALTER TABLE dbo.TB_DefSuperGround ADD CONSTRAINT
		PK_TB_DefSuperGround PRIMARY KEY CLUSTERED 
		(
		f_iSuperGroundNo,
		f_iOrderNo
		) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
END
GO