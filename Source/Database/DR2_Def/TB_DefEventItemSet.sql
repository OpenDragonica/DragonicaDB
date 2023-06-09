USE [DR2_Def]
GO
/****** Object:  Table [dbo].[TB_DefPartyEventItemSet]    Script Date: 01/20/2010 11:36:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TB_DefEventItemSet]') AND [type] IN ('U'))
BEGIN
	CREATE TABLE [dbo].[TB_DefEventItemSet](
		[f_EventItemSetID] [int] NOT NULL,
		[f_IsUse] [tinyint] NOT NULL,
		[f_IsAbsoluteCount] [tinyint] NOT NULL,
		[f_Memo] [nvarchar](50) NULL,
		[f_EquipItemNo] [int] NOT NULL,
		[f_EquipItemCount] [int] NOT NULL,
		[f_RewardEffectNo1] [int] NOT NULL,
		[f_RewardEffectNo2] [int] NOT NULL,
		[f_RewardEffectNo3] [int] NOT NULL
	) ON [PRIMARY]

	CREATE CLUSTERED INDEX IX_TB_DefEventItemSet ON dbo.TB_DefEventItemSet
		(
		f_EventItemSetID, f_EquipItemNo
		) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
END
GO