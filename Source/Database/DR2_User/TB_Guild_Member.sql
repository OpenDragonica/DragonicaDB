USE [DR2_User]
GO
/****** Object:  Table [dbo].[TB_Guild_Member]    Script Date: 10/26/2009 10:19:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TB_Guild_Member]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[TB_Guild_Member](
		[CharacterGuid] [uniqueidentifier] NOT NULL,
		[GuildGuid] [uniqueidentifier] NOT NULL,
		[MemberLevel] [tinyint] NULL,
	 CONSTRAINT [PK_TB_Guild_Member] PRIMARY KEY NONCLUSTERED 
	(
		[CharacterGuid] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY]

	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Guild member information' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Guild_Member'
	ALTER TABLE [dbo].[TB_Guild_Member]  WITH CHECK ADD  CONSTRAINT [FK_TB_Guild_Member_TB_Guild_Basic_Info] FOREIGN KEY([GuildGuid])
	REFERENCES [dbo].[TB_Guild_Basic_Info] ([GuildGuid])
	ALTER TABLE [dbo].[TB_Guild_Member] CHECK CONSTRAINT [FK_TB_Guild_Member_TB_Guild_Basic_Info]
END
GO

IF NOT EXISTS(SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[TB_Guild_Member]') AND [name] = N'f_LastLoginDate')
BEGIN
	ALTER TABLE [dbo].[TB_Guild_Member] ADD [f_LastLoginDate] DateTime NOT NULL CONSTRAINT DF_TB_Guild_Member_f_LastLoginDate DEFAULT (GetDate())
END