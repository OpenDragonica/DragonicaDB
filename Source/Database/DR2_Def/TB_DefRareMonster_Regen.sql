USE [DR2_Def]
GO
/****** Object:  Table [dbo].[TB_DefRareMonster_Regen]    Script Date: 07/22/2010 12:18:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TB_DefRareMonster_Regen]') and [type] in (N'U'))
BEGIN
	CREATE TABLE [dbo].[TB_DefRareMonster_Regen](
		[Idx] [int] IDENTITY(1,1) NOT NULL,
		[Memo] [nvarchar](50) NULL,
		[GroundNo] [int] NOT NULL,
		[MonsterNo] [int] NOT NULL,
		[GenGroupNo] [int] NOT NULL,
		[DelayGenTime] [int] NOT NULL,
		[RegenTime] [int] NOT NULL
	) ON [PRIMARY]
	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'희귀 몬스터 배치 및 리젠 제어 테이블' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_DefRareMonster_Regen'
END



IF NOT EXISTS(SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'dbo.TB_DefRareMonster_Regen') AND [name] = N'PK_TB_DefRareMonster_Regen')
BEGIN
ALTER TABLE dbo.TB_DefRareMonster_Regen ADD CONSTRAINT
	PK_TB_DefRareMonster_Regen PRIMARY KEY CLUSTERED 
	(
	Idx
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
END
GO