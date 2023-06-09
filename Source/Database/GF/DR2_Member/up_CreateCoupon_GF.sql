USE [DR2_Member]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_CreateCoupon_GF]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_CreateCoupon_GF]
GO

CREATE PROCEDURE [dbo].[up_CreateCoupon_GF]
/*
////////////////////////////////////////////////////////////////////////
//
// 프로시져명 : [dbo].[up_CreateCoupon_GF]
// 작 성 자 : 
// 작 성 일 : 
// 최종수정자 : YonMy
// 수 정 일 : 2009-03-09
// 파 일 명 : 
// N O T E :  GF(대만 SoftWorld용 쿠폰 발금)
// 2009-05-13, Realm 선택 기능 추가, YonMy
// 2009-12-22 : Eric Kim, @ID nvarchar(20)->nvarchar(50)
////////////////////////////////////////////////////////////////////////
*/  
(
	@ID			NVARCHAR(50),-- Member login id
	@CouponID	NVARCHAR(50),-- CouponID
	@EventKey	INT,
	@RewardKey	INT,
	@RealmNo	SMALLINT
)
AS

SET nocount ON

DECLARE @Err INT
SET @Err = 0

BEGIN TRAN

DECLARE @MemberKey UNIQUEIDENTIFIER
SELECT @MemberKey=[MemberKey] FROM [dbo].[Member] WHERE [ID] = @ID

IF @@ROWCOUNT <> 0
BEGIN
	-- EventKey가 있는지 확인
	IF EXISTS (SELECT 1 FROM [dbo].[TB_Event_Type] WHERE [f_EventKey] = @EventKey)
	BEGIN
		
		-- RewardKey가 있는지 확인
		IF EXISTS (SELECT 1 FROM [dbo].[TB_Event_Reward] WHERE [f_RewardKey] = @RewardKey)
		BEGIN
			
			-- 존재하는 Coupon인지 확인
			IF EXISTS (SELECT 1 FROM [dbo].[TB_Event_Coupon] WHERE [f_CouponID] = @CouponID)
			BEGIN
				SET @Err = 4 -- Error CouponID Already
			END
			ELSE
			BEGIN
				IF @RealmNo = 0
				BEGIN
					INSERT INTO [dbo].[TB_Event_Coupon]
					(
						[f_CouponID]
					,	[f_EventKey]
					,	[f_RewardKey]
					,	[f_OwnerMemberGuid]
					)
					VALUES
					(
						@CouponID
					,	@EventKey
					,	@RewardKey
					,	@MemberKey
					)
				END
				ELSE
				BEGIN
					INSERT INTO [dbo].[TB_Event_Coupon]
					(
						[f_CouponID]
					,	[f_EventKey]
					,	[f_RewardKey]
					,	[f_OwnerMemberGuid]
					,	[f_Realm] 
					)
					VALUES
					(
						@CouponID
					,	@EventKey
					,	@RewardKey
					,	@MemberKey
					,	@RealmNo
					)
				END
				
				COMMIT TRAN
				SELECT @Err, @CouponID
				RETURN @Err
			END		
		END
		ELSE
		BEGIN
			SET @Err = 1028	-- RewardKey Error
		END
	END
	ELSE
	BEGIN
		SET @Err = 516 -- EventKey Error
	END	
END
ELSE
BEGIN
	SET @Err = 1 -- User ID Error
END

ROLLBACK TRAN
SELECT @Err, @CouponID
RETURN @Err
