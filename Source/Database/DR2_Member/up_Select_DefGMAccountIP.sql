USE [DR2_Member]
GO
/****** Object:  StoredProcedure [dbo].[up_Select_DefGMAccountIP]    Script Date: 12/23/2009 13:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Object:  StoredProcedure [dbo].[up_Select_DefGMAccountIP]    Script Date: 12/23/2009 13:37:11 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Select_DefGMAccountIP]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_Select_DefGMAccountIP]
GO

CREATE PROCEDURE [dbo].[up_Select_DefGMAccountIP]
/*
////////////////////////////////////////////////////////////////////////
//
// 프로시져명 : GM 계정의 접속가능 IP를 가지고 온다.
// 작 성 자 :
// 작 성 일 : 
// 최종수정자 : YonMy
// 수 정 일 : 2009-02-13
// 담 당 자 : 
// N O T E : 
//	2009-12-23 : Eric Kim, @ID Length(20->50)
////////////////////////////////////////////////////////////////////////
*/
(
	@ID	nvarchar(50)
)
AS
SET NOCOUNT ON
BEGIN

	SELECT	[IP]
		,	[SubNetMask]
		,	[GMLevel]
	FROM	[dbo].[TB_DefGMAccountLinkIP]
	WHERE	[ID] = @ID
	
END
