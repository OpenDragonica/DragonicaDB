USE DR2_USER
GO
/****** ��ü:  StoredProcedure [dbo].[up_Auto_CashItemExtendDate_Update]    ��ũ��Ʈ ��¥: 07/17/2009 11:24:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Auto_CashItemExtendDate_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_Auto_CashItemExtendDate_Update]
GO

/****** ��ü:  StoredProcedure [dbo].[up_Auto_CashItemExtendDate_Update]    ��ũ��Ʈ ��¥: 07/17/2009 11:24:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Auto_CashItemExtendDate_Update]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		����
-- Create date: <Create Date,,>
-- Description:	�ڵ� ĳ�� ���� ������Ʈ
-- =============================================
CREATE PROCEDURE [dbo].[up_Auto_CashItemExtendDate_Update]
	@ChangeTime	int
AS
BEGIN
	SET NOCOUNT ON

	--����
	UPDATE dbo.TB_UserItem SET
		   CreateDate = ( CASE WHEN GETDATE() < DATEADD(hh, @ChangeTime, CreateDate) THEN
								GETDATE()
						ELSE
							DATEADD(hh, @ChangeTime, CreateDate)
						END )
		   WHERE ItemGuid IN (
					SELECT A.ItemGuid
					FROM dbo.TB_UserItem A LEFT JOIN dbo.TB_UserItem_Enchant B
					ON A.ItemGuid = B.ItemGuid
					WHERE ISNULL(B.Enchant_02, 0) <> 0 --ĳ�þ����۾ƴѰ�����
					AND ''1'' = SUBSTRING(dbo.udf_Web_ConvertRadix(ISNULL(B.Enchant_02, 0), 2), 32,1)  -- ���ð����Ѿ����۾ƴѰ�����
					AND ''000000000'' <> SUBSTRING(dbo.udf_Web_ConvertRadix(ISNULL(B.Enchant_02, 0), 2), 33, 9) -- �ð������ΰ�����
				 )


	
END




' 
END
GO