USE [DR2_User]
GO

IF EXISTS( SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[up_SELECT_Guild_Inventory_Log]') AND  [type] in ('P') )
BEGIN
	DROP PROCEDURE [dbo].[up_SELECT_Guild_Inventory_Log]
END

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
////////////////////////////////////////////////////////////////////////
// Lasst Update by : �赿ȯ
// Update date  : 2010-06-09
// Description : ���ݰ� �α� SELECT
// [PARAMETER] : 
// [RETURN] : 
// [REMARK]
////////////////////////////////////////////////////////////////////////
*/
CREATE PROCEDURE [dbo].[up_SELECT_Guild_Inventory_Log]
(	
	@GuildGuid UNIQUEIDENTIFIER
,	@Page INT
)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @TotalCount INT
	DECLARE @TotalPage INT	
	DECLARE	@StartRow INT
	DECLARE	@EndRow INT

	-- 1. �α��� �� ���� ���ϱ�
	SET @TotalCount = ( SELECT COUNT(*) FROM dbo.TB_Guild_Inventory_Log WITH(NOLOCK)
	WHERE GuildGuid = @GuildGuid )

	-- 2. �� ������ �� ���ϱ�
	IF @TotalCount % 10 = 0
	BEGIN
		SET @TotalPage = @TotalCount / 10
	END
	ELSE
	BEGIN
		SET @TotalPage = (@TotalCount / 10) + 1
	END

	-- 3. ��û�� ������ �˻�
	IF @Page < 1
	BEGIN
		SET @Page = 1
	END
	ELSE IF @Page > @TotalPage
	BEGIN 
		SET @Page = @TotalPage
	END	

	-- 4. SELECT �� row ���
	SET @StartRow = ( ( @Page - 1 ) * 10 ) + 1
	SET @EndRow = @StartRow + 10 - 1

	-- 5. TotalPage, CurPage ��ȯ
	SELECT @TotalPage, @Page;

	-- 6. �α� ��ȯ
	WITH PageOrder AS
	(
		SELECT [GuildGuid], [ItemGuid], [Date], [CharacterName], [Type], [ItemNo], [Count], ROW_NUMBER() OVER( ORDER BY Date DESC) AS RowNumber
		FROM dbo.TB_Guild_Inventory_Log WHTH(NOLOCK)
		WHERE GuildGuid = @GuildGuid
	)
	SELECT * FROM PageOrder WITH(NOLOCK)
	WHERE RowNumber BETWEEN @StartRow AND @EndRow

	SET NOCOUNT OFF;
END
GO