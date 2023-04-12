USE DR2_USER
GO
/****** ��ü:  StoredProcedure [dbo].[up_Post_ReadMail]    ��ũ��Ʈ ��¥: 07/17/2009 11:24:31 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Post_ReadMail]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_Post_ReadMail]
GO
/****** ��ü:  StoredProcedure [dbo].[up_Post_ReadMail]    ��ũ��Ʈ ��¥: 07/17/2009 11:24:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Post_ReadMail]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[up_Post_ReadMail]

@mailguid uniqueidentifier,
@mailstate tinyint,
@charguid uniqueidentifier

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	declare @errVal int
	set @errVal = 0
	declare @readbit bit,@annexbit bit,@returnbit bit,@paymentbit bit,@deletebit bit
	declare @paymenttype tinyint
	declare @itemguid uniqueidentifier
	declare @money bigint
	declare @emptyguid uniqueidentifier
	set @emptyguid = ''00000000-0000-0000-0000-000000000000''
	declare @fromguid uniqueidentifier
	declare @toguid uniqueidentifier
	declare @mailtitle nvarchar(50)
	declare @limittime datetime
	declare @returnmailstate tinyint
	declare @mailindex bigint

	set @returnmailstate = 0
	-- @mailstate code
	-- 1 : �б�
	-- 2 : ����
	-- 3 : �ݼ�
	-- ���� �� ���۽ÿ��� �������� ���������� ��� �� �� ����. �ٸ� ���� ���ο��� ���ÿ� �����ؾ���
	-- 4 : ������ ����
	-- 5 : ��� ����

	select	@itemguid = isnull(itemguid,@emptyguid),
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
	from dbo.tb_usermail 
	where mailguid = @mailguid

	if @@rowcount <= 0
	begin 
		set @errVal = 9
		goto __error_proc
	end

	if @charguid <> @toguid
	begin
		set @errVal = 4
		goto __error_proc
	end

	if @mailstate = 4 or @mailstate = 2
		set @deletebit = 1
	else
		set @deletebit = 0

	set @returnmailstate = (@readbit * 1) | (@deletebit * 2) | (@returnbit * 4) | (@annexbit * 8) | (@paymentbit * 16) | @mailstate

	if @readbit <> 0 
	begin
		set @errVal = 1
		goto __error_proc
	end

	set @limittime = dateadd(hh,3*24+1,getdate())
	update dbo.tb_usermail set ReadBit = 1,limittime = @limittime where mailguid = @mailguid

	set nocount off
	select @errVal,@mailindex,@returnmailstate,@limittime,@mailstate,@fromguid,@mailguid

	RETURN 0

__error_proc: -- �Ϲ� ���� 

	select @errVal

END'
END
GO