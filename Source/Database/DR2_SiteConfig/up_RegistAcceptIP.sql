/* 2009-07-20 R9459 ���� */
/*
		IP Block ����� ���� �Ǹ鼭 �� �̻� ������� �ʴ� ���̺� ����
		R9559 �����ε�, ���߿� ��ũ��Ʈ ���� �� ����.
*/
USE [DR2_SiteConfig]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Object:  StoredProcedure [dbo].[UP_RegistAcceptIP]    Script Date: 07/20/2009 17:54:59 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UP_RegistAcceptIP]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[UP_RegistAcceptIP]
GO

CREATE proc [dbo].[UP_RegistAcceptIP]
@StartIP nvarchar(20),
@NationKey nvarchar(50), 
@NationName nvarchar(50),
@ExpireDate datetime
as
begin
	DECLARE @count int
	select @count = count(*) from TB_IP_ForAccept
		where StartIP = @StartIP
	if @count <> 0
	begin
		delete TB_IP_ForAccept 
			where StartIP = @StartIP
	end 
	
	insert TB_IP_ForAccept(StartIP, EndIP, NationKey, NationName, [ExpireDate])
	values (@StartIP, @StartIP, @NationKey, @NationName, @ExpireDate)
end
GO