USE [DR2_User]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Update_Pet]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_Update_Pet]
GO

CREATE PROC [dbo].[up_Update_Pet] 
/*
////////////////////////////////////////////////////////////////////////
//
// ���ν����� : up_Update_Pet
// �� �� �� : YonMy(yonmy@barunsoninter.com)
// �� �� �� : 2009-08-21
// ���������� :
// �� �� �� : 
// �� �� �� : 
// N O T E : Pet ���̺��� �ش� �÷����� �����Ѵ�.
//
////////////////////////////////////////////////////////////////////////
*/
	@PetID uniqueidentifier,
	@ValueType NVARCHAR(20),
	@Value bigint
AS
SET NOCOUNT ON
SET XACT_ABORT ON	

DECLARE @SQL NVARCHAR(1000)
DECLARE @SQL_Params NVARCHAR(100)

SET @SQL = N'UPDATE [dbo].[TB_Pet] SET ' + @ValueType + ' = @Value WHERE [PetID] = @PetID'
SET @SQL_Params = N'@Value bigint, @PetID uniqueidentifier'                         

EXEC sp_executesql @SQL, @SQL_Params, @Value, @PetID
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Update_Pet_Name]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_Update_Pet_Name]
GO

CREATE PROC [dbo].[up_Update_Pet_Name] 
/*
////////////////////////////////////////////////////////////////////////
//
// ���ν����� : up_Update_Pet_Name
// �� �� �� : YonMy(yonmy@barunsoninter.com)
// �� �� �� : 2009-08-14
// ���������� :
// �� �� �� : 
// �� �� �� : 
// N O T E : Pet �̸��� �����Ѵ�
//
////////////////////////////////////////////////////////////////////////
*/
	@PetID uniqueidentifier,
	@Name NVARCHAR(20)
AS
SET NOCOUNT ON
SET XACT_ABORT ON	

DECLARE @Err INT
SET @Err = 0

UPDATE [dbo].[TB_Pet]
SET	[Name] = @Name
WHERE [PetID] = @PetID

RETURN @Err
GO
