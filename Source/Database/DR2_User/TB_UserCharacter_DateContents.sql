USE [DR2_User]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[TB_UserCharacter_DateContents]    Script Date: 11/03/2009 16:57:54 ******/
IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TB_UserCharacter_DateContents]') AND [type] in (N'U'))
BEGIN
	CREATE TABLE [dbo].[TB_UserCharacter_DateContents](
		[f_CharacterID] [uniqueidentifier] NOT NULL,
		[f_GuildLeaveDate] [datetime] NOT NULL CONSTRAINT [DF_TB_UserCharacter_Date_f_GuildLeaveDate]  DEFAULT (getdate()),
	 CONSTRAINT [PK_TB_UserCharacter_DateContents] PRIMARY KEY CLUSTERED 
	(
		[f_CharacterID] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY]
END
GO
