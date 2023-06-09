USE [DR2_Def]
GO

/*
	2010-04-07, Eric Kim
	최초 생성
	2011-06-20 하승봉
	용족용 컬럼 추가
*/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[TB_DefClassLimit]') AND type = N'U')
BEGIN
	DROP TABLE [dbo].[TB_DefClassLimit]
END

CREATE TABLE [dbo].[TB_DefClassLimit](
	[IDX] [int] IDENTITY(1,1) NOT NULL,
	[ClassLimit] [bigint] NOT NULL,
	[Depth] [tinyint] NOT NULL,
	[ClassNo] [smallint] NOT NULL,
	[DraClass] [tinyint] NOT NULL DEFAULT 0,
	[IsMainClass] [tinyint] NOT NULL CONSTRAINT [DF_TB_DefClassLimit_IsMainClass]  DEFAULT ((0)),
	[Memo] [nvarchar](200) NULL,
 CONSTRAINT [PK_TB_DefClassLimit] PRIMARY KEY CLUSTERED 
(
	[IDX] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
