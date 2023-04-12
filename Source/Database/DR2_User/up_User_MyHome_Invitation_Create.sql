USE [DR2_User]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_User_MyHome_Invitation_Create]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_User_MyHome_Invitation_Create]

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[up_User_MyHome_Invitation_Create]
@HomeOwner UNIQUEIDENTIFIER,
@VisitorName NVARCHAR(20),
@StreetNo SMALLINT,
@HouseNo int,
@MaxCardNum int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @CurDate DATETIME, @GenCount INT, @LimitDate DATETIME, @OwnerGuid UNIQUEIDENTIFIER
	SET @CurDate = GETDATE()
	SET @LimitDate = DATEADD(hh,24,@CurDate)
	SELECT @OwnerGuid = characterid FROM dbo.TB_CharacterBasic WHERE [Name] = @VisitorName
	
	IF @OwnerGuid IS NULL
	BEGIN
		SELECT 1	-- �ش� ĳ���Ͱ� ����.
		RETURN
	END
	
	IF @OwnerGuid = @HomeOwner
	BEGIN
		SELECT 4
		RETURN
	END

	-- ��ȿ �Ⱓ�� ���� �ʴ��� ����
	DELETE FROM dbo.TB_User_MyHome_Invitation WHERE StreetNo = @StreetNo AND HouseNo = @HouseNo AND LimitTime <= @CurDate
	
	-- �̹� ���� �߱��� �ʴ��� ���� Ȯ��
	SELECT @GenCount = COUNT(*) FROM dbo.TB_User_MyHome_Invitation 
	WHERE GenYear = YEAR(@CurDate) AND GenMon = MONTH(@CurDate) AND GenDay = DAY(@Curdate)
	AND StreetNo = @StreetNo AND HouseNo = @HouseNo
	
	IF @MaxCardNum <= @GenCount
	BEGIN
		SELECT 2	-- ���� ����� ��û���� ��� ����ߴ�.
		RETURN
	END

	-- �ʴ��� �ű� �߱�
	INSERT INTO dbo.TB_User_MyHome_Invitation
	(CardGuid,OwnerGuid,StreetNo,HouseNo,LimitTime,GenYear,GenMon,GenDay)
	VALUES(NEWID(),@OwnerGuid,@StreetNo,@HouseNo,@LimitDate,Year(@CurDate),MONTH(@Curdate),DAY(@Curdate))

	IF @@ERROR <> 0
	BEGIN
		SELECT 3	-- ���� ������ �߻��ߴ�.
		RETURN
	END
	
	SELECT 0,@OwnerGuid,[Name] FROM dbo.TB_CharacterBasic WHERE CharacterID = @HomeOwner

END


