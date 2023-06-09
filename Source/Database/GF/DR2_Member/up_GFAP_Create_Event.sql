USE [DR2_Member]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_GFAP_Create_EventType]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_GFAP_Create_EventType]
GO

CREATE PROC [dbo].[up_GFAP_Create_EventType]
/*
////////////////////////////////////////////////////////////////////////
//
// 프로시져명 : [dbo].[up_GFAP_Create_EventType]
// 작 성 자 : 
// 작 성 일 : 
// 최종수정자 : YonMy
// 수 정 일 : 2009-04-23
// 파 일 명 : 
// N O T E : 
////////////////////////////////////////////////////////////////////////
*/  
(
	@EventKey		INT,
	@StartDate		DATETIME,
	@EndDate		DATETIME,
	@Memo			NVARCHAR(50),
	@Title			NVARCHAR(50),
	@Discriptino	NVARCHAR(200),
	@Type			TINYINT	-- 1(insert)
)
AS

DECLARE @Ret INT
SET @Ret = 0

DECLARE @Count	int

IF @Type = 1
BEGIN
	
	SET @Count = ( SELECT COUNT(*) FROM [dbo].[TB_Event_Type] WHERE f_EventKey = @EventKey )
	
	IF @Count = 0
	BEGIN
		INSERT INTO [dbo].[TB_Event_Type]
		(
			f_IDX
		,	f_EventKey
		,	f_StartDate
		,	f_EndDate
		,	f_Memo
		,	f_Title
		,	f_Discriptino
		)
		VALUES
		(
			@EventKey
		,	@EventKey
		,	@StartDate
		,	@EndDate
		,	@Memo
		,	@Title
		,	@Discriptino
		)
	END
	ELSE
	BEGIN
		SET @Ret = 1
	END
END
ELSE
BEGIN

	SET @Count = ( SELECT COUNT(*) FROM [dbo].[TB_Event_Type] WHERE f_EventKey = @EventKey )
	IF @Count = 0
	BEGIN
		SET @Ret = 1
	END
	ELSE
	BEGIN
		UPDATE [dbo].[TB_Event_Type]
		SET
			[f_StartDate] = @StartDate
		,	[f_EndDate] = @EndDate
		,	[f_Memo] = @Memo
		,	[f_Title] = @Title
		,	[f_Discriptino] = @Discriptino
		WHERE [f_EventKey] = @EventKey
	END
END

SELECT @Ret
RETURN @Ret
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_GFAP_Delete_EventType]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_GFAP_Delete_EventType]
GO

CREATE PROC [dbo].[up_GFAP_Delete_EventType]
/*
////////////////////////////////////////////////////////////////////////
//
// 프로시져명 : [dbo].[up_GFAP_Delete_EventType]
// 작 성 자 : 
// 작 성 일 : 
// 최종수정자 : YonMy
// 수 정 일 : 2009-04-23
// 파 일 명 : 
// N O T E : 
////////////////////////////////////////////////////////////////////////
*/  
(
	@EventKey	INT
)
AS

DECLARE @Ret INT
SET @Ret = 0

DECLARE @Count	int
SET @Count = ( SELECT COUNT(*) FROM dbo.TB_Event_Coupon WHERE f_EventKey = @EventKey )

IF @Count <> 0
BEGIN
	SET @Ret = 3
END
ELSE
BEGIN
	SET @Count = ( SELECT COUNT(*) FROM [dbo].[TB_Event_Type_Reward] WHERE f_EventKey = @EventKey )
	IF @Count <> 0
	BEGIN
		DELETE FROM [dbo].[TB_Event_Type_Reward] WHERE f_EventKey = @EventKey
	END
	
	SET @Count = ( SELECT COUNT(*) FROM [dbo].[TB_Event_Type] WHERE f_EventKey = @EventKey )
	IF @Count <> 0
	BEGIN
		DELETE FROM [dbo].[TB_Event_Type] WHERE f_EventKey = @EventKey
	END
	ELSE
	BEGIN
		SET @Ret = 1
	END
	
END

SELECT @Ret
RETURN @Ret
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_GFAP_Create_EventReward]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_GFAP_Create_EventReward]
GO

CREATE PROC [dbo].[up_GFAP_Create_EventReward]
/*
////////////////////////////////////////////////////////////////////////
//
// 프로시져명 : [dbo].[up_GFAP_Create_EventReward]
// 작 성 자 : 
// 작 성 일 : 
// 최종수정자 : YonMy
// 수 정 일 : 2009-04-23
// 파 일 명 : 
// N O T E : 
////////////////////////////////////////////////////////////////////////
*/  
(
	@RewardKey			INT,
	@RewardItemNo1		INT,
	@RewardItemCount1	SMALLINT,
	@RewardTimeType1	TINYINT,
	@RewardUseTime1		SMALLINT,
	@RewardItemNo2		INT,
	@RewardItemCount2	SMALLINT,
	@RewardTimeType2	TINYINT,
	@RewardUseTime2		SMALLINT,
	@RewardItemNo3		INT,
	@RewardItemCount3	SMALLINT,
	@RewardTimeType3	TINYINT,
	@RewardUseTime3		SMALLINT,
	@RewardItemNo4		INT,
	@RewardItemCount4	SMALLINT,
	@RewardTimeType4	TINYINT,
	@RewardUseTime4		SMALLINT,
	@Money				INT,
	@Cash				INT,
	@Title				NVARCHAR(50),
	@Type				TINYINT	-- 1(insert)
)
AS

