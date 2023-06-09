/*
	2011-06-21 하승봉
	용족용 컬럼 추가
	2011-06-22 하승봉
	쿼리 수정
*/
USE [DR2_Def]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id=OBJECT_ID(N'[dbo].[TB_DefAlramMission]')) 
BEGIN
	DROP TABLE [dbo].[TB_DefAlramMission]
END

CREATE TABLE [dbo].[TB_DefAlramMission](
	[AlramID] [int] NOT NULL,
	[Type] [int] NOT NULL,
	[Memo] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,
	[TitleNo] [int] NOT NULL,
	[AlramID_Next] [int] NULL,
	[IsDraClass] [smallint] NOT NULL DEFAULT 0,
	[ClassLimit] [bigint] NULL,
	[Time] [int] NOT NULL,
	[Point] [smallint] NULL,
	[Exp] [int] NULL,
	[Effect] [int] NULL,
	[ItemBag01] [int] NULL,
	[ItemBag02] [int] NULL,
 CONSTRAINT [PK_TB_DefAlramMission] PRIMARY KEY CLUSTERED 
(
	[AlramID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


GO
