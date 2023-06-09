USE [DR2_Def]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_LoadDefClassPetItemOption]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_LoadDefClassPetItemOption]
GO

CREATE PROCEDURE [dbo].[up_LoadDefClassPetItemOption]
/*
////////////////////////////////////////////////////////////////////////
//
// 프로시져명: [dbo].[up_LoadDefClassPetItemOption]
// 작성자: YonMy(yonmy@barunsoninter.com)
// 작성일: 2009-09-07
// 파일명: 
////////////////////////////////////////////////////////////////////////
*/ 
AS
SET Nocount On;

BEGIN
	SELECT	[ID]
		,	[Level]
		,	[OptionType01]
		,	[OptionLv01]
		,	[OptionType02]
		,	[OptionLv02]
		,	[OptionType03]
		,	[OptionLv03]
		,	[OptionType04]
		,	[OptionLv04]
	FROM [dbo].[TB_DefClassPetItemOption] WITH(NOLOCK)
END
