USE [DR2_User]
GO
/****** Object:  StoredProcedure [dbo].[up_InitializeStractgyFatigability]    Script Date: 07/29/2011 14:33:52 ******/

/*
////////////////////////////////////////////////////////////////////////
//
// ���ν����� : [up_InitializeStractgyFatigability]
// �� �� �� : ������
// �� �� �� : 2011-07-29
// ���������� : 
// �� �� �� : 
// �� �� �� : ������
// N O T E : 
////////////////////////////////////////////////////////////////////////
*/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_InitializeStractgyFatigability]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_InitializeStractgyFatigability]

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[up_InitializeStractgyFatigability]
(
	@InitValue int
)
AS 
Set NOCOUNT ON
SET XACT_ABORT ON

DECLARE @Err int
Set @Err = 0

BEGIN
	DECLARE @StractgyFatigability int
	Set @StractgyFatigability = @InitValue
	
	BEGIN
		UPDATE	[dbo].[TB_CharacterSub]
		SET		[Strategyfatigability] = @StractgyFatigability
	END
END
RETURN @Err