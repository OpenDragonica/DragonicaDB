USE DR2_USER
GO

alter table TB_DefBaseUserItem
drop column f_state
go

alter table  TB_DefBaseUserItem
add f_Enchant_03 bigint not null default 0
go

alter table  TB_DefBaseUserItem
add f_Enchant_04 bigint not null default 0
go

alter table  TB_DefBaseUserItem
add f_state tinyint not null default 0
go

/* Eric Kim, 2009-07-28 */
/* 	���� ������, ĳ���� ������ �ڵ�ȭ �ϱ� ���� �۾�  */
USE [DR2_User]
GO
/****** Object:  Index [PK_TB_DefBaseUserItem]    Script Date: 07/28/2009 18:37:42 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[TB_DefBaseUserItem]') AND name = N'PK_TB_DefBaseUserItem')
ALTER TABLE [dbo].[TB_DefBaseUserItem] DROP CONSTRAINT [PK_TB_DefBaseUserItem]