DECLARE @Ret INT
SET @Ret = 0

DECLARE @Count	int

IF @Type = 1
BEGIN

	SET @Count = ( SELECT COUNT(*) FROM [dbo].[TB_Event_Reward] WHERE f_RewardKey = @RewardKey )
	IF @Count = 0
	BEGIN
		INSERT INTO [dbo].[TB_Event_Reward]
		(
			f_IDX
		,	f_RewardKey
		,	f_RewardItemNo1
		,	f_RewardItemCount1
		,	f_RewardTimeType1
		,	f_RewardUseTime1
		,	f_RewardItemNo2
		,	f_RewardItemCount2
		,	f_RewardTimeType2
		,	f_RewardUseTime2
		,	f_RewardItemNo3
		,	f_RewardItemCount3
		,	f_RewardTimeType3
		,	f_RewardUseTime3
		,	f_RewardItemNo4
		,	f_RewardItemCount4
		,	f_RewardTimeType4
		,	f_RewardUseTime4
		,	f_Money
		,	f_Cash
		,	f_Title
		)
		VALUES
		(
			@RewardKey
		,	@RewardKey
		,	@RewardItemNo1
		,	@RewardItemCount1
		,	@RewardTimeType1
		,	@RewardUseTime1
		,	@RewardItemNo2
		,	@RewardItemCount2
		,	@RewardTimeType2
		,	@RewardUseTime2
		,	@RewardItemNo3
		,	@RewardItemCount3
		,	@RewardTimeType3
		,	@RewardUseTime3
		,	@RewardItemNo4
		,	@RewardItemCount4
		,	@RewardTimeType4
		,	@RewardUseTime4
		,	@Money
		,	@Cash
		,	@Title
		)
	END
	ELSE
	BEGIN
		SET @Ret = 1
	END
END
ELSE
BEGIN

	SET @Count = ( SELECT COUNT(*) FROM [dbo].[TB_Event_Reward] WHERE f_RewardKey = @RewardKey )
	IF @Count = 0
	BEGIN
		SET @Ret = 1
	END
	ELSE
	BEGIN
		UPDATE [dbo].[TB_Event_Reward]
		SET
			[f_RewardItemNo1] = @RewardItemNo1
		,	[f_RewardItemCount1] = @RewardItemNo1
		,	[f_RewardTimeType1] = @RewardTimeType1
		,	[f_RewardUseTime1] = @RewardUseTime1
		,	[f_RewardItemNo2] = @RewardItemNo2
		,	[f_RewardItemCount2] = @RewardItemNo2
		,	[f_RewardTimeType2] = @RewardTimeType2
		,	[f_RewardUseTime2] = @RewardUseTime2
		,	[f_RewardItemNo3] = @RewardItemNo3
		,	[f_RewardItemCount3] = @RewardItemNo3
		,	[f_RewardTimeType3] = @RewardTimeType3
		,	[f_RewardUseTime3] = @RewardUseTime3
		,	[f_RewardItemNo4] = @RewardItemNo4
		,	[f_RewardItemCount4] = @RewardItemNo4
		,	[f_RewardTimeType4] = @RewardTimeType4
		,	[f_RewardUseTime4] = @RewardUseTime4
		,	[f_Money] = @Money
		,	[f_Cash] = @Cash
		,	[f_Title] = @Title
		WHERE [f_RewardKey] = @RewardKey
	END
	
END

SELECT @Ret
RETURN @Ret
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_GFAP_Delete_EventReward]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_GFAP_Delete_EventReward]
GO

CREATE PROC [dbo].[up_GFAP_Delete_EventReward]
/*
////////////////////////////////////////////////////////////////////////
//
// 프로시져명 : [dbo].[up_GFAP_Delete_EventReward]
// 작 성 자 : 
// 작 성 일 : 
// 최종수정자 : YonMy
// 수 정 일 : 2009-04-23
// 파 일 명 : 
// N O T E : 
////////////////////////////////////////////////////////////////////////
*/  
(
	@RewardKey	INT
)
AS

DECLARE @Ret INT
SET @Ret = 0

DECLARE @Count	int
SET @Count = ( SELECT COUNT(*) FROM dbo.TB_Event_Coupon WHERE f_RewardKey = @RewardKey )

