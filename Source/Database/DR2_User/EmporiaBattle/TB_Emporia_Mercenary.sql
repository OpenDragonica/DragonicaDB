USE [DR2_User]
GO
/****** Object:  Table [dbo].[TB_Emporia_Mercenary]    Script Date: 02/10/2010 22:05:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TB_Emporia_Mercenary]') AND [type] = N'U')
BEGIN
CREATE TABLE [dbo].[TB_Emporia_Mercenary](
	[EmporiaID] [uniqueidentifier] NOT NULL,
	[BattleID] [uniqueidentifier] NOT NULL,
	[Index] [smallint] NOT NULL,
	[JoinGuidID] [uniqueidentifier] NOT NULL,
	[CharacterGuid] [uniqueidentifier] NOT NULL,
) ON [PRIMARY]

CREATE INDEX [IX_TB_Emporia_Mercenary] ON [dbo].[TB_Emporia_Mercenary]
(
	[EmporiaID] ASC,
	[BattleID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
END
GO