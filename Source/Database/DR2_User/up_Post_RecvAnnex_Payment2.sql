USE [DR2_User]
IF EXISTS(SELECT * FROM sys.all_objects WHERE [object_id] = OBJECT_ID(N'[dbo].[up_Post_RecvAnnex_Payment2]'))
BEGIN
	DROP PROCEDURE [dbo].[up_Post_RecvAnnex_Payment2]
END

/****** Object:  StoredProcedure [dbo].[up_Post_RecvAnnex_Payment2]    Script Date: 04/03/2009 14:40:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[up_Post_RecvAnnex_Payment2]
    @mailguid UNIQUEIDENTIFIER,
    @mailstate TINYINT,
    @charguid UNIQUEIDENTIFIER
AS 
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with SELECT statements.
    SET NOCOUNT ON ;

    DECLARE @errVal INT
    SET @errVal = 0
    DECLARE @readbit BIT,
        @annexbit BIT,
        @returnbit BIT,
        @paymentbit BIT,
        @deletebit BIT
    DECLARE @paymenttype TINYINT
    DECLARE @itemguid UNIQUEIDENTIFIER
    DECLARE @money BIGINT
    DECLARE @emptyguid UNIQUEIDENTIFIER
    SET @emptyguid = '00000000-0000-0000-0000-000000000000'
    DECLARE @fromguid UNIQUEIDENTIFIER
    DECLARE @toguid UNIQUEIDENTIFIER
    DECLARE @mailtitle NVARCHAR(50)
    DECLARE @limittime DATETIME
    DECLARE @returnmailstate TINYINT
    DECLARE @mailindex BIGINT

    SET @returnmailstate = 0
-- @mailstate code
-- 1 : �б�
-- 2 : ����
-- 3 : �ݼ�
-- ���� �� ���۽ÿ��� �������� ���������� ��� �� �� ����. �ٸ� ���� ���ο��� ���ÿ� �����ؾ���
-- 4 : ������ ����
-- 5 : ��� ����

    SELECT  @itemguid = ISNULL(itemguid, @emptyguid),
            @money = [money],
            @paymenttype = paymenttype,
            @fromguid = fromguid,
            @toguid = toguid,
            @mailtitle = title,
            @limittime = limittime,
            @readbit = readbit,
            @annexbit = annexbit,
            @returnbit = returnbit,
            @paymentbit = paymentbit,
            @mailindex = mailindex
    FROM    dbo.tb_usermail
    WHERE   mailguid = @mailguid

    IF @@rowcount <= 0 
        BEGIN 
            SET @errVal = 9
            GOTO __error_proc
        END

    IF @charguid <> @toguid 
        BEGIN
            SET @errVal = 4
            GOTO __error_proc
        END

    IF @mailstate = 4
        OR @mailstate = 2 
        SET @deletebit = 1
    ELSE 
        SET @deletebit = 0

    SET @returnmailstate = ( @readbit * 1 ) | ( @deletebit * 2 )
        | ( @returnbit * 4 ) | ( @annexbit * 8 ) | ( @paymentbit * 16 )
        | @mailstate

-- �̹� ���� �߰ų� �������� ���� ������ ���� �� �� ����.
    IF ( @annexbit = 1 )
        OR ( @itemguid = @emptyguid
             AND @money = 0
           ) 
        BEGIN
            SET @errVal = 3
            GOTO __error_proc
        END

    IF @readbit = 0 
        BEGIN
            SET @limittime = DATEADD(hh,3*24+1, GETDATE())
        END

    SET @returnmailstate = @returnmailstate | 1		-- read bit �߰�

    IF @paymentbit = 0 -- ��� û�� ������ �ƴϴ�.
        BEGIN
            SET @errVal = 6
            GOTO __error_proc
        END

    SET @returnmailstate = @returnmailstate & ~16	-- payment bit ����
    SET @mailstate = @mailstate | 16				-- �̰� ���� �ߴٴ� ó���� �ϱ� ���Ѱ�

    UPDATE  dbo.tb_usermail
    SET     fromguid = toguid,
            ReadBit = 1,
            AnnexBit = 1,
            PaymentBit = 0,
            limittime = @limittime
    WHERE   mailguid = @mailguid

    IF @@error <> 0 
        BEGIN
            SET @errVal = 6
            GOTO __error_proc
        END

    DECLARE @toname NVARCHAR(20)
    SELECT  @toname = name
    FROM    dbo.TB_CharacterBasic
    WHERE   characterid = @toguid

-- ����� ���� �ϸ� ��� ������������ ������ �߼��Ѵ�.
-- �߼۽� ������ ������ ���̵� �����ؼ� �ݼ۵��� ���ϰ� �Ѵ�.
    SET @mailguid = NEWID()
    INSERT  INTO dbo.tb_usermail
            (
              mailguid,
              fromguid,
              toguid,
              title,
              note,
              paymenttype,
              [money],
              ReadBit,
              AnnexBit,
              ReturnBit,
              PaymentBit
            )
    VALUES  (
              @mailguid,
              @fromguid,
              @fromguid,
              @mailtitle,
              N'',
              0,
              @money,
              0,
              0,
              0,
              0
            )

    SET nocount OFF
    SELECT  @errVal,
            @mailindex,
            @returnmailstate,
            @limittime,
            @mailstate,
            @fromguid,
            @mailguid

    RETURN

    __error_proc: -- �Ϲ� ���� 

    SELECT  @errVal
    RETURN

END



GO