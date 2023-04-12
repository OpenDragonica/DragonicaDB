USE [DR2_Member]
GO
/****** Object:  StoredProcedure [dbo].[up_Take_Coupon_Event]    Script Date: 11/04/2009 12:13:54 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Take_Coupon_Event]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_Take_Coupon_Event]

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[up_Take_Coupon_Event]
/*
////////////////////////////////////////////////////////////////////////
//
// ���ν�����: [dbo].[up_Take_Coupon_Event]
// �ۼ���: 
// �ۼ���:
// ����������: ����
// ������: 2009-01-09
// ���ϸ�: 
// N O T E :  �̹̻���������ǿ�����ȯ�ڵ��߰�
//
////////////////////////////////////////////////////////////////////////
*/ 
(
	@MemberGUID UNIQUEIDENTIFIER, 
	@CharacterGUID	UNIQUEIDENTIFIER,
	@CouponKey NVARCHAR(50),
	@SiteNo SMALLINT,
	@RealmNo SMALLINT
)
AS
SET NOCOUNT ON
BEGIN
	
	DECLARE @RewardKey INT,
			@Eventkey INT,
			@f_Site SMALLINT,
			@f_Realm SMALLINT,
			@TakeTime DATETIME,
			@CURDATE DATETIME,
			@TakerMemberGuid UNIQUEIDENTIFIER,
			@TakerCharacterGuid UNIQUEIDENTIFIER,
			@UseLimit TINYINT

	SELECT @RewardKey = 0, @EventKey = 0, @f_Site = 0, @f_Realm = 0, @UseLimit = 0

	SELECT TOP 1 
		@RewardKey = f_RewardKey,
		@EventKey = f_EventKey,
		@TakeTime = f_TakeDate,
		@f_Site = ISNULL(f_Site,0),
		@f_Realm = ISNULL(f_Realm,0),		
		@UseLimit = UseLimit
	FROM dbo.TB_Event_Coupon WHERE f_CouponID = @CouponKey

	IF @@ROWCOUNT = 0 OR (@f_Site <> 0 AND @f_Site <> @SiteNo) OR (@f_Realm <> 0 AND @f_Realm <> @RealmNo)
	BEGIN

		SELECT 1
		RETURN 1	-- ������߸���������ȣ�Է��̾ƴ����޵������̾��ٷθ����ؾ���

	END
	
	IF @TakeTime IS NOT NULL
	BEGIN
		SELECT 7
		RETURN 7	-- �̹̻���������ȣ�Դϴ�.
	END

	IF NOT EXISTS(SELECT 1 FROM dbo.TB_Event_Reward WHERE f_RewardKey = @RewardKey)
	BEGIN
		SELECT 2
		RETURN 2
	END
	
	-- �ϳ��� f_EventKey�� ����
	IF @UseLimit = 1 -- ������ 1���� ��밡��
	BEGIN
		IF EXISTS( SELECT 1 FROM dbo.TB_Event_Coupon WHERE f_TakerMemberGuid = @MemberGUID AND f_EventKey = @EventKey )
		BEGIN
			SELECT 8
			RETURN 8
		END
	END
	ELSE IF @UseLimit = 2 -- ĳ���ʹ� 1���� ��밡��
	BEGIN
		IF EXISTS( SELECT 1 FROM dbo.TB_Event_Coupon WHERE f_TakerCharacterGuid = @CharacterGUID AND f_EventKey = @EventKey )
		BEGIN
			SELECT 9
			RETURN 9
		END
	END

	DECLARE @STARTDATE DATETIME,
			@ENDDATE DATETIME,
			@REWARDGUID1 UNIQUEIDENTIFIER,-- ��������۰������̵𸦹̸��Ҵ��Ѵ�.
			@REWARDGUID2 UNIQUEIDENTIFIER,
			@REWARDGUID3 UNIQUEIDENTIFIER,
			@REWARDGUID4 UNIQUEIDENTIFIER,
			@REWARDGUID5 UNIQUEIDENTIFIER,
			@REWARDGUID6 UNIQUEIDENTIFIER,
			@REWARDGUID7 UNIQUEIDENTIFIER,
			@REWARDGUID8 UNIQUEIDENTIFIER

	SELECT @STARTDATE = f_StartDate, @ENDDATE = f_EndDate FROM TB_EVENT_TYPE WHERE f_EventKey = @EventKey

	IF @@ROWCOUNT = 0
	BEGIN

		SELECT 2
		RETURN 2	-- �߸����̺�ƮŸ���̴�.

	END

	
	SET @CURDATE = GETDATE()
	

	IF (@CURDATE < @STARTDATE) OR (@ENDDATE < @CURDATE)
	BEGIN 
		
		SELECT 3
		RETURN 3	-- �Ⱓ�̸���������̴�.

	END

	SELECT @REWARDGUID1 = NEWID()
		   ,@REWARDGUID2 = NEWID()
		   ,@REWARDGUID3 = NEWID()
		   ,@REWARDGUID4 = NEWID()
		   ,@REWARDGUID5 = NEWID()
		   ,@REWARDGUID6 = NEWID()
		   ,@REWARDGUID7 = NEWID()
		   ,@REWARDGUID8 = NEWID()

	UPDATE dbo.TB_Event_Coupon SET 
	 f_TakeDate = @CURDATE
	,f_TakerMemberGuid = @MemberGUID
	,f_TakerCharacterGuid = @CharacterGUID
	,f_RewardGuid1 = @REWARDGUID1
	,f_RewardGuid2 = @REWARDGUID2
	,f_RewardGuid3 = @REWARDGUID3 
	,f_RewardGuid4 = @REWARDGUID4 
	,f_RewardGuid5 = @REWARDGUID5 
	,f_RewardGuid6 = @REWARDGUID6 
	,f_RewardGuid7 = @REWARDGUID7 
	,f_RewardGuid8 = @REWARDGUID8  
	WHERE f_CouponID = @CouponKey

	IF @@ERROR <> 0
	BEGIN

		SELECT 4
		RETURN 4	-- DB ERROR

	END

	select top 1 
	0,
	 f_RewardItemNo1
	,f_RewardItemCount1
	,f_RewardTimeType1
	,f_RewardUseTime1
	,@REWARDGUID1
	,f_RewardItemNo2
	,f_RewardItemCount2
	,f_RewardTimeType2
	,f_RewardUseTime2
	,@REWARDGUID2
	,f_RewardItemNo3
	,f_RewardItemCount3
	,f_RewardTimeType3
	,f_RewardUseTime3
	,@REWARDGUID3
	,f_RewardItemNo4
	,f_RewardItemCount4
	,f_RewardTimeType4
	,f_RewardUseTime4
	,@REWARDGUID4

	,f_RewardItemNo5
	,f_RewardItemCount5
	,f_RewardTimeType5
	,f_RewardUseTime5
	,@REWARDGUID5
	,f_RewardItemNo6
	,f_RewardItemCount6
	,f_RewardTimeType6
	,f_RewardUseTime6
	,@REWARDGUID6
	,f_RewardItemNo7
	,f_RewardItemCount7
	,f_RewardTimeType7
	,f_RewardUseTime7
	,@REWARDGUID7
	,f_RewardItemNo8
	,f_RewardItemCount8
	,f_RewardTimeType8
	,f_RewardUseTime8
	,@REWARDGUID8

	,f_Money
	,f_Cash
	from dbo.TB_Event_Reward where f_RewardKey = @RewardKey

	RETURN 0	-- ����

END








