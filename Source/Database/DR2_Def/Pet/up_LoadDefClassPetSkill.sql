USE [DR2_Def]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_LoadDefClassPetSkill]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_LoadDefClassPetSkill]
GO
