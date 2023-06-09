USE [DR2_User]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TB_RealmQuestStatus]') AND [type] in (N'U'))
BEGIN
	CREATE TABLE [dbo].[TB_RealmQuestStatus](
		[f_RealmQuestID] [nvarchar](100) NOT NULL,
		[f_RealmQuestCount] [bigint] NOT NULL,
	 CONSTRAINT [PK_TB_RealmQuestStatus] PRIMARY KEY CLUSTERED 
	(
		[f_RealmQuestID] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY]
END