USE [DR2_User]
GO
/****** Object:  StoredProcedure [dbo].[up_DeleteSkillSet]    Script Date: 02/08/2010 23:33:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_DeleteSkillSet]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[up_DeleteSkillSet]
END
GO
