USE [DR2_Def]
GO
/****** Object:  Table [dbo].[TB_DefGuildLevel]    Script Date: 10/26/2009 11:31:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TB_DefGuildLevel]') AND [type] in (N'U'))
BEGIN
	CREATE TABLE [dbo].[TB_DefGuildLevel](
		[GuildLv] [smallint] NOT NULL,
		[MaxMemberCount] [int] NOT NULL,
		[SkillPoint] [int] NOT NULL,
		[Exp] [bigint] NOT NULL,
		[Gold] [bigint] NOT NULL,
		[Item1] [int] NOT NULL,
		[Count1] [int] NOT NULL,
		[Item2] [int] NOT NULL,
		[Count2] [int] NOT NULL,
		[Item3] [int] NOT NULL,
		[Count3] [int] NOT NULL,
		[Item4] [int] NOT NULL,
		[Count4] [int] NOT NULL,
		[Item5] [int] NOT NULL,
		[Count5] [int] NOT NULL,
		[IntroText] [int] NOT NULL,
		[ResultText] [int] NOT NULL
	) ON [PRIMARY]
	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Guild level definition' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_DefGuildLevel'
END
GO

IF NOT EXISTS(SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[TB_DefGuildLevel]') AND [name] = N'f_AutoChangeOwner1')
BEGIN
	ALTER TABLE [dbo].[TB_DefGuildLevel] ADD [f_AutoChangeOwner1] int NOT NULL CONSTRAINT [DF_TB_DefGuildLevel_f_AutoChangeOwner1] DEFAULT (0)
END
IF NOT EXISTS(SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[TB_DefGuildLevel]') AND [name] = N'f_AutoChangeOwner2')
BEGIN
	ALTER TABLE [dbo].[TB_DefGuildLevel] ADD [f_AutoChangeOwner2] int NOT NULL CONSTRAINT [DF_TB_DefGuildLevel_f_AutoChangeOwner2] DEFAULT (0)
END
IF NOT EXISTS(SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[TB_DefGuildLevel]') AND [name] = N'f_AutoChangeOwnerRun')
BEGIN
	ALTER TABLE [dbo].[TB_DefGuildLevel] ADD [f_AutoChangeOwnerRun] int NOT NULL CONSTRAINT [DF_TB_DefGuildLevel_f_AutoChangeOwnerRun] DEFAULT (0)
END





IF NOT EXISTS(SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'dbo.TB_DefGuildLevel') AND [name] = N'PK_TB_DefGuildLevel')
BEGIN
	ALTER TABLE dbo.TB_DefGuildLevel ADD CONSTRAINT
		PK_TB_DefGuildLevel PRIMARY KEY CLUSTERED 
		(
		GuildLv
		) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
END

GO

