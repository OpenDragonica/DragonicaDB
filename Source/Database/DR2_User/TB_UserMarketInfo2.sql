USE [DR2_User]
IF NOT EXISTS(SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'TB_UserMarketInfo2'))
BEGIN
	/****** Object:  Table [dbo].[TB_UserMarketInfo2]    Script Date: 03/31/2009 18:53:37 ******/
	SET ANSI_NULLS ON
	SET QUOTED_IDENTIFIER ON
	CREATE TABLE [dbo].[TB_UserMarketInfo2](
		[CharGuid] [uniqueidentifier] NOT NULL,
		[MarketName] [nvarchar](50) NULL,
		[CharName] [nvarchar](50) NOT NULL,
		[Grade] [tinyint] NOT NULL,
		[State] [tinyint] NOT NULL,
		[GenTime] [datetime] NOT NULL,
		[OfflineCloseTime] [bigint] NOT NULL,
		[OnlineCloseTime] [bigint] NOT NULL,
		[MarketCloseTime] [datetime] NOT NULL,
		[MarketHP] [int] NOT NULL,
	 CONSTRAINT [PK_Table_CharName2] PRIMARY KEY CLUSTERED 
	(
		[CharGuid] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY]

	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������ ĳ���� GUID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_UserMarketInfo2', @level2type=N'COLUMN',@level2name=N'CharGuid'
	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���� �̸�' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_UserMarketInfo2', @level2type=N'COLUMN',@level2name=N'MarketName'
	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������ ĳ���� �̸�' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_UserMarketInfo2', @level2type=N'COLUMN',@level2name=N'CharName'
	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���� ���' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_UserMarketInfo2', @level2type=N'COLUMN',@level2name=N'Grade'
	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���� ����
	- ����
	- ����' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_UserMarketInfo2', @level2type=N'COLUMN',@level2name=N'State'
	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���� ���� �ð�' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_UserMarketInfo2', @level2type=N'COLUMN',@level2name=N'GenTime'
	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���� �������� ���� ����  �ð�' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_UserMarketInfo2', @level2type=N'COLUMN',@level2name=N'OfflineCloseTime'
	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���� �¶��� ���� ���� �ð�' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_UserMarketInfo2', @level2type=N'COLUMN',@level2name=N'OnlineCloseTime'
	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���� ���� ���� �ð�' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_UserMarketInfo2', @level2type=N'COLUMN',@level2name=N'MarketCloseTime'
	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���� ���� ����Ʈ 
	- �������� �˻� �켱 ������ ����.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_UserMarketInfo2', @level2type=N'COLUMN',@level2name=N'MarketHP'
	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���� ���� ���� ���� ���� ���̺�
	- ���� �̸� 
	- ������ ���� 
	- ���� ���
	- ���� �����ð� ��..' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_UserMarketInfo2'
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
ALTER TABLE dbo.TB_UserMarketInfo2
	DROP COLUMN CharName
GO
COMMIT
