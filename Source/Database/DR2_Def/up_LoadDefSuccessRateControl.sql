USE [DR2_Def]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_LoadDefSuccessRateControl]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[up_LoadDefSuccessRateControl]
END

/****** Object:  StoredProcedure [dbo].[up_LoadDefSuccessRateControl]    Script Date: 06/03/2010 17:36:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[up_LoadDefSuccessRateControl]
AS

begin
	SELECT [f_NationCodeStr], [No], [Rate01], [Rate02], [Rate03], [Rate04], [Rate05],
		[Rate06], [Rate07], [Rate08], [Rate09], [Rate10]
		FROM [dbo].[TB_DefSuccessRateControl] WITH(NOLOCK)
end





