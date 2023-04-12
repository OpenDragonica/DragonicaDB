USE [DR2_Def]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TB_DefClassPetAbil](
	[AbilNo] [int] NOT NULL,
	[Memo] [nvarchar](100) NULL,
	[Type01] [int] NOT NULL,
	[Value01] [int] NOT NULL,
	[Type02] [int] NOT NULL,
	[Value02] [int] NOT NULL,
	[Type03] [int] NOT NULL,
	[Value03] [int] NOT NULL,
	[Type04] [int] NOT NULL,
	[Value04] [int] NOT NULL,
	[Type05] [int] NOT NULL,
	[Value05] [int] NOT NULL,
	[Type06] [int] NOT NULL,
	[Value06] [int] NOT NULL,
	[Type07] [int] NOT NULL,
	[Value07] [int] NOT NULL,
	[Type08] [int] NOT NULL,
	[Value08] [int] NOT NULL,
	[Type09] [int] NOT NULL,
	[Value09] [int] NOT NULL,
	[Type10] [int] NOT NULL,
	[Value10] [int] NOT NULL,
 CONSTRAINT [PK_TB_DefClassPetAbil] PRIMARY KEY CLUSTERED 
(
	[AbilNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
