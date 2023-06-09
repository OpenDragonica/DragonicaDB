USE [DR2_Def]
GO
/****** Object:  Table [dbo].[TB_DefPvPGroundMode]    Script Date: 01/20/2010 18:02:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.TB_DefPvPGroundMode') AND type in (N'U'))
BEGIN

CREATE TABLE [dbo].[TB_DefPvPGroundMode](
	[GroundNo] [int] NOT NULL,
	[Memo] [nvarchar](200) COLLATE Korean_Wansung_CI_AS NULL,
	[NameNo] [int] NOT NULL,
	[UseType] [int] NOT NULL CONSTRAINT [DF_UseMode]  DEFAULT ('1'),
	[PreviewImg] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,
	[UserCount] [int] NOT NULL CONSTRAINT [DF_UserCount]  DEFAULT ('2'),
) ON [PRIMARY]

END
GO

IF NOT EXISTS(SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'dbo.TB_DefPvPGroundMode') AND [name] = N'UserCount')
BEGIN

ALTER TABLE [dbo].[TB_DefPvPGroundMode] ADD
[UserCount] [int] NOT NULL CONSTRAINT [DF_UserCount]  DEFAULT ('2')

END
GO