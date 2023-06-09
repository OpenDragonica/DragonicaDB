USE [DR2_Def]
GO
/****** Object:  Table [dbo].[TB_DefGuildSkill]    Script Date: 07/22/2010 14:05:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TB_DefGuildSkill]') and [type] in (N'U'))
BEGIN
	CREATE TABLE [dbo].[TB_DefGuildSkill](
		[GuildLv] [smallint] NOT NULL,
		[SkillNo] [int] NOT NULL,
		[SkillPoint] [int] NOT NULL,
		[Gold] [bigint] NOT NULL,
		[GuildExp] [bigint] NOT NULL,
		[Item1] [int] NOT NULL,
		[Count1] [int] NOT NULL,
		[Item2] [int] NOT NULL,
		[Count2] [int] NOT NULL,
		[IntroText] [int] NOT NULL CONSTRAINT [DF_TB_DefGuildSkill_IntroText]  DEFAULT ((0)),
		[ResultText] [int] NOT NULL CONSTRAINT [DF_TB_DefGuildSkill_ResultText]  DEFAULT ((0))
	) ON [PRIMARY]
	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Guild skill definition' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_DefGuildSkill'
END
GO


IF EXISTS(SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'dbo.TB_DefGuildSkill') and [name] = N'IX_TB_DefGuildSkill')
BEGIN
	DROP INDEX IX_TB_DefGuildSkill ON dbo.TB_DefGuildSkill
END
GO

IF NOT EXISTS(SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'dbo.TB_DefGuildSkill') and [name] = N'PK_TB_DefGuildSkill')
BEGIN
	ALTER TABLE dbo.TB_DefGuildSkill ADD CONSTRAINT
	PK_TB_DefGuildSkill PRIMARY KEY CLUSTERED
	(
	GuildLv,
	SkillNo
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
END
GO