USE [DR2_User]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_DeleteEmporiaFunction]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_DeleteEmporiaFunction]
GO

CREATE PROCEDURE [dbo].[up_DeleteEmporiaFunction]
/*
////////////////////////////////////////////////////////////////////////
//
// ���ν����� : �������� ��� ����
// �� �� �� : YonMy
// �� �� �� : 2009-07-01
// ���������� : 
// �� �� �� : 
// �� �� �� : YonMy
// N O T E : 
////////////////////////////////////////////////////////////////////////
*/
(
	@EmporiaID		uniqueidentifier,
	@Grade			tinyint,
	@FunctionNo		smallint
)
AS
SET XACT_ABORT ON
SET NOCOUNT ON

DECLARE @Ret int
SET @Ret = 0

BEGIN
	
	DELETE [dbo].[TB_Emporia_Function]
	WHERE	[EmporiaID] = @EmporiaID AND [Grade] = @Grade AND [FunctionNo] = @FunctionNo 
	
END

RETURN @Ret
GO