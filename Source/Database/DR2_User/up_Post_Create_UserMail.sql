USE [DR2_User]
GO
/****** Object:  StoredProcedure [dbo].[up_Post_Create_UserMail]    Script Date: 08/07/2009 13:16:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Post_Create_UserMail]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_Post_Create_UserMail]

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[up_Post_Create_UserMail]
/*
////////////////////////////////////////////////////////////////////////
//
// ���ν����� : ������ ÷�� ���� �߼�
// �� �� �� : 
// �� �� �� : 2008-05-20
// ���������� :
// �� �� �� : 
// �� �� �� : 
// N O T E : 
//	2008-10-08 : Eric Kim, CharacterDB �ΰ��� �������� �� ����
//	2009-02-04 : YonMy, ���� �����Ҷ� Character_Point�� RecvMailCount �����ϰ� ����
////////////////////////////////////////////////////////////////////////
*/
(
	@MailGuid			UNIQUEIDENTIFIER,	--���� guid
	@FromGuid			UNIQUEIDENTIFIER,	--�޽��� �߼��� ���� guid
	@ToName				NVARCHAR(20),		--�޽��� ������ ĳ���� �̸�
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
DECLARE @ToGuId UNIQUEIDENTIFIER
SELECT @toguid = CharacterID FROM dbo.TB_CharacterBasic WHERE [name] = @ToName AND [State] = 0

if @@rowcount = 0
begin
	select 6,NULL,NULL
end

EXEC dbo.up_Post_Create_UserMail_ByGuid @MailGuid,@FromGuid,@ToGuid,@Title,@Text,@ItemGuid,@Money,@PaymentType,@FromName


