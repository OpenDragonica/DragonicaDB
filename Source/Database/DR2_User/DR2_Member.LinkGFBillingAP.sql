/*
������ : YonMy
�۾� ���� : �븸 GF Billing ������ ���� ���ν���


�۾� ����: 
1. TB_MemberSub Table�� (�ۺ��ſ�)Ȯ�� ���� �߰� : �븸 GF ����� �� ��������� ���
2. up_SelectMemberID ���� : MemberID Ȯ��
3. up_CreateMemberAccount_GF ���� : �븸 GF�� �������� ���ν���
4. up_SelectMemberAuthData_ExtVar ���� : �븸 GF�� �α���
5. up_CS_SelectMemberCash_ByID : ID�� ĳ���� ���������
6. up_CS_AddMemberCash_ByID : ID�� ĳ�� ����
7. CashLog Type�� 'APServer' �߰�
8. up_ChangeMemberSub_ExtVar ���� : Ȯ�� ���� ����
9. up_ChangeMemberSub_ExtVar_ByID ���� : Ȯ�� ���� (ID��) ����
10. up_CreateCoupon_GF ���� : �븸 GF�� ���� ����
*/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET NOCOUNT ON
GO
USE DR2_Member
GO

-- �ۺ��ſ� Ȯ�庯�� �߰�
ALTER TABLE [dbo].[TB_MemberSub] ADD [ExtVar] [smallint] NULL
GO

CREATE Proc [dbo].[up_SelectMemberID]
/*
////////////////////////////////////////////////////////////////////////
//
// ���ν����� : [dbo].[up_SelectMemberID]
// �� �� �� : YonMy
// �� �� �� : 2009-03-06
// ���������� : YonMy
// �� �� �� : 
// �� �� �� : 
// N O T E : ������� ���� Ȯ��
////////////////////////////////////////////////////////////////////////
*/
(
	@ID	nvarchar(20)
)
AS
SET NOCOUNT ON
BEGIN
	DECLARE @Err int
	SET @Err = 0
	
	SELECT	@Err
	,	[ID]
	,	[PW]
	,	[BasePW]
	FROM	[dbo].[Member]
	WHERE	[ID] = @ID

	IF @@ROWCOUNT = 0
	BEGIN
		SET @Err = 1
		SELECT @Err
	END
	RETURN @Err
END

GO

CREATE PROC [dbo].[up_CreateMemberAccount_GF]
/*
////////////////////////////////////////////////////////////////////////
//
// ���ν����� : [dbo].[up_CreateMemberAccount_GF]
// �� �� �� : 
// �� �� �� : 
// ���������� : YonMy
// �� �� �� : 2009-03-06
// �� �� �� : 
// N O T E :  GF(�븸 SoftWorld�� ���� ����)
////////////////////////////////////////////////////////////////////////
*/  (
      @ID NVARCHAR(20),	-- Member login id
      @PW NVARCHAR(20),	-- Member login password
      @Gender TINYINT,		-- Member Gender (0:unknown, 1:Male, 2:Female)
      @Birthday NVARCHAR(40),
      @ExtVar SMALLINT	-- Use Mobile Lock
    )
AS

SET nocount ON
DECLARE @MemberKey UNIQUEIDENTIFIER
DECLARE @Err INT
DECLARE @UID INT

SET @MemberKey = NEWID()
SET @Err = 0
SET @UID = 0

BEGIN TRAN

IF EXISTS (SELECT 1 FROM dbo.Member WHERE [ID] = @ID) 
BEGIN 
	SET @MemberKey = '00000000-0000-0000-0000-000000000000'
	SET @Err = 99
END
ELSE 
BEGIN
	INSERT  INTO [dbo].[Member]
		(
			[UID]
		,	[MemberKey]
		,	[ID]
		,	[PW]
		,	[BasePW]
		,	[Gender]
		,	[CreateDate]
		,	[GMLevel]
		,	[Block]
		,	[Cash]
		,	[TotalConnectTime]
		,	[AccDisconnectTime]
		,	[AccConnectTime]
		,	[LastLoginDate]
		,	[LastLogoutDate]
		,	[BirthDay]
		)
        VALUES
        (
			@UID
		,	@MemberKey
		,	@ID
		,	NULL
		,	@PW
		,	@Gender
		,	GETDATE()
		,	0
		,	0
		,	0
		,	0
		,	0
		,	0
		,	NULL
		,	NULL
		,	@Birthday
		)
		
	IF @@ERROR <> 0 
	BEGIN
		SET @Err = 1001
	END
	ELSE
	BEGIN
		INSERT  INTO [dbo].[MemberSub]
			(
				[MemberKey]
			,	[ExtVar]
			)
			VALUES
			(
				@MemberKey
			,	@ExtVar
			)
		
		IF @@ERROR <> 0
		BEGIN
			SET @Err = 1001
		END	
	END
