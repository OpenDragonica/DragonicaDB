USE [DR2_User]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Post_Create_GuildMail]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_Post_Create_GuildMail]
GO

CREATE PROCEDURE [dbo].[up_Post_Create_GuildMail]
/*
////////////////////////////////////////////////////////////////////////
//
// 프로시져명 : 길드원들에게 메일 발송
// 작 성 자 : YonMy(yonmy@barunsoninter.com)
// 작 성 일 : 2008-06-12
// 최종수정자 :
// 수 정 일 : 
// 파 일 명 : 
// N O T E : 
////////////////////////////////////////////////////////////////////////
*/
(
	@ToGuild			UNIQUEIDENTIFIER,	-- To Guild
	@MemberGrade		TINYINT,
	@FromName			NVARCHAR(20),		--메시지 발신자 이름
	@Title				NVARCHAR(40),		--메일 타이틀
	@Text				NVARCHAR(200)		--메일 본문
)
AS
SET NOCOUNT ON
SET Xact_Abort ON

DECLARE @Ret INT
SET @Ret = 1

BEGIN

DECLARE @NowDate DATETIME
SET @NowDate = GETDATE()

INSERT INTO [dbo].[TB_UserMail]
	SELECT
		NEWID()
	,	[CharacterGuid]
	,	[CharacterGuid]
	,	@Title
	,	@Text
	,	0
	,	'00000000-0000-0000-0000-000000000000'
	,	0
	,	@NowDate
	,	DATEADD(DAY, 30, @NowDate)
	,	0
	,	0
	,	0
	,	0
	,	@FromName
	FROM	[dbo].[TB_Guild_Member]
	WHERE	[GuildGuid] = @ToGuild
		AND	[MemberLevel] <= @MemberGrade

END
		
RETURN @Ret
