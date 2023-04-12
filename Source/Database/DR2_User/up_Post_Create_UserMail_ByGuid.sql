USE [DR2_User]
GO
/****** Object:  StoredProcedure [dbo].[up_Post_Create_UserMail_ByGuid]    Script Date: 08/07/2009 13:17:02 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Post_Create_UserMail_ByGuid]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_Post_Create_UserMail_ByGuid]

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create PROCEDURE [dbo].[up_Post_Create_UserMail_ByGuid]
(
	@MailGuid			UNIQUEIDENTIFIER,	--���� guid
	@FromGuid			UNIQUEIDENTIFIER,	--�޽��� �߼��� ���� guid
	@ToGuid				UNIQUEIDENTIFIER,	--�޽��� ������ ĳ���� guid
	@Title				NVARCHAR(40),		--���� Ÿ��Ʋ
	@Text				NVARCHAR(200),		--���� ����

	@ItemGuid			UNIQUEIDENTIFIER,	--������ ������ guid
	@Money				BIGINT,			--������ �ݾ�
	@PaymentType			TINYINT,		--�ݾ� �� ���� ó�� �����°��ΰ�?/�޴°��ΰ�?
	@FromName			NVARCHAR(50)
)
AS
SET NOCOUNT ON
SET Xact_Abort ON

DECLARE @newguid UNIQUEIDENTIFIER
DECLARE @TMPGUID UNIQUEIDENTIFIER

set @newguid = @MailGuid
IF @FROMGUID = '00000000-0000-0000-0000-000000000000'
BEGIN
	SET @TMPGUID = @ToGuid
END
ELSE
BEGIN
	SET @TMPGUID = @FromGuid
END

DECLARE @LIMITHOUR INT
SET @LIMITHOUR = 30 * 24 + 1

IF @PaymentType > 0
BEGIN
	SET @LIMITHOUR = 3 * 24 + 1
END

insert into dbo.tb_usermail 
	(mailguid,
	fromguid,
	toguid,
	title,
	note,
	paymenttype,
	itemguid,
	[money],
	SendTime,
	LimitTime,
	ReadBit,
	AnnexBit,
	ReturnBit,
	PaymentBit,
	FromName)
values(@newguid,
	@TMPGUID,
	@toguid,
	@title,
	@text,
	@paymenttype,
	@itemguid,
	@money,
	getdate(),
	dateadd(hh,@LIMITHOUR,getdate()),
	0,0,0,@paymenttype,
	@FromName)

DECLARE @Err INT
SET @Err = @@error

IF @@error <> 0
BEGIN
	UPDATE [dbo].[TB_UserCharacter_Point]
	SET	[RecvMailCount] = [RecvMailCount] + 1
	WHERE [CharacterID] = @toguid
END

SELECT @Err,@toguid,@newguid




