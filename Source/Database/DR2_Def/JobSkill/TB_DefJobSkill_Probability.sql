USE [DR2_Def]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TB_DefJobSkill_Probability]') AND [type] IN (N'U'))
BEGIN
	CREATE TABLE [dbo].[TB_DefJobSkill_Probability](
		[f_No] [int] NOT NULL,
		[f_Type] [int] NOT NULL,
		[f_Memo] NVARCHAR(50) NULL,
		[f_TotalProbability] [int] NOT NULL,
		[f_01ResultNo] [int] NOT NULL,
		[f_01Count] [int] NOT NULL,
		[f_01Probability] [int] NOT NULL,
		[f_02ResultNo] [int] NOT NULL,
		[f_02Count] [int] NOT NULL,
		[f_02Probability] [int] NOT NULL,
		[f_03ResultNo] [int] NOT NULL,
		[f_03Count] [int] NOT NULL,
		[f_03Probability] [int] NOT NULL,
		[f_04ResultNo] [int] NOT NULL,
		[f_04Count] [int] NOT NULL,
		[f_04Probability] [int] NOT NULL,
		[f_05ResultNo] [int] NOT NULL,
		[f_05Count] [int] NOT NULL,
		[f_05Probability] [int] NOT NULL,
		[f_06ResultNo] [int] NOT NULL,
		[f_06Count] [int] NOT NULL,
		[f_06Probability] [int] NOT NULL,
		[f_07ResultNo] [int] NOT NULL,
		[f_07Count] [int] NOT NULL,
		[f_07Probability] [int] NOT NULL,
		[f_08ResultNo] [int] NOT NULL,
		[f_08Count] [int] NOT NULL,
		[f_08Probability] [int] NOT NULL,
		[f_09ResultNo] [int] NOT NULL,
		[f_09Count] [int] NOT NULL,
		[f_09Probability] [int] NOT NULL,
		[f_10ResultNo] [int] NOT NULL,
		[f_10Count] [int] NOT NULL,
		[f_10Probability] [int] NOT NULL
	 CONSTRAINT [PK_TB_DefJobSkill_Probability] PRIMARY KEY CLUSTERED 
	(
		[f_No] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY]
END

IF NOT EXISTS(SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'dbo.TB_DefJobSkill_Probability') and [name] = N'f_01Need_SaveIdx')
BEGIN
	/* To prevent any potential data loss issues, you should review this script in detail before running it outside the context of the database designer.*/
	SET XACT_ABORT ON

	ALTER TABLE dbo.TB_DefJobSkill_Probability ADD
		f_01Need_SaveIdx int NOT NULL CONSTRAINT DF_TB_DefJobSkill_Probability_f_01Need_SaveIdx DEFAULT 0

	SET XACT_ABORT OFF
END

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[TB_DefJobSkill_Probability]') AND [name] = N'NationCodeStr')
BEGIN
	CREATE TABLE dbo.Tmp_TB_DefJobSkill_Probability 
	(
		NationCodeStr nvarchar(50) NOT NULL,
		f_No int NOT NULL,
		f_Type int NOT NULL,
		f_Memo nvarchar(50) NULL,
		f_TotalProbability [int] NOT NULL,
		f_01ResultNo [int] NOT NULL,
		f_01Count [int] NOT NULL,
		f_01Probability [int] NOT NULL,
		f_02ResultNo [int] NOT NULL,
		f_02Count [int] NOT NULL,
		f_02Probability [int] NOT NULL,
		f_03ResultNo [int] NOT NULL,
		f_03Count [int] NOT NULL,
		f_03Probability [int] NOT NULL,
		f_04ResultNo [int] NOT NULL,
		f_04Count [int] NOT NULL,
		f_04Probability [int] NOT NULL,
		f_05ResultNo [int] NOT NULL,
		f_05Count [int] NOT NULL,
		f_05Probability [int] NOT NULL,
		f_06ResultNo [int] NOT NULL,
		f_06Count [int] NOT NULL,
		f_06Probability [int] NOT NULL,
		f_07ResultNo [int] NOT NULL,
		f_07Count [int] NOT NULL,
		f_07Probability [int] NOT NULL,
		f_08ResultNo [int] NOT NULL,
		f_08Count [int] NOT NULL,
		f_08Probability [int] NOT NULL,
		f_09ResultNo [int] NOT NULL,
		f_09Count [int] NOT NULL,
		f_09Probability [int] NOT NULL,
		f_10ResultNo [int] NOT NULL,
		f_10Count [int] NOT NULL,
		f_10Probability [int] NOT NULL,
		f_01Need_SaveIdx [int] NOT NULL
	 CONSTRAINT PK_TB_DefJobSkill_Probability2 PRIMARY KEY CLUSTERED 
	(
		[f_No] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY]
	
	IF EXISTS (SELECT * FROM dbo.TB_DefJobSkill_Probability)
		EXEC('INSERT INTO dbo.Tmp_TB_DefJobSkill_Probability (NationCodeStr, f_No, f_Type, f_Memo, f_TotalProbability, f_01ResultNo, f_01Count, f_01Probability,
															 f_02ResultNo, f_02Count, f_02Probability, f_03ResultNo, f_03Count, f_03Probability, f_04ResultNo,
															 f_04Count, f_04Probability, f_05ResultNo, f_05Count, f_05Probability, f_06ResultNo, f_06Count, f_06Probability,
															 f_07ResultNo, f_07Count, f_07Probability, f_08ResultNo, f_08Count, f_08Probability, f_09ResultNo, f_09Count,
															 f_09Probability, f_10ResultNo, f_10Count, f_10Probability, f_01Need_SaveIdx)
			  SELECT 0, f_No, f_Type, f_Memo, f_TotalProbability, f_01ResultNo, f_01Count, f_01Probability,
															 f_02ResultNo, f_02Count, f_02Probability, f_03ResultNo, f_03Count, f_03Probability, f_04ResultNo,
															 f_04Count, f_04Probability, f_05ResultNo, f_05Count, f_05Probability, f_06ResultNo, f_06Count, f_06Probability,
															 f_07ResultNo, f_07Count, f_07Probability, f_08ResultNo, f_08Count, f_08Probability, f_09ResultNo, f_09Count,
															 f_09Probability, f_10ResultNo, f_10Count, f_10Probability, f_01Need_SaveIdx
			  FROM dbo.TB_DefJobSkill_Probability WITH (HOLDLOCK TABLOCKX)')
		
		DROP TABLE TB_DefJobSkill_Probability
		
		EXECUTE sp_rename N'dbo.Tmp_TB_DefJobSkill_Probability', 'TB_DefJobSkill_Probability', 'OBJECT'
END

ALTER TABLE dbo.TB_DefJobSkill_Probability
	DROP CONSTRAINT PK_TB_DefJobSkill_Probability2
GO

ALTER TABLE dbo.TB_DefJobSkill_Probability ADD CONSTRAINT
	PK_TB_DefJobSkill_Probability2 PRIMARY KEY CLUSTERED 
	(
	NationCodeStr,
	f_No
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO