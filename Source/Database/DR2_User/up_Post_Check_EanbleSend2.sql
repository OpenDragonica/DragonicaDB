USE [DR2_User]
GO
/****** Object:  StoredProcedure [dbo].[UP_CS_ADDGIFT2]    Script Date: 04/09/2009 21:39:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Post_Check_EanbleSend2]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_Post_Check_EanbleSend2]
GO

/****** Object:  StoredProcedure [dbo].[up_Post_Check_EanbleSend2]    Script Date: 04/16/2009 12:20:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[up_Post_Check_EanbleSend2]
/*
////////////////////////////////////////////////////////////////////////
//
// ���ν����� : ������ ÷�� ���� �߼�
// �� �� �� : Richard Kim(tigerjune@barunsoninter.com)
// �� �� �� : 2008-05-20
// ���������� :
// �� �� �� : 
// �� �� �� : 
// N O T E : 
//	2008-10-08 : character DB �ΰ��� ������ ���� ����
//	2009-04-16 : �̸� �˻��� ĳ���� ���°� Ȯ�� �ϵ��� ����
////////////////////////////////////////////////////////////////////////
*/
(
	@FromName			NVARCHAR(20),		--�޽��� �߼��� ĳ���� �̸�
	@FromGuid			UNIQUEIDENTIFIER,	--�޽��� �߼��� ���� guid
	@ToName				NVARCHAR(20),		--�޽��� ������ ĳ���� �̸�
	@Annex				TINYINT
)
AS

BEGIN

	SET NOCOUNT ON
	SET Xact_Abort ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	DECLARE @MAX_MAIL_COUNT INT
	DECLARE @ret INT
	DECLARE @frommailcount INT
	DECLARE @ToMailCount INT
	DECLARE @errVal INT
	DECLARE @toguid UNIQUEIDENTIFIER

	SET @frommailcount = 0

	-- �ؽ�Ʈ ������ ���� �ִ� 100�� �̰� ���� �����°� �� �� ���°� ���Ƽ� ����
	SET @MAX_MAIL_COUNT = 100

	IF @Annex <> 0
	BEGIN
		SELECT @frommailcount = COUNT(*) FROM dbo.tb_usermail AS A
		LEFT JOIN [dbo].[TB_UserItem] AS B ON A.ItemGuid = B.ItemGuid
		WHERE fromguid = @fromguid 
		AND AnnexBit  = 0
		AND (ISNULL(B.ItemNo,0) <> 0 OR A.[Money] <> 0)	

		-- 1. ���� ������ ����� ������ ���� �� �� �ִ� �������� �˻��Ѵ�.	
		IF @frommailcount >= @MAX_MAIL_COUNT
		BEGIN 
			SET @errVal = 4
			GOTO RESULT
		END
	END
	
	-- 2. �޴� ĳ���Ͱ� ���� �ϴ��� �˻�
	SELECT @toguid = characterid FROM [dbo].[TB_CharacterBasic] WHERE name = @toname AND [State] = 0
	
	IF @toguid IS NULL
	BEGIN
		SET @errVal = 9
		GOTO RESULT
	END

	SELECT @ToMailCount = COUNT(*) FROM dbo.tb_usermail WHERE toguid = @toguid

	-- 4. ���� ����� �������� �� ������ �ִ��� �˻�
	IF @ToMailCount >= @MAX_MAIL_COUNT 
	BEGIN
		SET @errVal = 10
		GOTO RESULT
	END

RESULT:

	SELECT @errVal,@toguid

END
