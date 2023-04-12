USE [DR2_User]
IF NOT EXISTS(SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'TB_UserCash_Rank'))
BEGIN
	CREATE TABLE [dbo].[TB_UserCash_Rank](
		[CharGuId] [uniqueidentifier] NOT NULL,
		[IsVisable] [bit] NOT NULL,
		[UsedCash] [bigint] NOT NULL,
		[CharName] [nvarchar](50) NOT NULL,
		[ModifyDate] [datetime] NULL
	) ON [PRIMARY]

	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ĳ�� ��� ĳ���� GUID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_UserCash_Rank', @level2type=N'COLUMN',@level2name=N'CharGuId'
	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��ŷ ���� ���� ���� �÷��� 
	- 0 : �����
	- 1 : ����' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_UserCash_Rank', @level2type=N'COLUMN',@level2name=N'IsVisable'
	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�� ĳ���Ͱ� ���ӿ��� ����� ĳ�÷�' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_UserCash_Rank', @level2type=N'COLUMN',@level2name=N'UsedCash'
	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ĳ���� �̸�' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_UserCash_Rank', @level2type=N'COLUMN',@level2name=N'CharName'
	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��ŷ ���� ���� �÷��׸� ���� ������ �ð�
	- ������� �������� Ư�� �ð����� �ٽ� ������ ���� �� �� ������ �ϱ� ���� ����Ѵ�.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_UserCash_Rank', @level2type=N'COLUMN',@level2name=N'ModifyDate'
	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���� ĳ�� ��뷮�� ��� �Ͽ� ĳ�ü����� ������ �����ֱ� ���� ���̺�' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_UserCash_Rank'
END

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
GO
ALTER TABLE dbo.TB_UserCash_Rank
	DROP COLUMN CharName
GO
COMMIT
