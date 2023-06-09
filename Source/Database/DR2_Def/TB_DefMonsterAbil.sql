USE [DR2_Def]
GO
/****** Object:  Table [dbo].[TB_DefMonsterAbil]    Script Date: 07/21/2010 16:51:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TB_DefMonsterAbil]') AND [type] in (N'U'))
BEGIN
	CREATE TABLE [dbo].[TB_DefMonsterAbil](
		[MonsterAbilNo] [int] NOT NULL,
		[Memo] [nvarchar](100) NULL,
		[Type01] [int] NOT NULL,
		[Value01] [int] NOT NULL,
		[Type02] [int] NOT NULL,
		[Value02] [int] NOT NULL,
		[Type03] [int] NOT NULL,
		[Value03] [int] NOT NULL,
		[Type04] [int] NOT NULL,
		[Value04] [int] NOT NULL,
		[Type05] [int] NOT NULL,
		[Value05] [int] NOT NULL,
		[Type06] [int] NOT NULL,
		[Value06] [int] NOT NULL,
		[Type07] [int] NOT NULL,
		[Value07] [int] NOT NULL,
		[Type08] [int] NOT NULL,
		[Value08] [int] NOT NULL,
		[Type09] [int] NOT NULL,
		[Value09] [int] NOT NULL,
		[Type10] [int] NOT NULL,
		[Value10] [int] NOT NULL,
	 CONSTRAINT [PK_TB_DefMonsterAbil3] PRIMARY KEY CLUSTERED 
	(
		[MonsterAbilNo] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY]

	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'monster definition' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_DefMonsterAbil'
END

IF NOT EXISTS(SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[TB_DefMonsterAbil]') AND [name] = N'f_NationCodeStr')
BEGIN
	/* To prevent any potential data loss issues, you should review this script in detail before running it outside the context of the database designer.*/
	BEGIN TRANSACTION
	SET QUOTED_IDENTIFIER ON
	SET ARITHABORT ON
	SET NUMERIC_ROUNDABORT OFF
	SET CONCAT_NULL_YIELDS_NULL ON
	SET ANSI_NULLS ON
	SET ANSI_PADDING ON
	SET ANSI_WARNINGS ON
	COMMIT
	BEGIN TRANSACTION
	
	CREATE TABLE dbo.Tmp_TB_DefMonsterAbil
		(
		f_NationCodeStr nvarchar(50) NOT NULL,
		MonsterAbilNo int NOT NULL,
		Memo nvarchar(100) NULL,
		Type01 int NOT NULL,
		Value01 int NOT NULL,
		Type02 int NOT NULL,
		Value02 int NOT NULL,
		Type03 int NOT NULL,
		Value03 int NOT NULL,
		Type04 int NOT NULL,
		Value04 int NOT NULL,
		Type05 int NOT NULL,
		Value05 int NOT NULL,
		Type06 int NOT NULL,
		Value06 int NOT NULL,
		Type07 int NOT NULL,
		Value07 int NOT NULL,
		Type08 int NOT NULL,
		Value08 int NOT NULL,
		Type09 int NOT NULL,
		Value09 int NOT NULL,
		Type10 int NOT NULL,
		Value10 int NOT NULL
		)  ON [PRIMARY]
	
	DECLARE @v sql_variant 
	SET @v = N'monster definition'
	EXECUTE sp_addextendedproperty N'MS_Description', @v, N'SCHEMA', N'dbo', N'TABLE', N'Tmp_TB_DefMonsterAbil', NULL, NULL
	
	ALTER TABLE dbo.Tmp_TB_DefMonsterAbil ADD CONSTRAINT
		DF_TB_DefMonsterAbil_f_NationCodeStr DEFAULT N'0' FOR f_NationCodeStr
	
	IF EXISTS(SELECT * FROM dbo.TB_DefMonsterAbil)
		 EXEC('INSERT INTO dbo.Tmp_TB_DefMonsterAbil (MonsterAbilNo, Memo, Type01, Value01, Type02, Value02, Type03, Value03, Type04, Value04, Type05, Value05, Type06, Value06, Type07, Value07, Type08, Value08, Type09, Value09, Type10, Value10)
			SELECT MonsterAbilNo, Memo, Type01, Value01, Type02, Value02, Type03, Value03, Type04, Value04, Type05, Value05, Type06, Value06, Type07, Value07, Type08, Value08, Type09, Value09, Type10, Value10 FROM dbo.TB_DefMonsterAbil WITH (HOLDLOCK TABLOCKX)')
	
	DROP TABLE dbo.TB_DefMonsterAbil
	
	EXECUTE sp_rename N'dbo.Tmp_TB_DefMonsterAbil', N'TB_DefMonsterAbil', 'OBJECT' 
	
	ALTER TABLE dbo.TB_DefMonsterAbil ADD CONSTRAINT
		PK_TB_DefMonsterAbil3 PRIMARY KEY CLUSTERED 
		(
		f_NationCodeStr,
		MonsterAbilNo
		) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	COMMIT
END