IF @Count <> 0
BEGIN
	SET @Ret = 3
END
ELSE
BEGIN
	SET @Count = ( SELECT COUNT(*) FROM [dbo].[TB_Event_Reward] WHERE f_RewardKey = @RewardKey )
	IF @Count <> 0
	BEGIN
		DELETE FROM [dbo].[TB_Event_Reward] WHERE f_RewardKey = @RewardKey
	END
	ELSE
	BEGIN
		SET @Ret = 1
	END
END

SELECT @Ret
RETURN @Ret
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_GFAP_Create_EventTypeReward]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_GFAP_Create_EventTypeReward]
GO

CREATE PROC [dbo].[up_GFAP_Create_EventTypeReward]
/*
////////////////////////////////////////////////////////////////////////
//
// 프로시져명 : [dbo].[up_GFAP_Create_EventTypeReward]
// 작 성 자 : 
// 작 성 일 : 
// 최종수정자 : YonMy
// 수 정 일 : 2009-04-23
// 파 일 명 : 
// N O T E : 
////////////////////////////////////////////////////////////////////////
*/  
(
	@EventKey			INT,
	@RewardTitle		NVARCHAR(50),
	@RewardItem1		INT,
	@RewardItem2		INT,
	@RewardItem3		INT,
	@RewardItem4		INT,
	@RewardItem5		INT,
	@RewardItem6		INT,
	@RewardItem7		INT,
	@RewardItem8		INT,
	@RewardItem9		INT,
	@RewardItem10		INT,
	@Type				TINYINT	-- 1(insert)
)
AS

DECLARE @Ret INT
SET @Ret = 0

DECLARE @Count	INT

IF @Type = 1
BEGIN

	SET @Count = ( SELECT COUNT(*) FROM dbo.TB_Event_Type WHERE f_EventKey = @EventKey )
	
	IF @Count > 0
	BEGIN
	
		INSERT INTO [dbo].[TB_Event_Type_Reward]
		(
			f_EventKey
		,	RewardTitle
		,	RewardItem1
		,	RewardItem2
		,	RewardItem3
		,	RewardItem4
		,	RewardItem5
		,	RewardItem6
		,	RewardItem7
		,	RewardItem8
		,	RewardItem9
		,	RewardItem10
		)
		VALUES
		(
			@EventKey
		,	@RewardTitle
		,	@RewardItem1
		,	@RewardItem2
		,	@RewardItem3
		,	@RewardItem4
		,	@RewardItem5
		,	@RewardItem6
		,	@RewardItem7
		,	@RewardItem8
		,	@RewardItem9
		,	@RewardItem10
		)
	END
	ELSE
	BEGIN
		SET @Ret = 2
	END 
	
END
ELSE
BEGIN

	SET @Count = ( SELECT COUNT(*) FROM [dbo].[TB_Event_Type_Reward] WHERE [f_EventKey] = @EventKey )
	IF @Count <> 0
	BEGIN
		UPDATE [dbo].[TB_Event_Type_Reward]
		SET
			[RewardTitle] = @RewardTitle
		,	[RewardItem1] = @RewardItem1
		,	[RewardItem2] = @RewardItem2
		,	[RewardItem3] = @RewardItem3
		,	[RewardItem4] = @RewardItem4
		,	[RewardItem5] = @RewardItem5
		,	[RewardItem6] = @RewardItem6
		,	[RewardItem7] = @RewardItem7
		,	[RewardItem8] = @RewardItem8
		,	[RewardItem9] = @RewardItem9
		,	[RewardItem10] = @RewardItem10
		WHERE	[f_EventKey] = @EventKey
	END
	ELSE
	BEGIN
		SET @Ret = 1
	END
	
END

SELECT @Ret
RETURN @Ret
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_GFAP_Delete_EventTypeReward]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_GFAP_Delete_EventTypeReward]
GO

CREATE PROC [dbo].[up_GFAP_Delete_EventTypeReward]
/*
////////////////////////////////////////////////////////////////////////
//
// 프로시져명 : [dbo].[up_GFAP_Delete_EventTypeReward]
// 작 성 자 : 
// 작 성 일 : 
// 최종수정자 : YonMy
// 수 정 일 : 2009-04-23
// 파 일 명 : 
// N O T E : 
////////////////////////////////////////////////////////////////////////
*/  
(
	@EventKey	INT
)
AS

DECLARE @Ret INT
SET @Ret = 0

DECLARE @Count	INT

BEGIN
	SET @Count = ( SELECT COUNT(*) FROM [dbo].[TB_Event_Type_Reward] WHERE [f_EventKey] = @EventKey )
	IF @Count <> 0
	BEGIN
		DELETE FROM [dbo].[TB_Event_Type_Reward] WHERE f_EventKey = @EventKey
	END
	ELSE
	BEGIN
		SET @Ret = 1
	END
END

SELECT @Ret
RETURN @Ret
GO

