USE [DR2_Def]
GO

/*
	2010.04.01 Eric Kim
	TB_DefRes 테이블 분리
*/
IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TB_DefRes_Item]') AND [type] in (N'U'))
BEGIN

	CREATE TABLE [dbo].[TB_DefRes_Item](
		[ResNo] [int] NOT NULL,
		[Memo] [nvarchar](100) NULL,
		[IconPath] [nvarchar](100) NULL,
		[XmlPath] [nvarchar](100) NULL,
		[U] [int] NOT NULL CONSTRAINT [DF_TB_DefRes_Item_U]  DEFAULT ((1)),
		[V] [int] NOT NULL CONSTRAINT [DF_TB_DefRes_Item_V]  DEFAULT ((1)),
		[UVIndex] [int] NOT NULL CONSTRAINT [DF_TB_DefRes_ITem_UVIndex]  DEFAULT ((1))
	) ON [PRIMARY]

END

IF NOT EXISTS(SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'dbo.TB_DefRes_Item') AND [name] = (N'PK_TB_DefRes_Item') )
BEGIN
	ALTER TABLE dbo.TB_DefRes_Item ADD CONSTRAINT
		PK_TB_DefRes_Item PRIMARY KEY CLUSTERED 
		(
		ResNo
		) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
END

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[TB_DefRes_Item]') AND [Name] = 'AddResNo1')
BEGIN
	ALTER TABLE [dbo].[TB_DefRes_Item] ADD AddResNo1 INT CONSTRAINT DF_TB_DefRes_AddResNo1 NOT NULL DEFAULT((0))
	ALTER TABLE [dbo].[TB_DefRes_Item] ADD AddResNo2 INT CONSTRAINT DF_TB_DefRes_AddResNo2 NOT NULL DEFAULT((0))
	ALTER TABLE [dbo].[TB_DefRes_Item] ADD AddResNo3 INT CONSTRAINT DF_TB_DefRes_AddResNo3 NOT NULL DEFAULT((0))
END
