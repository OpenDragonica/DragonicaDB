USE DR2_USER
GO

alter table TB_UserMarket
drop constraint DF_TB_UserMarket_ItemState
go
alter table TB_UserMarket
drop constraint DF_TB_UserMarket_ItemGenTime
go
--���̺�TB_UserMarket �÷�ItemNo, ItemNum, Enchant_01,Enchant_02, ItemState, ItemGenTime������
alter table TB_UserMarket
drop column ItemNo, ItemNum, Enchant_01,Enchant_02, ItemState, ItemGenTime
go