USE [DR2_User]
GO
/****** Object:  StoredProcedure [dbo].[up_Guild_Proc_Info_SELECT_Basic]    Script Date: 10/26/2009 14:42:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Guild_Proc_Info_SELECT_Basic]') AND [TYPE] in ('P'))
BEGIN
	DROP PROCEDURE [dbo].[up_Guild_Proc_Info_SELECT_Basic]
END
GO
IF EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Guild_Proc_Info_SELECT_Extern]') AND [TYPE] in ('P'))
BEGIN
	DROP PROCEDURE [dbo].[up_Guild_Proc_Info_SELECT_Extern]
END
GO
IF EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Guild_Proc_Info_SELECT_Grade]') AND [TYPE] in ('P'))
BEGIN
	DROP PROCEDURE [dbo].[up_Guild_Proc_Info_SELECT_Grade]
END
GO
IF EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Guild_Proc_Info_SELECT_Member]') AND [TYPE] in ('P'))
BEGIN
	DROP PROCEDURE [dbo].[up_Guild_Proc_Info_SELECT_Member]
END
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Guild_Proc_Info_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_Guild_Proc_Info_SELECT]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/*
////////////////////////////////////////////////////////////////////////
// Description : 길드 정보 선택 프로시져
// [PARAMETER] : 
// [RETURN] : 
// [REMARK]
//	2008-10-21 : 육정범, _Basic/ _Extern/ _Member/ _Grade 로 분리
//	2008-10-07 : Eric Kim, Character DB 가 두개로 나누어 진 것 적용
//	2008-06-30 : 육정범, 생성
//	2010-04-21 : 김동환 길드가입 설정 정보 읽기
////////////////////////////////////////////////////////////////////////
*/
CREATE PROCEDURE [dbo].[up_Guild_Proc_Info_SELECT]
(
	@GuildGuid UNIQUEIDENTIFIER
)
AS
Set Nocount on
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT
		[GuildGuid],
		[MasterCharacterGuid],
		[GuildName],
		[CurrentLevel],
		[CurrentExp],
		[Emblem],
		[CreateDate],
		[TaxExpRate],
		[SkillPoint],
		[Skills],
		[CurrentMoney],
		[GuildInvExtend],
		[GuildInvExtendIdx],
		[GuildInvAuthority]
	FROM [DBO].[TB_Guild_Basic_Info] WHERE [GuildGuid] = @GuildGuid;

	SELECT
		[Notice]
	FROM [DBO].[TB_Guild_Extern_Info] WHERE  [GuildGuid] = @GuildGuid;

	SELECT
		[GuildGuid],
		[GradeGroupLevel],
		[GradeName01],
		[GradeName02],
		[GradeName03],
		[GradeName04],
		[GradeName05],
		[LastModifyDate]
	FROM [DBO].[TB_Guild_Member_Grade] WHERE [GuildGuid] = @GuildGuid;
	
	SELECT	[ClassLimit]
		,	[LevelLimit]
	FROM	[dbo].[TB_Guild_Set_Mercenary]
	WHERE	[GuildGuid] = @GuildGuid

	SELECT
		A.CharacterGuid,
		A.MemberLevel,
		C.Lv, 
		B.Name,
		C.Class,
		D.StreetNo,
		D.HouseNo
	FROM
		dbo.TB_Guild_Member A
		INNER JOIN dbo.TB_CharacterBasic B ON A.CharacterGuid = B.CharacterID
		INNER JOIN dbo.TB_CharacterSub C ON A.CharacterGuid = C.CharacterID
		LEFT JOIN dbo.TB_User_Myhome_Base D on A.CharacterGuid = D.OwnerGuid
	WHERE A.GuildGuid = @GuildGuid
	
	SELECT	[IsGuildEntrance],
			[GuildEntranceLevel],
			[GuildEntranceClass],
			[GuildEntranceFee],
			[GuildPR]
	FROM	[dbo].[TB_Guild_EntranceOpen]
	WHERE	[GuildGuid] = @GuildGuid
return
