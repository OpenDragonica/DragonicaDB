USE [DR2_Def]
GO
/****** Object:  StoredProcedure [dbo].[up_LoadDefRes]    Script Date: 04/01/2010 13:13:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UP_LoadDefResConvert]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[UP_LoadDefResConvert]
GO

CREATE PROC [dbo].[UP_LoadDefResConvert]
AS

begin
	select ItemNo, NationCode, ConvertResNo from [dbo].TB_DefItemResConvert
end
GO

