USE [DR2_Local]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Object:  Table [dbo].[TB_PvPLeague_Session]    Script Date: 07/05/2010 18:05:35 ******/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TB_PvPLeague_Session]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[TB_PvPLeague_Session](
	[Session] [int] NOT NULL,
	[Memo] [nvarchar](50) NULL,
	[GameMode] [int] NULL,
	[GameType] [int] NULL,
	[GameTime] [int] NULL,
	CONSTRAINT [PK_TB_PvPLeague_Session] PRIMARY KEY CLUSTERED 
	(
		[Session] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY]

END
GO