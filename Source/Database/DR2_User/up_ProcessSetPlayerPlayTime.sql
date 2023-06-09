USE [DR2_User]
GO
/****** 개체:  StoredProcedure [dbo].[up_ProcessSetPlayerPlayTime]    스크립트 날짜: 11/13/2009 16:09:10 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_ProcessSetPlayerPlayTime]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_ProcessSetPlayerPlayTime]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[up_ProcessSetPlayerPlayTime]
(
	@CharName	nvarchar(20)
)
AS	
BEGIN
	SET NOCOUNT ON;

	SELECT [MemberID]
	FROM [dbo].[TB_CharacterBasic]
	WHERE [Name] = @CharName
END


