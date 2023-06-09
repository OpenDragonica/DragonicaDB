USE [DR2_Def]
GO

IF EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_LoadDefItemOptionAbil]') and [type] in (N'P'))
BEGIN
	DROP Proc [dbo].[up_LoadDefItemOptionAbil]
END

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[up_LoadDefItemOptionAbil]
AS
begin
	SELECT [f_NationCodeStr] 
		,[OptionAbilNo]
		,[f_PieceCount]
		,[f_Order]
		,[Type01],[Value01]
		,[Type02],[Value02]
		,[Type03],[Value03]
		,[Type04],[Value04]
		,[Type05],[Value05]
		,[Type06],[Value06]
		,[Type07],[Value07]
		,[Type08],[Value08]
		,[Type09],[Value09]
		,[Type10],[Value10]
	FROM [dbo].[TB_DefItemOptionAbil] WITH(NOLOCK)
end