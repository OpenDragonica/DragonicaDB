USE [DR2_Def]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TB_DefBS_LvReward]') AND [type] = N'U')
BEGIN
	CREATE TABLE [dbo].[TB_DefBS_LvReward] (
		[f_IDX] [int] IDENTITY(1,1) NOT NULL,
		[f_BS_GAME_IDX] [int] NOT NULL,
		[f_LevelMin] [int] NOT NULL,
		[f_ItemNo1] [int] NOT NULL,
		[f_ItemCount1] [int] NOT NULL,
		[f_ItemNo2] [int] NOT NULL,
		[f_ItemCount2] [int] NOT NULL,
		[f_Memo] [nvarchar](50) NULL,
	 CONSTRAINT [IX_TB_DefBS_LvReward] UNIQUE CLUSTERED 
	(
		[f_BS_GAME_IDX] ASC,
		[f_LevelMin] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY]
END

GO

IF EXISTS(SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[TB_DefBS_LvReward]') and name = N'f_BS_GAME_IDX')
BEGIN
	exec sp_rename N'[dbo].[TB_DefBS_LvReward].f_BS_GAME_IDX', N'Tmp_f_BS_GAME_IDX', N'COLUMN'
	exec sp_rename N'[dbo].[TB_DefBS_LvReward].Tmp_f_BS_GAME_IDX', N'f_LvRewardIdx', N'COLUMN'
END