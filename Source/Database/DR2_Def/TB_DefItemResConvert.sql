USE [DR2_Def]
GO

-- drop table [dbo].[TB_DefItemResConvert]
IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TB_DefItemResConvert]') AND [type] in (N'U'))
BEGIN
	CREATE TABLE [dbo].[TB_DefItemResConvert](
		   [Idx] [int] NULL,
		   [ItemNo] [int] NULL,
		   [Memo] [nvarchar](50) NULL,
		   [NationCode] [int] NULL,
		   [ConvertResNo] [int] NULL
	) ON [PRIMARY]
END
GO