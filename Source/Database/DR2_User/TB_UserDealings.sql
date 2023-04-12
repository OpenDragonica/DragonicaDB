USE [DR2_User]
GO

IF NOT EXISTS(SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'TB_UserDealings'))
BEGIN
	/****** Object:  Table [dbo].[TB_UserDealings]    Script Date: 03/31/2009 17:52:04 ******/
	SET ANSI_NULLS ON
	SET QUOTED_IDENTIFIER ON
	CREATE TABLE [dbo].[TB_UserDealings](
		[ItemGuid] [uniqueidentifier] NOT NULL,
		[CharacterGuid] [uniqueidentifier] NOT NULL,
		[DealerName] [nvarchar](20) NOT NULL,
		[ItemNo] [int] NOT NULL,
		[ItemNum] [smallint] NOT NULL,
		[Enchant_01] [bigint] NOT NULL,
		[Enchant_02] [bigint] NOT NULL,
		[SellCost] [bigint] NOT NULL,
		[CostType] [tinyint] NOT NULL,
		[ItemState] [tinyint] NOT NULL CONSTRAINT [DF_TB_UserDealings_ItemState]  DEFAULT ((0)),
		[ItemGenTime] [datetime] NULL,
		[CostRate] [int] NOT NULL CONSTRAINT [DF_TB_UserDealings_CostRate]  DEFAULT ((5)),
	 CONSTRAINT [PK_TB_UserDealings] PRIMARY KEY NONCLUSTERED 
	(
		[ItemGuid] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY]

	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�Ǹ��� ĳ���� GUID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_UserDealings', @level2type=N'COLUMN',@level2name=N'CharacterGuid'
	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��ǰ�� ������ ĳ������ �̸�' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_UserDealings', @level2type=N'COLUMN',@level2name=N'DealerName'
	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�Ǹ��� �������� ��ȣ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_UserDealings', @level2type=N'COLUMN',@level2name=N'ItemNo'
	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�Ǹ��� �������� ����' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_UserDealings', @level2type=N'COLUMN',@level2name=N'ItemNum'
	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�Ǹ��� �������� ��þƮ ����1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_UserDealings', @level2type=N'COLUMN',@level2name=N'Enchant_01'
	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�Ǹ��� �������� ��þƮ ����2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_UserDealings', @level2type=N'COLUMN',@level2name=N'Enchant_02'
	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�Ǹ� �ݾ�' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_UserDealings', @level2type=N'COLUMN',@level2name=N'SellCost'
	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�ŷ� ȭ���� ����
	- ���� �Ӵ�
	- ĳ��' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_UserDealings', @level2type=N'COLUMN',@level2name=N'CostType'
	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���� ������ ����' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_UserDealings', @level2type=N'COLUMN',@level2name=N'ItemState'
	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������ ���� ����' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_UserDealings', @level2type=N'COLUMN',@level2name=N'ItemGenTime'
	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���� �Ǹ� ������ ������' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_UserDealings', @level2type=N'COLUMN',@level2name=N'CostRate'
	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���� ���Ͽ��� ��ǰ�� �Ǹ��� ������ �����ϴ� ���̺�' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_UserDealings'
END

SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON

ALTER TABLE dbo.TB_UserDealings ADD DealerName NVARCHAR(20) DEFAULT(NULL)
GO

--���̺�TB_UserDealings��column enchant_03, enchant_04�߰�
alter table  dbo.TB_UserDealings
add Enchant_03 bigint not null default 0
go

alter table  dbo.TB_UserDealings
add Enchant_04 bigint not null default 0
go