END

IF @Err = 0
BEGIN
	COMMIT TRAN
END
ELSE
BEGIN
	ROLLBACK TRAN
END

SELECT  @Err, @MemberKey, @ID, @Gender, @Birthday, @UID
RETURN @Err
GO


CREATE Proc [dbo].[up_SelectMemberAuthData_ExtVar]
/*
////////////////////////////////////////////////////////////////////////
//
// ���ν����� : [dbo].[up_SelectMemberAuthData_ExtVar]
// �� �� �� : YonMy
// �� �� �� : 2009-03-06
// ���������� :
// �� �� �� : 
// �� �� �� : 
// N O T E : GF�� Auth

////////////////////////////////////////////////////////////////////////
*/
(
	@ID	nvarchar(20)
)
AS
SET NOCOUNT ON
BEGIN
	DECLARE @Err int
	SET @Err = 0
	
	SELECT		A.[MemberKey]
			,	A.[ID]
			,	A.[PW]
			,	A.[BasePW]
			,	A.[Gender]
			,	A.[BirthDay]
			,	A.[TotalConnectTime]
			,	A.[AccDisconnectTime]
			,	A.[AccConnectTime]
			,	A.[LastLoginDate]
			,	A.[LastLogoutDate]
			,	getdate()
			,	A.[GMLevel]
			,	A.[Block]
			,	A.[BlockStartTime]
			,	A.[BlockEndTime]
			,	A.[ConnectionChannel]
			,	B.[ExtVar]
	FROM	[dbo].[Member] A
		LEFT JOIN [dbo].[TB_MemberSub] B 
			ON A.MemberKey = B.MemberKey
	WHERE	A.ID = @ID
	
	EXEC [dbo].[up_Select_DefGMAccountIP] @ID
	return @Err
END
GO

CREATE PROCEDURE [dbo].[up_CS_SelectMemberCash_ByID]
/*
////////////////////////////////////////////////////////////////////////
//
// ���ν����� : [dbo].[p_CS_SelectMemberCash_ByID]
// �� �� �� : YonMy
// �� �� �� : 2009-03-06
// ���������� : YonMy
// �� �� �� : 
// �� �� �� : 
// N O T E : ID�� Cash������ ����
////////////////////////////////////////////////////////////////////////
*/

@ID	nvarchar(20)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT @ID, isnull(Cash,0) from dbo.Member where ID = @ID

END
GO

CREATE PROCEDURE  [dbo].[up_CS_AddMemberCash_ByID]
/*
////////////////////////////////////////////////////////////////////////
//
// ���ν����� : [dbo].[up_CS_SelectMemberCash_ByID]
// �� �� �� : YonMy
// �� �� �� : 2009-03-06
// ���������� : YonMy
// �� �� �� : 
// �� �� �� : 
// N O T E : ID�� Cash Add
////////////////////////////////////////////////////////////////////////
*/
	@ID	NVARCHAR(20),
	@CharGuid UNIQUEIDENTIFIER,
	@Cash BIGINT,				-- Cash to add
	@Type TINYINT,
	@Status CHAR(1)
AS
SET NOCOUNT ON
BEGIN

DECLARE @ERROR INT
SET @ERROR = 0

BEGIN TRAN

	DECLARE @MemberGuId UNIQUEIDENTIFIER
	DECLARE @OLDCASH BIGINT
	
	SELECT @MemberGuId = [MemberKey], @OLDCASH = ISNULL([CASH],0) FROM DBO.MEMBER WHERE [ID] = @ID

	IF @OLDCASH + @Cash < 0
	BEGIN
		SET @ERROR = 1000		
		GOTO __ERROR
	END

	UPDATE dbo.Member SET [Cash] = [Cash] + @Cash WHERE MemberKey = @MemberGuId
	IF @@ERROR <> 0
	BEGIN 
		SET @ERROR = 1001
		GOTO __ERROR
	END


	INSERT INTO [dbo].[tbl_CashLog] (MemberKey,CharacterID,f_Type,f_Status,f_amount,f_current,f_date)
	VALUES(@MEMBERGUID,@CharGuid,@Type,@Status,@Cash,@OLDCASH + @Cash,GETDATE())
	IF @@ERROR <> 0
	BEGIN 
		SET @ERROR = 1001
		GOTO __ERROR
	END

