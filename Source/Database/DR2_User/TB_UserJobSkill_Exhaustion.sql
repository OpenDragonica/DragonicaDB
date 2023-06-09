USE [DR2_User]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TB_UserJobSkill_Exhaustion]') AND [type] IN (N'U'))
BEGIN
	CREATE TABLE [dbo].[TB_UserJobSkill_Exhaustion](
		[f_CharGuid] [uniqueidentifier] NOT NULL,
		[f_Exhaustion] [int] NOT NULL,
		[f_LastResetTime] [datetime] NOT NULL,
	 CONSTRAINT [PK_TB_UserJobSkill_Exhaustion] PRIMARY KEY CLUSTERED 
	(
		[f_CharGuid] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY]
END

IF NOT EXISTS(SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[TB_UserJobSkill_Exhaustion]') AND [name] = N'f_BlessPoint')
BEGIN
	ALTER TABLE dbo.TB_UserJobSkill_Exhaustion ADD f_BlessPoint int NOT NULL CONSTRAINT DF_TB_UserJobSkill_Exhaustion_f_BlessPoint DEFAULT 0
END

IF NOT EXISTS(SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[TB_UserJobSkill_Exhaustion]') AND [name] = N'f_LastResetBlessPointTime')
BEGIN
	EXECUTE sp_rename N'dbo.TB_UserJobSkill_Exhaustion.f_LastResetTime', N'Tmp_f_LastResetExhaustionTime', 'COLUMN' 
	
	EXECUTE sp_rename N'dbo.TB_UserJobSkill_Exhaustion.Tmp_f_LastResetExhaustionTime', N'f_LastResetExhaustionTime', 'COLUMN' 
	
	ALTER TABLE dbo.TB_UserJobSkill_Exhaustion ADD
		f_LastResetBlessPointTime datetime NOT NULL CONSTRAINT DF_TB_UserJobSkill_Exhaustion_f_LastResetBlessPointTime DEFAULT getdate()
END

IF NOT EXISTS(SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[TB_UserJobSkill_Exhaustion]') AND [name] = N'[f_ProductPoint]')
BEGIN
	ALTER TABLE dbo.TB_UserJobSkill_Exhaustion ADD
		f_ProductPoint int NOT NULL CONSTRAINT DF_TB_UserJobSkill_Exhaustion_f_ProductPoint DEFAULT (0)
END

IF NOT EXISTS(SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[TB_UserJobSkill_Exhaustion]') AND [name] = N'f_LastResetProductPointTime')
BEGIN
	ALTER TABLE dbo.TB_UserJobSkill_Exhaustion ADD
		f_LastResetProductPointTime datetime NOT NULL CONSTRAINT DF_TB_UserJobSkill_Exhaustion_f_LastResetProductPointTime DEFAULT getdate()
END