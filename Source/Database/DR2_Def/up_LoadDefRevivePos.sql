USE [DR2_Def]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_LoadDefRevivePos]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_LoadDefRevivePos]
GO
