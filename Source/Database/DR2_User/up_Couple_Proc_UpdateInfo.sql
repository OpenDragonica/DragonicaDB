USE [DR2_User]
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

/****** Object:  StoredProcedure [dbo].[up_Couple_Proc_UpdateInfo]    Script Date: 07/10/2009 15:23:52 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Couple_Proc_UpdateInfo]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[up_Couple_Proc_UpdateInfo]
END
GO

/*
////////////////////////////////////////////////////////////////////////
//
// ���ν����� : up_Couple_Proc_UpdateInfo
// �� �� �� : �� �� ��
// �� �� �� : 2009-7-10
// ���������� : 
// �� �� �� : 
// �� �� �� : 
// N O T E : ���̺��� �ش� �÷����� �����Ѵ�.
//
////////////////////////////////////////////////////////////////////////
*/

CREATE PROC [dbo].[up_Couple_Proc_UpdateInfo] 
	@CharacterID uniqueidentifier,
	@ValueType nvarchar(20),
	@Value int
AS
SET NOCOUNT ON
SET XACT_ABORT ON	

DECLARE @SQL nvarchar(1000)
DECLARE @SQL_Params nvarchar(100)

SET @SQL = N'UPDATE [dbo].[TB_UserCouple] Set ' + @ValueType + ' = @Value Where CharacterGuid = @CharacterID'
SET @SQL_Params = N'@Value int, @CharacterID uniqueidentifier'                         

EXEC sp_executesql @SQL, @SQL_Params, @Value, @CharacterID
GO
