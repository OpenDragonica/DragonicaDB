USE [DR2_Member]
GO
/****** Object:  StoredProcedure [dbo].[up_SelectMemberID]    Script Date: 06/29/2009 21:00:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
	2009-11-19
		SP 삭제 ( Eric Kim) 
*/

/****** Object:  StoredProcedure [dbo].[up_SelectMemberID]    Script Date: 06/29/2009 21:01:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_UpdateMemberData]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_UpdateMemberData]
GO

