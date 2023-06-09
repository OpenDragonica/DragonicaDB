USE [DR2_Def]
GO
/****** Object:  Table [dbo].[TB_DefSkillSet]    Script Date: 02/08/2010 23:27:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id=OBJECT_ID(N'[dbo].[TB_DefSkillSet]')) 
BEGIN

CREATE TABLE [dbo].[TB_DefSkillSet](
	[SetNo] [tinyint] NOT NULL,
	[Limit] [tinyint] NOT NULL,
	[ConditionType] [tinyint] NOT NULL,
	[ConditionValue] [tinyint] NOT NULL,
	[Memo] [nvarchar](100) NULL,
	[ResNo] [int] NOT NULL CONSTRAINT [DF_TB_DefSkillSet_ResNo]  DEFAULT ((0)),
 CONSTRAINT [PK_TB_SkillSetDef] PRIMARY KEY CLUSTERED 
(
	[SetNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

END
GO
