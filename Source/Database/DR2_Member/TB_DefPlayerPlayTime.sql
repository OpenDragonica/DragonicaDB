USE [DR2_Member]
GO

/****** 개체:  Table [dbo].[TB_DefPlayerPlayTime]    스크립트 날짜: 11/09/2009 16:13:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TB_DefPlayerPlayTime]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TB_DefPlayerPlayTime](
	[IsUse] [tinyint] NULL,
	[ResetType] [tinyint] NOT NULL,
	[ResetValue1] [int] NULL,
	[ResetValue2] [datetime] NULL,
	[ApplyUser] [smallint] NULL,
	[PlayTime] [int] NULL,
	[Flag] [int] NULL,	
	[LastApplyTime] [datetime] NULL,
	[Memo] [nvarchar](255) NULL
) ON [PRIMARY]
END
GO
