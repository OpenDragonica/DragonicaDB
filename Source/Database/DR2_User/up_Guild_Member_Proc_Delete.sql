USE [DR2_User]
GO

IF EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Guild_Member_Proc_Delete]') AND [type] in (N'P'))
BEGIN
	DROP PROCEDURE [dbo].[up_Guild_Member_Proc_Delete]
END
GO

/****** Object:  StoredProcedure [dbo].[up_Guild_Member_Proc_Delete]    Script Date: 11/04/2009 16:27:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
////////////////////////////////////////////////////////////////////////
// Lasst Update by : 육정범
// Update date  : 2008-10-21
// Description : 길드원 추가 프로시져 Step. 1
// [PARAMETER] : 
// [RETURN] : 
// [REMARK]
//	2008-10-21 : 육정범, CREATE, DELETE, MODIFY로 나눔
//	2008-10-07 : Eric Kim, Character DB 가 두개로 나누어진것 적용
//	2008-06-30 : 육정범
////////////////////////////////////////////////////////////////////////
*/
CREATE PROCEDURE [dbo].[up_Guild_Member_Proc_Delete]
(
	@CommandType tinyint,
	@GuildGuid UNIQUEIDENTIFIER,
	@CharGuid UNIQUEIDENTIFIER,
	@MemberLevel tinyint = 0
)
AS
	Set Nocount On
	DECLARE @Err int;
	SET @Err = 0;

	--5. 길드원 삭제
	--  1. Member 테이블에서 길드원 삭제
	DELETE FROM [DBO].[TB_Guild_Member] WHERE [CharacterGuid] = @CharGuid;

	DECLARE @ToDay Datetime
	SET @ToDay = GetDate()
	exec dbo.UP_UPDATE_TB_UserCharacter_DateContents @CharGuid, N'f_GuildLeaveDate', @ToDay

ErrorHandler:
	SELECT @Err, @CommandType, @GuildGuid, @CharGuid, @MemberLevel
	RETURN 
