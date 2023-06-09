USE [DR2_Member]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tbl_CashLog_f_type]') AND parent_object_id = OBJECT_ID(N'[dbo].[tbl_CashLog]'))
ALTER TABLE [dbo].[tbl_CashLog] DROP CONSTRAINT [FK_tbl_CashLog_f_type]
GO

/****** Object:  Table [dbo].[tbl_CashType]    Script Date: 07/07/2009 18:05:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_CashType]') AND type in (N'U'))
DROP TABLE [dbo].[tbl_CashType]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_CashType](
	[f_Type] [tinyint] NOT NULL,
	[f_NameNo] [int] NULL,
	[f_From] [nvarchar](30) NULL,
	[f_IsUsed] [bit] NULL,
	[f_Memo] [nvarchar](200) NULL,
 CONSTRAINT [PK_tbl_CashType_f_type] PRIMARY KEY CLUSTERED 
(
	[f_Type] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Define CashLog Type' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tbl_CashType'

ALTER TABLE [dbo].[tbl_CashType] ALTER COLUMN [f_Type] [tinyint] NOT NULL
ALTER TABLE [dbo].[tbl_CashType] ALTER COLUMN [f_NameNo] [int] NULL
ALTER TABLE [dbo].[tbl_CashType] ALTER COLUMN [f_From] [nvarchar](30) NULL
ALTER TABLE [dbo].[tbl_CashType] ALTER COLUMN [f_IsUsed] [bit] NULL
ALTER TABLE [dbo].[tbl_CashType] ALTER COLUMN [f_Memo] [nvarchar](200) NULL

GO
