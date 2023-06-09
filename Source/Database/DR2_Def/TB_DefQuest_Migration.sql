USE [DR2_Def]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Object:  Table [dbo].[TB_DefQuest_Migration]    Script Date: 11/05/2009 16:38:55 ******/
IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TB_DefQuest_Migration]') AND [type] in (N'U'))
BEGIN
	CREATE TABLE [dbo].[TB_DefQuest_Migration](
	[f_Revision] [int] NOT NULL,
	[f_QuestID] [int] NOT NULL,
	[f_MigrationRule] [nvarchar](20) NOT NULL, -- "ALLOW" previous value(default), "SET" forced set
	[f_TargetValue] [int] NOT NULL, -- only use "SET" command, 1 (complete)/0 (no complete)
	[Memo] [nvarchar](50) NULL,
	 CONSTRAINT [PK_TB_DefQuest_Migration] PRIMARY KEY CLUSTERED 
	(
		[f_Revision] ASC,
		[f_QuestID] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY]
END