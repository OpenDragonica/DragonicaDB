USE [DR2_Log]
GO
/****** Object:  StoredProcedure [dbo].[UP_Log_Write2]    Script Date: 06/26/2009 22:21:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Object:  StoredProcedure [dbo].[UP_Log_Write2]    Script Date: 06/26/2009 22:21:43 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UP_Log_Write2]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[UP_Log_Write2]
GO

/****** Object:  StoredProcedure [dbo].[UP_Log_Write]    Script Date: 06/26/2009 22:21:43 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UP_Log_Write]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[UP_Log_Write]
GO

