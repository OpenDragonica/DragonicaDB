USE [DR2_Def]
GO
/****** Object:  StoredProcedure [dbo].[up_LoadDefSkillSet]    Script Date: 02/08/2010 23:28:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_LoadDefSkillSet]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[up_LoadDefSkillSet]
END
GO

CREATE Proc [dbo].[up_LoadDefSkillSet]
AS
BEGIN
	SELECT [SetNo]
		  ,[Limit]
		  ,[ConditionType]
		  ,[ConditionValue]
		  ,[ResNo]
	  FROM [dbo].[TB_DefSkillSet] WITH(NOLOCK)
END
