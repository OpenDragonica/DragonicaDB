USE [DR2_User]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Admin_CreateMyHome]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_Admin_CreateMyHome]

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[up_Admin_CreateMyHome]
@TownNo SMALLINT,-- �߰� Ÿ�� ��ȣ
@StartHouseNo int, -- �߰� Ȩ ���� ��ȣ 
@EndHouseNo int, -- �߰� Ȩ ������ ��ȣ
@GroundNo INT,-- 9991001 �� ����
@HomePrice BIGINT,-- ���� ��� ���� �ݾ�
@AuctionState TINYINT = NULL,-- ��� ���� 1: ����� 0: �Ϲ�
@AuctionTime DATETIME = NULL,-- ��� �����ð�
@LvLimitMin INT = NULL, -- ��� ���� �ּ� ����
@LvLimitMax INT = NULL, -- ��� ���� �ִ� ����
@HomeStyle int = NULL -- ����Ȩ ���� ������ ���� ������ ��ȣ
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	WHILE @StartHouseNo <= @EndHouseNo
	BEGIN
		
		INSERT INTO dbo.TB_User_MyHome_Base (
			StreetNo,
			HouseNo,
			HomePrice,
			GroundNo,
			AuctionState,
			AuctionTime,
			FirstBiddingCost,
			LastBiddingCost,
			HomeInSideGuid,
			HomeOutSideGuid,
			HomeColor,
			HomeStyle,
			HomeFence,
			HomeGarden,
			RoomWall,
			RoomFloor,
			AuctionLvLimitMin,
			AuctionLvLimitMax
		) VALUES 
		(@TownNo
		,@StartHouseNo
		,@HomePrice
		,@GroundNo
		,@AuctionState
		,@AuctionTime
		,@HomePrice
		,@HomePrice
		,NEWID()
		,NEWID()
		,0
		,@HomeStyle
		,0
		,0
		,70000540
		,70000550
		,@LvLimitMin
		,@LvLimitMax) 

		SET @StartHouseNo = @StartHouseNo + 1
		
	END

END





