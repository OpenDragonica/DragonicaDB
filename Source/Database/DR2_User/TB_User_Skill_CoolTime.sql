USE [DR2_User]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TB_User_Skill_CoolTime]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[TB_User_Skill_CoolTime](
		[CharacterID] [uniqueidentifier] NOT NULL,
		[SkillNo] [int] NOT NULL,
		[CoolTime] [int] NOT NULL,
	) ON [PRIMARY]
	CREATE CLUSTERED INDEX IX_TB_User_Skill_CoolTime ON dbo.TB_User_Skill_CoolTime
		(
		CharacterID
		) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
END
GO
