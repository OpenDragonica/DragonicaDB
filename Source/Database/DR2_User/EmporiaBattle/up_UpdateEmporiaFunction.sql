USE [DR2_User]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_UpdateEmporiaFunction]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_UpdateEmporiaFunction]
GO

CREATE PROCEDURE [dbo].[up_UpdateEmporiaFunction]
/*
////////////////////////////////////////////////////////////////////////
//
// ���ν����� : �������� ��� ������Ʈ
// �� �� �� : YonMy
// �� �� �� : 2009-07-06
// ���������� : 
// �� �� �� : 
// �� �� �� : YonMy
// N O T E : 
////////////////////////////////////////////////////////////////////////
*/
(
	@EmporiaID		uniqueidentifier,
	@Grade			tinyint,
	@FunctionNo		smallint,
	@ExtValue		bigint
)
AS
SET XACT_ABORT ON
SET NOCOUNT ON

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

DECLARE @Ret int
SET @Ret = 0

BEGIN
	
	UPDATE	[dbo].[TB_Emporia_Function]
	SET		[ExtValue] = @ExtValue
	WHERE	[EmporiaID] = @EmporiaID AND [Grade] = @Grade AND [FunctionNo] = @FunctionNo

END
RETURN @Ret
GO