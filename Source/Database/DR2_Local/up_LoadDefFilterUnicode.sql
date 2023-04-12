USE [DR2_local]
GO

IF EXISTS(SELECT 1 FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[up_LoadDefFilterUnicode]'))
BEGIN
	DROP Proc [dbo].[up_LoadDefFilterUnicode]
END

/****** Object:  StoredProcedure [dbo].[up_LoadDefFilterUnicode]    Script Date: 04/16/2009 18:19:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE Proc [dbo].[up_LoadDefFilterUnicode]
AS

begin
	select [f_FuncCode], [StartRange], [EndRange],[FilterType] from dbo.TB_DefFilterUnicode with(nolock)
end


