USE [DR2_User]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Record_LevelUp_PlayTimeSec]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[up_Record_LevelUp_PlayTimeSec]
END
GO




























