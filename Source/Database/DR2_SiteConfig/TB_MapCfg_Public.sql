USE DR2_SiteConfig
GO
-- Action plan:
-- 0. Drop Constraint [PK_TB_MapCfg_Static], [DF_TB_MapCfg_Static_ServerNo]
-- 1. Create table [dbo].[TB_MapCfg_Public_tmp]
-- 2. INSERT [ServerNo], [GroundNo] INTO [TB_MapCfg_Public_tmp] FROM [TB_MapCfg_Public]
-- 3. Creating extended properties
-- 4. Update [TB_MapCfg_Public_tmp] Set Memo Column
-- 5. Drop Table [TB_MapCfg_Public]
-- 6. Create primary key [PK_TB_MapCfg_Public] on [dbo].[TB_MapCfg_Public_tmp]
-- 7. Rename Table [TB_MapCfg_Public_tmp] -> [TB_MapCfg_Public]
--
-- No warnings

SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO


IF EXISTS (SELECT * FROM tempdb..sysobjects WHERE id=OBJECT_ID('tempdb..#tmpErrors')) DROP TABLE #tmpErrors
GO
CREATE TABLE #tmpErrors (Error int)
GO
SET XACT_ABORT ON
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO
BEGIN TRANSACTION
GO

-- Drop Constraint [PK_TB_MapCfg_Static], [DF_TB_MapCfg_Static_ServerNo]
PRINT N'Drop Constraint [PK_MapCfg_Public], [DF_TB_MapCfg_Public_RealmNo], [DF_TB_MapCfg_Public_ServerNo]'
GO
ALTER TABLE [dbo].[TB_MapCfg_Public]
DROP CONSTRAINT PK_MapCfg_Public, DF_TB_MapCfg_Public_ServerNo
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

-- [TB_MapCfg_Public_tmp] ���̺� ����
PRINT N'CREATE TABLE [TB_MapCfg_Public_tmp]'
GO
CREATE TABLE [dbo].[TB_MapCfg_Public_tmp]
(
	[IDX] [smallint] IDENTITY(1,1) NOT NULL,
	[RealmNo] [smallint] NOT NULL CONSTRAINT [DF_TB_MapCfg_Public_RealmNo]  DEFAULT ((1)),
	[ServerNo] [smallint] NOT NULL CONSTRAINT [DF_TB_MapCfg_Public_ServerNo]  DEFAULT ((0)),
	[GroundNo] [int] NOT NULL,
	[Memo] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,
) ON [PRIMARY]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



-- [TB_MapCfg_Public_tmp] ���̺� ���� [TB_MapCfg_Public] ���̺� ������ ����
PRINT N'INSERT [ServerNo], [GroundNo] INTO [TB_MapCfg_Public_tmp] FROM [TB_MapCfg_Public]'
GO
INSERT INTO [dbo].[TB_MapCfg_Public_tmp]([ServerNo], [GroundNo])
SELECT DISTINCT [ServerNo], [GroundNo]
FROM [dbo].[TB_MapCfg_Public]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO




PRINT N'Creating extended properties'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Public Channel map configuration', 'SCHEMA', N'dbo', 'TABLE', N'TB_MapCfg_Public_tmp', NULL, NULL
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

EXEC sp_addextendedproperty N'MS_Description', N'Map number', 'SCHEMA', N'dbo', 'TABLE', N'TB_MapCfg_Public_tmp', 'COLUMN', N'GroundNo'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

EXEC sp_addextendedproperty N'MS_Description', N'Server number', 'SCHEMA', N'dbo', 'TABLE', N'TB_MapCfg_Public_tmp', 'COLUMN', N'ServerNo'
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



-- Memo ������Ʈ
PRINT N'Drop Table [TB_MapCfg_Public]'
GO
UPDATE A
SET A.[Memo] = B.Memo
FROM [DBO].[TB_MapCfg_Public_tmp] AS A
JOIN [DBO].[TB_MapCfg_Public] AS B ON A.GroundNo = B.GroundNo

IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO

UPDATE [dbo].[TB_MapCfg_Public_tmp]
   SET [RealmNo] = 1
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


-- [TB_MapCfg_Public] ���̺� ����
PRINT N'Drop Table [TB_MapCfg_Public]'
GO
DROP TABLE [dbo].[TB_MapCfg_Public]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


-- Primary Key ����
PRINT N'Creating primary key [PK_MapCfg_Public] on [TB_MapCfg_Public_tmp]'
GO
ALTER TABLE [dbo].[TB_MapCfg_Public_tmp]
	ADD CONSTRAINT [PK_MapCfg_Public]
	PRIMARY KEY CLUSTERED ([RealmNo], [GroundNo]) ON [PRIMARY]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO


-- [TB_MapCfg_Public_tmp]���̺� �̸� ����
PRINT N'Rename Table [TB_MapCfg_Public_tmp] -> [TB_MapCfg_Public]'
GO
EXECUTE sp_rename N'dbo.TB_MapCfg_Public_tmp', N'TB_MapCfg_Public', 'OBJECT' 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO



IF EXISTS (SELECT * FROM #tmpErrors) ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT>0 BEGIN
PRINT 'The database update succeeded'
COMMIT TRANSACTION
END
ELSE PRINT 'The database update failed'
GO
DROP TABLE #tmpErrors
GO
