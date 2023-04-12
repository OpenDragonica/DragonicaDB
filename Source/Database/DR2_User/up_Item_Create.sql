USE DR2_USER
GO
/****** ��ü:  StoredProcedure [dbo].[up_Item_Create]    ��ũ��Ʈ ��¥: 07/17/2009 11:24:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Item_Create]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_Item_Create]
GO

/****** ��ü:  StoredProcedure [dbo].[up_Item_Create]    ��ũ��Ʈ ��¥: 07/17/2009 11:24:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Item_Create]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[up_Item_Create]
/*
////////////////////////////////////////////////////////////////////////
//
// ���ν����� : ������ ���μ���
// �� �� �� : ����
// �� �� �� : 2008-10-20
// ���������� : ����
// �� �� �� : 2008-12-05
// ������ : ���� 
// ������ ���� ������ update �������� delete + create �������� �ٲ�鼭 ������ ����
// �ð��� �Ź� ���� ���ŵǾ� �Ⱓ�� �������� ���� ���� ���� �ʾ���
// N O T E : 
//
////////////////////////////////////////////////////////////////////////
*/ 
	@ItemGuid	uniqueidentifier=null,
	@OwnerGuid	uniqueidentifier = null,
	@InvType tinyint = null,
	@InvPos tinyint = null,
	@ItemNo int = null,
	@Count smallint = null,
	@Enchant1 bigint = null,
	@Enchant2 bigint = null,
	@Enchant3 bigint = null,
	@Enchant4 bigint = null,
	@State tinyint = null,
	@GenDate datetime = null
as
Set Nocount on
Set Xact_Abort On

BEGIN TRAN

	insert dbo.TB_UserItem	([ItemGuid],	[OwnerGuid]	,	[InvType]	,	[InvPos]	,	[ItemNo]	,	[Count]	,	[State]	,	[CreateDate]		)
	values	(@ItemGuid,	@OwnerGuid,	@InvType,	@InvPos,	@ItemNo,	@Count,	@State,	isnull(@GenDate,GetDate())	)

	IF @@ERROR <> 0
	BEGIN
		GOTO __ERROR
	END

	IF ISNULL(@Enchant1, 0) <> 0 OR ISNULL(@Enchant2, 0) <> 0 OR ISNULL(@Enchant3, 0) <> 0 OR ISNULL(@Enchant4, 0) <> 0
	BEGIN
		INSERT INTO [dbo].[TB_UserItem_Enchant]
				   ([ItemGuid]
				   ,[Enchant_01]
				   ,[Enchant_02]
				   ,[Enchant_03]
				   ,[Enchant_04])
			 VALUES
				   (@ItemGuid
				   ,ISNULL(@Enchant1, 0)
				   ,ISNULL(@Enchant2, 0)
				   ,ISNULL(@Enchant3, 0)
				   ,ISNULL(@Enchant4, 0))

		IF @@ERROR <> 0
		BEGIN
			GOTO __ERROR
		END
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
