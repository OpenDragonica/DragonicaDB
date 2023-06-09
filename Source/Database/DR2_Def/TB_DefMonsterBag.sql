USE [DR2_Def]
GO
/****** Object:  Table [dbo].[TB_DefMonsterBag]    Script Date: 01/19/2010 15:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TB_DefMonsterBag]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TB_DefMonsterBag](
	[IDX] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[BagNo] [int] NOT NULL,
	[Memo] [nvarchar](100) NULL,
	[ElementNo] [int] NOT NULL,
	[SuccessRateNo] [int] NOT NULL,
 CONSTRAINT [PK_TB_DefMonsterBag2] PRIMARY KEY CLUSTERED 
(
	[BagNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Monster bag definition' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_DefMonsterBag'
END
GO

IF EXISTS(SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[TB_DefMonsterBag]') AND [name] = N'TunningNo')
BEGIN
	EXECUTE sp_rename N'dbo.TB_DefMonsterBag.TunningNo', N'TunningNo_Min', 'COLUMN' 
END
GO

IF NOT EXISTS(SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[TB_DefMonsterBag]') AND [name] = N'TunningNo_Min')
BEGIN
	ALTER TABLE [dbo].[TB_DefMonsterBag] ADD [TunningNo_Min] int NOT NULL DEFAULT ((0))
END

IF NOT EXISTS(SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[TB_DefMonsterBag]') AND [name] = N'TunningNo_Max')
BEGIN
	ALTER TABLE [dbo].[TB_DefMonsterBag] ADD [TunningNo_Max] int NOT NULL DEFAULT ((0))	
END
