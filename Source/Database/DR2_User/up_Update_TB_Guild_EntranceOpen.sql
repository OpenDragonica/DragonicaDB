USE DR2_User
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Update_TB_Guild_EntranceOpen]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_Update_TB_Guild_EntranceOpen]

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		�赿ȯ
-- Create date: 2010.04.21
-- Description:	��尡�� ���� ���� DB�� ����
-- =============================================
CREATE PROCEDURE [dbo].[up_Update_TB_Guild_EntranceOpen]	
	@GuildGuid uniqueidentifier,
	@IsGuildEntrance tinyint,
	@GuildEntranceLevel smallint,
	@GuildEntranceClass bigint,
	@GuildEntranceFee bigint,
	@GuildPR nvarchar(20)	
AS
BEGIN	
	SET NOCOUNT ON;
	
	-- �ֱ� 3�������� ����� �¼��� �־��ش�.(up_Load_Entrance_OpenGuild ���� �� ���� DESC ������ SELECT �ؼ� ������ ���)
	DECLARE @EmporiaWinCount INT
	SELECT @EmporiaWinCount = (SELECT COUNT(*) FROM dbo.TB_Emporia_Tournament WITH(NOLOCK)
	WHERE [WinGuildID] = @GuildGuid AND [BattleDate] > DATEADD(m,-3,GETDATE()))
	
	IF NOT EXISTS (SELECT 1 FROM dbo.TB_Guild_EntranceOpen WHERE GuildGuid = @GuildGuid)
	BEGIN
		INSERT INTO dbo.TB_Guild_EntranceOpen
		(
			[GuildGuid], [EmporiaWinCount], [IsGuildEntrance], [GuildEntranceLevel], [GuildEntranceClass], [GuildEntranceFee], [GuildPR]
		)
		VALUES
		(
			@GuildGuid, @EmporiaWinCount, @IsGuildEntrance, @GuildEntranceLevel, @GuildEntranceClass, @GuildEntranceFee, @GuildPR
		)
	END
	ELSE
	BEGIN
		UPDATE dbo.TB_Guild_EntranceOpen
		SET
			[EmporiaWinCount] = @EmporiaWinCount,
			[IsGuildEntrance] = @IsGuildEntrance,
			[GuildEntranceLevel] = @GuildEntranceLevel,
			[GuildEntranceClass] = @GuildEntranceClass,
			[GuildEntranceFee] = @GuildEntranceFee,
			[GuildPR] = @GuildPR
		WHERE [GuildGuid] = @GuildGuid
	END	
END
GO