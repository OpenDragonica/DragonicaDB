USE DR2_USER
GO

/****** ��ü:  StoredProcedure [dbo].[up_Select_Scene_Exterior]    ��ũ��Ʈ ��¥: 07/17/2009 11:24:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Select_Scene_Exterior]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_Select_Scene_Exterior]
GO

/****** ��ü:  StoredProcedure [dbo].[up_Select_Scene_Exterior]    ��ũ��Ʈ ��¥: 07/17/2009 11:24:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Select_Scene_Exterior]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[up_Select_Scene_Exterior]
	@OpString		VARCHAR(8000) = ''''
AS
SET NOCOUNT ON	
SET XACT_ABORT ON

BEGIN

	--Option Depth 1�߰�
	DECLARE @I INT
	DECLARE @CHECKED_COUNT INT
	DECLARE @OwnerGuid UNIQUEIDENTIFIER
	
	SET @CHECKED_COUNT = LEN(@OpString) - LEN(REPLACE(@OpString,''|'',''''))	-- �ڸ��� ��ȣ�� ��� �ִ���.
	SET @CHECKED_COUNT  = @CHECKED_COUNT

--	print ''üũ����Ʈ'' ------------
--	print @CHECKED_COUNT ------------

	SET @I = 0
	WHILE @I < @CHECKED_COUNT
	BEGIN
		SET @OwnerGuid = SUBSTRING(@OpString, 1, CHARINDEX(''|'', @OpString)-1)
		SET @OpString = STUFF(@OpString, 1, CHARINDEX(''|'', @OpString), '''')
		
--		print @OwnerGuid

--		print ''����''

		SELECT A.ItemGuid, A.OwnerGuid, A.InvType, A.InvPos, A.ItemNo, A.Count, B.Enchant_01, B.Enchant_02, B.Enchant_03, B.Enchant_04, A.State, A.CreateDate 
				, ISNULL(B.Enchant_01,0) AS Enchant_01
				, ISNULL(B.Enchant_02,0) AS Enchant_02
				, ISNULL(B.Enchant_03,0) AS Enchant_03
				, ISNULL(B.Enchant_04,0) AS Enchant_04
			FROM TB_UserItem A LEFT JOIN dbo.TB_UserItem_Enchant B
			ON A.ItemGuid = B.ItemGuid
			WHERE OwnerGuid = @OwnerGuid

		SET @I = @I + 1
	END	

--��������
--	print ''���� ��''

END'
END
GO