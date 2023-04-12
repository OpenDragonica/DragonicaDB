-- ���� ����Ȩ�� ��ϵ� �۾���� �۾��뿡 ������� �����۵� ���Ϸ� ������.
USE DR2_User
GO

CREATE TABLE #temp
(
	ownerguid uniqueidentifier,
	itemno int,
	itemguid uniqueidentifier,
	cnt int
)

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TB_JobSkill_WorkBench_Status]') AND type in (N'U'))
BEGIN

insert  into #temp (ownerguid, itemno,itemguid, cnt)  
select ownerguid,  itemno, itemguid, cnt
	   from (
	select   h.ownerguid as ownerguid, f_itemno as itemno,newid() as itemguid, count as cnt
		from dbo.TB_JobSkill_WorkBench_Status as wb
		join TB_UserItem as ui
		on wb.f_workbenchguid = ui.itemguid
		join TB_User_MyHome_Base as h
		on ui.ownerguid = h.HomeInSideGuid
		
		union all

	select   h.ownerguid as ownerguid, f_01SlotItemno as itemno, newid() as itemguid, 1 as cnt
		from dbo.TB_JobSkill_WorkBench_Status as wb
		join TB_UserItem as ui
		on wb.f_workbenchguid = ui.itemguid
		join TB_User_MyHome_Base as h
		on ui.ownerguid = h.HomeInSideGuid
		
			union all

	select   h.ownerguid as ownerguid, f_02SlotItemno as itemno, newid() as itemguid, 1 as cnt
		from dbo.TB_JobSkill_WorkBench_Status as wb
		join TB_UserItem as ui
		on wb.f_workbenchguid = ui.itemguid
		join TB_User_MyHome_Base as h
		on ui.ownerguid = h.HomeInSideGuid
		
			union all

	select   h.ownerguid as ownerguid, f_03SlotItemno as itemno, newid() as itemguid, 1 as cnt
		from dbo.TB_JobSkill_WorkBench_Status as wb
		join TB_UserItem as ui
		on wb.f_workbenchguid = ui.itemguid
		join TB_User_MyHome_Base as h
		on ui.ownerguid = h.HomeInSideGuid
		
			union all

	select   h.ownerguid as ownerguid, f_04SlotItemno as itemno, newid() as itemguid, 1 as cnt
		from dbo.TB_JobSkill_WorkBench_Status as wb
		join TB_UserItem as ui
		on wb.f_workbenchguid = ui.itemguid
		join TB_User_MyHome_Base as h
		on ui.ownerguid = h.HomeInSideGuid
		
			union all

	select   h.ownerguid as ownerguid, f_05SlotItemno as itemno, newid() as itemguid, 1 as cnt
		from dbo.TB_JobSkill_WorkBench_Status as wb
		join TB_UserItem as ui
		on wb.f_workbenchguid = ui.itemguid
		join TB_User_MyHome_Base as h
		on ui.ownerguid = h.HomeInSideGuid
		
			union all

	select   h.ownerguid as ownerguid, f_06SlotItemno as itemno, newid() as itemguid, 1 as cnt
		from dbo.TB_JobSkill_WorkBench_Status as wb
		join TB_UserItem as ui
		on wb.f_workbenchguid = ui.itemguid
		join TB_User_MyHome_Base as h
		on ui.ownerguid = h.HomeInSideGuid
		
			union all

	select   h.ownerguid as ownerguid, f_07SlotItemno as itemno, newid() as itemguid, 1 as cnt
		from dbo.TB_JobSkill_WorkBench_Status as wb
		join TB_UserItem as ui
		on wb.f_workbenchguid = ui.itemguid
		join TB_User_MyHome_Base as h
		on ui.ownerguid = h.HomeInSideGuid
		
			union all

	select   h.ownerguid as ownerguid, f_08SlotItemno as itemno, newid() as itemguid, 1 as cnt
		from dbo.TB_JobSkill_WorkBench_Status as wb
		join TB_UserItem as ui
		on wb.f_workbenchguid = ui.itemguid
		join TB_User_MyHome_Base as h
		on ui.ownerguid = h.HomeInSideGuid
		
			union all

	select   h.ownerguid as ownerguid, f_09SlotItemno as itemno, newid() as itemguid, 1 as cnt
		from dbo.TB_JobSkill_WorkBench_Status as wb
		join TB_UserItem as ui
		on wb.f_workbenchguid = ui.itemguid
		join TB_User_MyHome_Base as h
		on ui.ownerguid = h.HomeInSideGuid
		
			union all

	select   h.ownerguid as ownerguid, f_10SlotItemno as itemno, newid() as itemguid, 1 as cnt
		from dbo.TB_JobSkill_WorkBench_Status as wb
		join TB_UserItem as ui
		on wb.f_workbenchguid = ui.itemguid
		join TB_User_MyHome_Base as h
		on ui.ownerguid = h.HomeInSideGuid
		
 ) as T
 where T.itemno>0

