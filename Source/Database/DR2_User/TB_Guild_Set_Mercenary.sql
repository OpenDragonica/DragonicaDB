USE [DR2_User]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TB_Guild_Set_Mercenary]') AND type in (N'U'))
BEGIN

	CREATE TABLE [dbo].[TB_Guild_Set_Mercenary](
		[GuildGuid] [uniqueidentifier] NOT NULL,
		[ClassLimit] [bigint] NOT NULL,
		[LevelLimit] [smallint] NOT NULL,
	 CONSTRAINT [PK_TB_Guild_Set_Mercenary] PRIMARY KEY NONCLUSTERED 
	(
		[GuildGuid] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY]

	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Guild Setting Emporia Battle Mercenary' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Guild_Set_Mercenary'
	ALTER TABLE [dbo].[TB_Guild_Set_Mercenary]  WITH CHECK ADD  CONSTRAINT [FK_TB_Guild_Set_Mercenary_TB_Guild_Basic_Info] FOREIGN KEY([GuildGuid])
	REFERENCES [dbo].[TB_Guild_Basic_Info] ([GuildGuid])
	ALTER TABLE [dbo].[TB_Guild_Set_Mercenary] CHECK CONSTRAINT [FK_TB_Guild_Set_Mercenary_TB_Guild_Basic_Info]
END
ELSE
BEGIN
	ALTER TABLE [dbo].[TB_Guild_Set_Mercenary] ALTER COLUMN [LevelLimit] [smallint] NOT NULL
ENd
GO
