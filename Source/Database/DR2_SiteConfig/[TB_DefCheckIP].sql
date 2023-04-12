DROP TABLE [TB_DefCheckIP]
go


USE [DR2_SiteConfig]
GO
/****** ��ü:  Table [dbo].[TB_DefCheckIP]    ��ũ��Ʈ ��¥: 06/05/2009 01:55:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_DefCheckIP](
	[IDX] [int] IDENTITY(1,1) NOT NULL,
	[StartIP] [nvarchar](32) NOT NULL,
	[EndIP] [nvarchar](32) NOT NULL,
	[NationKey] [nvarchar](32) NULL,
	[NationName] [nvarchar](50) NULL
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'IP ���� ����' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_DefCheckIP'


/* 2009-07-20 R9459 ���� */
/*
		IP Block ����� ���� �Ǹ鼭 �� �̻� ������� �ʴ� ���̺� ����
		R9559 �����ε�, ���߿� ��ũ��Ʈ ���� �� ����.
*/
USE [DR2_SiteConfig]
GO
/****** Object:  Table [dbo].[TB_DefCheckIP]    Script Date: 07/20/2009 17:37:49 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TB_DefCheckIP]') AND type in (N'U'))
	DROP TABLE [dbo].[TB_DefCheckIP]
	GO