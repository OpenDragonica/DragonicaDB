USE [DR2_User]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TB_UserJobSkill_Expertness]') AND [type] IN (N'U'))
BEGIN
	CREATE TABLE [dbo].[TB_UserJobSkill_Expertness](
		[f_CharGuid] [uniqueidentifier] NOT NULL,
		[f_SkillNo] [int] NOT NULL,
		[f_Expertness] [int] NOT NULL,
	 CONSTRAINT [PK_TB_UserJobSkill_Expertness] PRIMARY KEY CLUSTERED 
	(
		[f_CharGuid] ASC,
		[f_SkillNo] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY]
END