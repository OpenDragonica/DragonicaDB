USE [DR2_Def]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_LoadDefCountControl]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[up_LoadDefCountControl]
END
GO

/****** Object:  StoredProcedure [dbo].[up_LoadDefCountControl]    Script Date: 06/03/2010 17:43:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[up_LoadDefCountControl]
AS

begin
	SELECT [f_NationCodeStr], [No]	, [Count01], [Count02], [Count03], [Count04], [Count05],
		[Count06], [Count07], [Count08], [Count09], [Count10]
		FROM TB_DefCountControl with(nolock)
end

