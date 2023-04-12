USE DR2_User

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Update_TB_UserCharacter_Basic]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[up_Update_TB_UserCharacter_Basic] 
END 

set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

CREATE PROC [dbo].[up_Update_TB_UserCharacter_Basic] 
/*
////////////////////////////////////////////////////////////////////////
//
// ���ν�����: DR2_User.dbo.up_Update_TB_UserCharacter_Basic
// �ۼ���: ����
// �ۼ���: 2009-03-09
// ����������:
// ������: 
// ���ϸ�: 
// N O T E : ĳ�����̺����ش��÷����������Ѵ�.
//
*/
	@CharacterID uniqueidentifier,
	@ValueType nvarchar(20),
	@Value INT
AS
SET NOCOUNT ON
SET LOCK_TIMEOUT 5000
SET XACT_ABORT ON	

DECLARE @SQL nvarchar(1000)
DECLARE @SQL_Params nvarchar(100)

SET @SQL = N'UPDATE dbo.TB_CharacterBasic Set ' + @ValueType + ' = @Value Where CharacterID = @CharacterID'
SET @SQL_Params = N'@Value int, @CharacterID uniqueidentifier'                         

EXEC sp_executesql @SQL, @SQL_Params, @Value, @CharacterID

GO




