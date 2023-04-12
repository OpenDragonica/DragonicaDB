USE [DR2_Member]
GO

/****** 개체:  Table [dbo].[TB_DefPlayerPlayTimeSub]    스크립트 날짜: 11/09/2009 16:14:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TB_DefPlayerPlayTimeSub]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TB_DefPlayerPlayTimeSub](
	[Type] [tinyint] NOT NULL,
	[TypeSub] [tinyint] NOT NULL,
	[Value1] [int] NULL,
	[Value2] [int] NULL,
	[Value3] [int] NULL,
	[Memo] [nvarchar](255) NULL
) ON [PRIMARY]
END
GO
