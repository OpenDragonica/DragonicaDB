USE [DR2_Member]
GO
/****** Object:  StoredProcedure [dbo].[UP_SelectMemberAuthData_NC]    Script Date: 06/29/2009 17:43:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Object:  StoredProcedure [dbo].[UP_SelectMemberAuthData_NC]    Script Date: 06/29/2009 17:44:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UP_SelectMemberAuthData_NC]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[UP_SelectMemberAuthData_NC]
GO