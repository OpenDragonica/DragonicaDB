USE [DR2_Member]
GO
/****** 개체:  StoredProcedure [dbo].[up_LoadDefPlayerPlayTime]    스크립트 날짜: 11/09/2009 16:14:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_LoadDefPlayerPlayTime]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_LoadDefPlayerPlayTime]
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROC [dbo].[up_LoadDefPlayerPlayTime]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT top 1 [IsUse],[ResetType],[ResetValue1],[ResetValue2],[ApplyUser],[PlayTime],[Flag],[LastApplyTime]
	FROM [dbo].[TB_DefPlayerPlayTime]
	WHERE [IsUse] = 1
    

	SELECT [Type],[TypeSub],[Value1],[Value2],[Value3]
	FROM [dbo].[TB_DefPlayerPlayTimeSub]  
END
