USE [DR2_User]

IF EXISTS(SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'UP_CS_SELECTGIFTLIST'))
BEGIN
	DROP PROCEDURE [dbo].[UP_CS_SELECTGIFTLIST]
END
GO

/****** Object:  StoredProcedure [dbo].[UP_CS_SELECTGIFTLIST]    Script Date: 01/05/2012 16:54:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[UP_CS_SELECTGIFTLIST]
/*
////////////////////////////////��////////////////////////////////////////
//
// ���ν����� : Active Login Stat.
// �� �� �� : ??
// �� �� �� : ??
// ���������� : Richard Kim(tigerjune@barunsoninter.com)
// �� �� �� : 2008-10-31
// �� �� �� : 
// N O T E : 
//
////////////////////////////////////////////////////////////////////////
*/
(
	@CHARGUID UNIQUEIDENTIFIER
)
AS
SET XACT_ABORT ON
SET NOCOUNT ON;

-- ���� ����� 30�� ������ ����
DELETE FROM [dbo].[TB_UserCashGift] 
WHERE [CharGuId] = @CHARGUID AND [Type] = 0 AND [SendTime] <= DATEADD(day,-30,GETDATE())


--��������
SELECT TOP 400 [GiftGuId]
  ,[CharName]
  ,[SendTime]
  ,[CashItemIdx]
  ,[Comment]
  ,[Type]
  ,[TimeType]
  ,[UseTime]
FROM [dbo].[TB_UserCashGift] WHERE Type=0 AND [CharGuId] = @CHARGUID order by sendtime desc

--��������
SELECT TOP 600 [GiftGuId]
  ,[CharName]
  ,[SendTime]
  ,[CashItemIdx]
  ,[Comment]
  ,[Type]
  ,[TimeType]
  ,[UseTime]
FROM [dbo].[TB_UserCashGift] WHERE Type=1 AND [CharGuId] = @CHARGUID order by sendtime desc
