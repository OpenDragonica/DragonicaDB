USE DR2_User
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Load_Entrance_OpenGuild]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_Load_Entrance_OpenGuild]

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		�赿ȯ
-- Create date: 2010.04.22
-- Description:	��尡�� ��û�� ����� ��� ����Ʈ
-- =============================================
CREATE PROCEDURE [dbo].[up_Load_Entrance_OpenGuild]
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT
		OpenGuild.[GuildGuid], OpenGuild.[GuildEntranceLevel], OpenGuild.[GuildEntranceClass], OpenGuild.[GuildEntranceFee], OpenGuild.[GuildPR],
		GuildInfo.[Emblem], GuildInfo.[GuildName], GuildInfo.[CurrentLevel] AS GuildLevel, CharacterInfo.[Name] AS MasterName,
		(SELECT COUNT(*) FROM dbo.TB_Guild_Member WHERE GuildGuid = OpenGuild.[GuildGuid]) AS GuildMemberCount
	FROM dbo.TB_Guild_Basic_Info AS GuildInfo
	WITH(NOLOCK)
	
	JOIN dbo.TB_CharacterBasic AS CharacterInfo ON GuildInfo.[MasterCharacterGuid] = CharacterInfo.[CharacterID]
	JOIN dbo.TB_Guild_EntranceOpen AS OpenGuild ON GuildInfo.[GuildGuid] = OpenGuild.[GuildGuid]	
	
	WHERE OpenGuild.[IsGuildEntrance] = 1
	ORDER BY OpenGuild.[EmporiaWinCount] DESC -- �ֱ�3�������� �������� �¼� ���� ������
	
	SET NOCOUNT OFF;
END
GO