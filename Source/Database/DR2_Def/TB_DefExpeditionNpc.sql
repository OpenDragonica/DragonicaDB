USE [DR2_Def]
GO
/****** Object:  Table [dbo].[TB_DefExpeditionNpc]    Script Date: 05/23/2011 14:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TB_DefExpeditionNpc]'))
BEGIN
	CREATE TABLE dbo.Tmp_TB_DefExpeditionNpc
	(
		IDX int NOT NULL IDENTITY (1, 1),
		NpcGuid uniqueidentifier NOT NULL,
		Memo nvarchar(100) NULL,
		MapNo int NOT NULL,
		MinPlayerCnt int NOT NULL,
		MaxPlayerCnt int NOT NULL,
		NeedtemNo int NOT NULL,
		NeedItemCnt int NOT NULL,
		DungeonStringNo int NOT NULL,
		ImgPath nvarchar(100) NULL
	)  ON [PRIMARY]
END

IF NOT EXISTS(SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[TB_DefExpeditionNpc]') and [name] = N'DungeonInfoStringNo')
BEGIN
	ALTER TABLE [dbo].[TB_DefExpeditionNpc] ADD [DungeonInfoStringNo] [int] NOT NULL CONSTRAINT [DF_TB_DefExpeditionNpc_DungeonInfoStringNo] DEFAULT (0)
END

GO