USE [DR2_Def]
GO
/****** Object:  StoredProcedure [dbo].[up_LoadDefRes]    Script Date: 04/01/2010 13:13:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_LoadDefRes]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[up_LoadDefRes]
GO

CREATE PROC [dbo].[up_LoadDefRes]
AS

begin
	SELECT [ResNo], [U], [V], [UVIndex], [IconPath], [XmlPath], [AddResNo1], [AddResNo2], [AddResNo3] FROM dbo.TB_DefRes WITH(NOLOCK)
	SELECT [ResNo], [U], [V], [UVIndex], [IconPath], [XmlPath], [AddResNo1], [AddResNo2], [AddResNo3] FROM dbo.TB_DefRes_Mon WITH(NOLOCK)
	SELECT [ResNo], [U], [V], [UVIndex], [IconPath], [XmlPath], [AddResNo1], [AddResNo2], [AddResNo3] FROM dbo.TB_DefRes_Item WITH(NOLOCK)
end


