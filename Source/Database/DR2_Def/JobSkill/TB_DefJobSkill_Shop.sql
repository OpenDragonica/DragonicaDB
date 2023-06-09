USE [DR2_Def]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TB_DefJobSkill_Shop]') and [type] in (N'U'))
BEGIN
	CREATE TABLE [dbo].[TB_DefJobSkill_Shop](
		[f_IDX] [int] NOT NULL,
		[f_Job_Category] [int] NOT NULL,
		[f_Kind_Category] [int] NOT NULL,
		[f_Memo] [nvarchar](50) NULL,
		[f_ItemNo] [int] NOT NULL,
		[f_Price] [int] NOT NULL,
		[f_NPC_Guid] [uniqueidentifier] NOT NULL,
		[f_TimeType] [tinyint] NOT NULL,
		[f_UseTime] [int] NOT NULL,
	 CONSTRAINT [PK_TB_DefJobSkill_Shop] PRIMARY KEY CLUSTERED 
	(
		[f_NPC_Guid] ASC,
		[f_ItemNo] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY]
END
GO

IF NOT EXISTS(SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[TB_DefJobSkill_Shop]') AND [name] = N'f_ShowUser')
BEGIN
	ALTER TABLE dbo.[TB_DefJobSkill_Shop] ADD f_ShowUser int NOT NULL CONSTRAINT DF_TB_DefJobSkill_Shop_f_ShowUser DEFAULT 1
END
GO

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[TB_DefJobSkill_Shop]') AND [name] = N'NationCodeStr')
BEGIN
	CREATE TABLE [dbo].[Tmp_TB_DefJobSkill_Shop] (
		NationCodeStr nvarchar(50) NOT NULL,
		f_IDX int NOT NULL,
		f_Job_Category int NOT NULL,
		f_Kind_Category int NOT NULL,
		f_Memo nvarchar(50) NULL,
		f_ItemNo int NOT NULL,
		f_Price int NOT NULL,
		f_NPC_Guid uniqueidentifier NOT NULL,
		f_TimeType tinyint NOT NULL,
		f_UseTime int NOT NULL,
		f_ShowUser int NOT NULL
	 CONSTRAINT PK_TB_DefJobSkill_Shop2 PRIMARY KEY CLUSTERED 
	(
		f_NPC_Guid ASC,
		f_ItemNo ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY]
	
	IF EXISTS (SELECT * FROM dbo.TB_DefJobSkill_Shop)
		EXEC('INSERT INTO dbo.Tmp_TB_DefJobSkill_Shop (NationCodeStr, f_IDX, f_Job_Category, f_Kind_Category, f_Memo, f_ItemNo, f_Price, f_NPC_Guid, f_TimeType, f_UseTime, f_ShowUser)
			 SELECT 0, f_IDX, f_Job_Category, f_Kind_Category, f_Memo, f_ItemNo, f_Price, f_NPC_Guid, f_TimeType, f_UseTime, f_ShowUser
			 FROM dbo.TB_DefJobSkill_Shop WITH (HOLDLOCK TABLOCKX)')
	
	DROP TABLE dbo.TB_DefJobSkill_Shop
	
	EXECUTE sp_rename N'dbo.Tmp_TB_DefJobSkill_Shop', 'TB_DefJobSkill_Shop', 'OBJECT'
END
GO

ALTER TABLE dbo.TB_DefJobSkill_Shop
	DROP CONSTRAINT PK_TB_DefJobSkill_Shop2
GO

ALTER TABLE dbo.TB_DefJobSkill_Shop ADD CONSTRAINT
	PK_TB_DefJobSkill_Shop2 PRIMARY KEY CLUSTERED 
	(
	NationCodeStr,
	f_ItemNo,
	f_NPC_Guid
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO