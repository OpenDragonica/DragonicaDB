USE [DR2_User]
GO

/****** Object:  Table [dbo].[TB_admin_DefLogItemCount]    Script Date: 04/13/2010 18:10:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- drop table [dbo].[TB_admin_DefLogItemCount]
IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TB_admin_DefLogItemCount]') AND [type] in (N'U'))
BEGIN
	CREATE TABLE [dbo].[TB_admin_DefLogItemCount](
		[f_ItemNo] [int] NOT NULL,
		[f_Memo] [nvarchar](50) NULL,
	 CONSTRAINT [PK_TB_admin_DefLogItemCount] PRIMARY KEY CLUSTERED 
	(
		[f_ItemNo] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY]
END
GO

TRUNCATE TABLE [dbo].[TB_admin_DefLogItemCount]
GO

INSERT INTO [dbo].[TB_admin_DefLogItemCount] VALUES (79000010, N'무기 강화 가루')
INSERT INTO [dbo].[TB_admin_DefLogItemCount] VALUES (79000015, N'무기 강화 가루')
INSERT INTO [dbo].[TB_admin_DefLogItemCount] VALUES (79000020, N'방어구 강화 가루')
INSERT INTO [dbo].[TB_admin_DefLogItemCount] VALUES (79000025, N'방어구 강화 가루')
INSERT INTO [dbo].[TB_admin_DefLogItemCount] VALUES (79000030, N'소울')
GO

SELECT * FROM [dbo].[TB_admin_DefLogItemCount]
GO