USE [DR2_Def]
GO
/****** Object:  StoredProcedure [dbo].[up_LoadDefClass]    Script Date: 09/25/2009 15:22:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Object:  StoredProcedure [dbo].[up_LoadDefClass]    Script Date: 09/25/2009 15:22:54 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_LoadDefClass]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_LoadDefClass]
GO
