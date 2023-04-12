USE [DR2_User]
IF EXISTS(SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'up_UM_AddDealings2'))
BEGIN
	DROP PROCEDURE [dbo].[up_UM_AddDealings2]
END
GO

/****** Object:  StoredProcedure [dbo].[up_UM_AddDealings]    Script Date: 03/31/2009 14:04:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




/*
////////////////////////////////////////////////////////////////////////
// Lasst Update by : 
// Update date  : 
// Description : 
// [PARAMETER] : 
// [RETURN] : 
// [REMARK]
//	���ο� transaction�� ������ �ܺο��� �ɾ� �ٰ�
////////////////////////////////////////////////////////////////////////
*/
CREATE PROCEDURE [dbo].[up_UM_AddDealings2]
    (
      @ItemGuid UNIQUEIDENTIFIER,
      @SellerGuid UNIQUEIDENTIFIER,
      @DealerName NVARCHAR(20),
      @ItemNo INT,
      @ItemNum SMALLINT,
      @Enchant_01 BIGINT,
      @Enchant_02 BIGINT,
      @Enchant_03 BIGINT,
      @Enchant_04 BIGINT,
      @SellCost BIGINT,
      @CostType TINYINT,
      @ItemState TINYINT,
      @ItemGenTime DATETIME,
      @CostRate int
    )
AS 
    BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
        SET NOCOUNT ON ;

-- Begin Tran ���� ���� : �ܺο��� Transaction �ɾ� �ٰ�
-- ������ �ŷ� ���� ����

        INSERT  INTO dbo.TB_UserDealings
                (
                  CharacterGuid,
                  DealerName,
                  ItemNo,
                  ItemNum,
                  Enchant_01,
                  Enchant_02,
		  Enchant_03,
                  Enchant_04,
                  SellCost,
                  CostType,
                  ItemGuid,
                  ItemState,
                  ItemGenTime,
                  CostRate
                )
        VALUES  (
                  @SellerGuid,
                  @DealerName,
                  @ItemNo,
                  @ItemNum,
                  @Enchant_01,
                  @Enchant_02,
		  @Enchant_03,
                  @Enchant_04,
                  @SellCost,
                  @CostType,
                  @ItemGuid,
                  @ItemState,
                  @ItemGenTime,
                  @CostRate
                )

        SELECT  @@error

    END
