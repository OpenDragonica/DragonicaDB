USE DR2_USER
GO

/****** ��ü:  StoredProcedure [dbo].[up_Item_Remove]    ��ũ��Ʈ ��¥: 07/17/2009 11:24:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Item_Remove]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_Item_Remove]
GO

/****** ��ü:  StoredProcedure [dbo].[up_Item_Remove]    ��ũ��Ʈ ��¥: 07/17/2009 11:24:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Item_Remove]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[up_Item_Remove]
/*
////////////////////////////////////////////////////////////////////////
//
// ���ν����� : ������ ���μ���
// �� �� �� : ����
// �� �� �� : 2007-11-23
// ���������� : ����
// �� �� �� : 2008-04-10
// �� �� �� : 
// N O T E : 
//
////////////////////////////////////////////////////////////////////////
*/ 
	@ItemGuid	uniqueidentifier=null
as
Set Nocount on
Set Xact_Abort On

BEGIN TRAN

	DELETE dbo.TB_UserItem_Enchant WHERE ItemGuid = @ItemGuid
	
	IF @@ERROR <> 0
	BEGIN
		GOTO __ERROR
	END

	DELETE dbo.TB_UserItem Where ItemGuid = @ItemGuid

	IF @@ERROR <> 0
	BEGIN
		GOTO __ERROR
	END

COMMIT TRAN

	SELECT 0
	RETURN

__ERROR:

ROLLBACK TRAN

	SELECT 1
'
END
GO