COMMIT TRAN

SELECT @ERROR,@ID,@OLDCASH,isnull([CASH],0),@CASH FROM dbo.Member WHERE MemberKey = @MemberGuId
RETURN @ERROR

__ERROR:

ROLLBACK TRAN

SELECT @ERROR,@ID,@OLDCASH,isnull([CASH],0),@CASH FROM dbo.Member WHERE MemberKey = @MemberGuId

RETURN @ERROR

END
GO

-- CashLog Type�� APServer
INSERT INTO [dbo].[tbl_CashType]([f_name]) VALUES('AP Server')
GO

CREATE PROCEDURE [dbo].[up_ChangeMemberSub_ExtVar]
/*
////////////////////////////////////////////////////////////////////////
//
// ���ν����� : [dbo].[up_CreateMemberAccount_GF]
// �� �� �� : 
// �� �� �� : 
// ���������� : YonMy
// �� �� �� : 2009-03-06
// �� �� �� : 
// N O T E :  GF(�븸 SoftWorld�� �ڵ����� �����������)
////////////////////////////////////////////////////////////////////////
*/  
(
      @MemberKey	UNIQUEIDENTIFIER,	-- MemberKey
      @ExtVar		SMALLINT
)
AS

SET nocount ON
DECLARE @Err INT
SET @Err = 0

BEGIN
	UPDATE	[dbo].[TB_MemberSub]
	SET		[ExtVar] = @ExtVar
	WHERE	[MemberKey] = @MemberKey
	
	IF @@ERROR <> 0
	BEGIN
		SET @Err = 99
	END
	
	SELECT @Err
	RETURN @Err
END
GO

CREATE PROCEDURE [dbo].[up_ChangeMemberSub_ExtVar_ByID]
/*
////////////////////////////////////////////////////////////////////////
//
// ���ν����� : [dbo].[up_ChangeMemberSub_ExtVar_ByID]
// �� �� �� : 
// �� �� �� : 
// ���������� : YonMy
// �� �� �� : 2009-03-06
// �� �� �� : 
// N O T E :  GF(�븸 SoftWorld�� �ڵ����� �����������)
////////////////////////////////////////////////////////////////////////
*/  
(
      @ID		NVARCHAR(20),-- MemberID
      @ExtVar	SMALLINT
)
AS

SET nocount ON
DECLARE @Err INT

SET @Err = 0

BEGIN TRAN

	DECLARE @MemberKey UNIQUEIDENTIFIER
	SELECT @MemberKey = [MemberKey] FROM [dbo].[Member] WHERE [ID] = @ID
	
	IF @@ROWCOUNT = 0
	BEGIN 
		SET @Err = 99
		GOTO __ERROR
	END
	
	UPDATE	[dbo].[TB_MemberSub]
	SET		[ExtVar] = @ExtVar
	WHERE	[MemberKey] = @MemberKey
	
	IF @@ERROR <> 0
	BEGIN
		SET @Err = 99
		GOTO __ERROR
	END
	
COMMIT TRAN
SELECT @Err
RETURN @Err

__ERROR:

ROLLBACK TRAN
SELECT @Err
RETURN @Err
GO

CREATE PROC [dbo].[up_CreateCoupon_GF]
/*
////////////////////////////////////////////////////////////////////////
//
// ���ν����� : [dbo].[up_CreateCoupon_GF]
// �� �� �� : 
// �� �� �� : 
// ���������� : YonMy
// �� �� �� : 2009-03-06
// �� �� �� : 
// N O T E :  GF(�븸 SoftWorld�� ���� �߱�)
////////////////////////////////////////////////////////////////////////
*/  
(
	@ID			NVARCHAR(20),-- Member login id
	@CouponID	NVARCHAR(50),-- CouponID
	@EventKey	INT,
	@RewardKey	INT
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
	-- EventKey�� �ִ��� Ȯ��
	IF EXISTS (SELECT 1 FROM [dbo].[TB_Event_Type] WHERE [f_EventKey] = @EventKey)
	BEGIN
		
		-- RewardKey�� �ִ��� Ȯ��
		IF EXISTS (SELECT 1 FROM [dbo].[TB_Event_Reward] WHERE [f_RewardKey] = @RewardKey)
		BEGIN
			
			-- �����ϴ� Coupon���� Ȯ��
			IF EXISTS (SELECT 1 FROM [dbo].[TB_Event_Coupon] WHERE [f_CouponID] = @CouponID)
			BEGIN
				SET @Err = 4 -- Error CouponID Already
			END
			ELSE
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
GO






