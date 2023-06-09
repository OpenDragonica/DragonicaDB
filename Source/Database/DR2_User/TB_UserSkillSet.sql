USE [DR2_User]
GO
/****** Object:  Table [dbo].[TB_UserSkillSet]    Script Date: 02/08/2010 23:31:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id=OBJECT_ID(N'[dbo].[TB_UserSkillSet]')) 
BEGIN

CREATE TABLE [dbo].[TB_UserSkillSet](
	[CharacterID] [uniqueidentifier] NOT NULL,
	[SetNo] [tinyint] NOT NULL,
	[Delay01] [tinyint] NULL,
	[Type01] [tinyint] NULL,
	[SkillNo01] [int] NULL,
	[Delay02] [tinyint] NULL,
	[Type02] [tinyint] NULL,
	[SkillNo02] [int] NULL,
	[Delay03] [tinyint] NULL,
	[Type03] [tinyint] NULL,
	[SkillNo03] [int] NULL,
	[Delay04] [tinyint] NULL,
	[Type04] [tinyint] NULL,
	[SkillNo04] [int] NULL,
	[Delay05] [tinyint] NULL,
	[Type05] [tinyint] NULL,
	[SkillNo05] [int] NULL,
	[Delay06] [tinyint] NULL,
	[Type06] [tinyint] NULL,
	[SkillNo06] [int] NULL,
	[Delay07] [tinyint] NULL,
	[Type07] [tinyint] NULL,
	[SkillNo07] [int] NULL,
	[Delay08] [tinyint] NULL,
	[Type08] [tinyint] NULL,
	[SkillNo08] [int] NULL,
	[Delay09] [tinyint] NULL,
	[Type09] [tinyint] NULL,
	[SkillNo09] [int] NULL,
	[Delay10] [tinyint] NULL,
	[Type10] [tinyint] NULL,
	[SkillNo10] [int] NULL,
 CONSTRAINT [PK_TB_SkillSet] PRIMARY KEY CLUSTERED 
(
	[CharacterID] ASC,
	[SetNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

END
GO

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'dbo.TB_UserSkillSet') AND [name] = N'TabNo')
BEGIN
	ALTER TABLE dbo.TB_UserSkillSet ADD [TabNo] [tinyint] NOT NULL CONSTRAINT [DF_TB_UserSkillSet_TabNo] DEFAULT ((0))
END
GO


ALTER TABLE [dbo].[TB_UserSkillSet]
DROP CONSTRAINT [PK_TB_SkillSet]
GO

ALTER TABLE [dbo].[TB_UserSkillSet]
ADD CONSTRAINT [PK_TB_SkillSet] PRIMARY KEY CLUSTERED([CharacterID] ASC, [SetNo] ASC, [TabNo] ASC)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
GO