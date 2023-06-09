USE [DR2_Def]
GO

/****** Object:  Table [dbo].[TB_DefNpcTalkMapMove]    Script Date: 03/25/2010 13:45:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- DROP TABLE [dbo].[TB_DefNpcTalkMapMove]
IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TB_DefNpcTalkMapMove]') and [type] in (N'U'))
BEGIN
	CREATE TABLE [dbo].[TB_DefNpcTalkMapMove](
		[f_GroundNo] [int] NOT NULL,
		[f_NpcGuid] [uniqueidentifier] NOT NULL,
		[f_Memo] [nvarchar](50) NULL,
		[f_TargetGroundNo] [int] NOT NULL,
		[f_TargetPortalNo] [smallint] NOT NULL
	) ON [PRIMARY]
	CREATE CLUSTERED INDEX IX_TB_DefNpcTalkMapMove ON dbo.TB_DefNpcTalkMapMove
		(
		f_GroundNo,
		f_NpcGuid
		) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
END