END


Declare @title nvarchar(50)
Declare @note nvarchar(200)
SET @title = 'return my home item'
SET @note = 'return my home item note'
 
 --����
 INSERT INTO  [dbo].[TB_UserMail]
           ([MailGuid]
           ,[FromGuid]
           ,[ToGuid]
           ,[Title]
           ,[Note]
           ,[PaymentType]
           ,[ItemGuid]
           ,[Money]
           ,[SendTime]
           ,[LimitTime]
           ,[ReadBit]
           ,[ReturnBit]
           ,[AnnexBit]
           ,[PaymentBit]
           ,[FromName])
 SELECT
	newid() as mailid
	, ownerguid as fromid
	, ownerguid as toid
	, @title as title
	, @note as note
	, 0 as ptype
	, itemguid 
	, 0 as money
	, getdate()as stime
	, dateadd(yy, 10, getdate()) as ltime
	, 0, 0, 0, 0, null
 FROM #temp
 
 
 
 --������
 
 INSERT INTO [dbo].[TB_UserItem]
           ([ItemGuid]
           ,[OwnerGuid]
           ,[InvType]
           ,[InvPos]
           ,[ItemNo]
           ,[Count]
           ,[State]
           ,[CreateDate])
	SELECT 
		itemguid
		,ownerguid
		,9
		,0
		,itemno
		,cnt
		,0
 		,getdate()
 FROM #temp
   
 
 DROP TABLE #temp
  
   
-- ���� ����Ȩ�� ��ϵǾ� �ִ� ������ ����   
 delete TB_User_MyHome_EquipItem
 from TB_User_MyHome_EquipItem as e join dbo.TB_JobSkill_WorkBench_Status as wb
 on e.itemguid = wb.f_WorkBenchGuid
  
 delete tb_useritem
 from tb_useritem as e join dbo.TB_JobSkill_WorkBench_Status as wb
 on e.itemguid = wb.f_WorkBenchGuid
 
 truncate table TB_JobSkill_WorkBench_Status
 
 truncate table TB_JobSkill_WorkBench_Log
 
-- ���� ���忡 ���̺� ���� ����
--/****** Object:  Table [dbo].[TB_JobSkill_WorkBench_Log]    Script Date: 11/29/2012 15:51:01 ******/
--IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TB_JobSkill_WorkBench_Log]') AND type in (N'U'))
--DROP TABLE [dbo].[TB_JobSkill_WorkBench_Log]
--GO
--
--
--/****** Object:  Table [dbo].[TB_JobSkill_WorkBench_Status]    Script Date: 11/29/2012 15:51:45 ******/
--IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TB_JobSkill_WorkBench_Status]') AND type in (N'U'))
--DROP TABLE [dbo].[TB_JobSkill_WorkBench_Status]
--GO
--
--/****** Object:  Table [dbo].[TB_UserJobSkill_WB_OfflineHistory]    Script Date: 11/29/2012 16:16:22 ******/
--IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TB_UserJobSkill_WB_OfflineHistory]') AND type in (N'U'))
--DROP TABLE [dbo].[TB_UserJobSkill_WB_OfflineHistory]

GO