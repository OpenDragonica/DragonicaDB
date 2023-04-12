USE [DR2_User]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Check_PvPRankingSeason]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_Check_PvPRankingSeason]
GO

CREATE PROCEDURE [dbo].[up_Check_PvPRankingSeason]
/*
////////////////////////////////////////////////////////////////////////
//
// ���ν�����: [dbo].[up_Check_PvPRankingSeason]
// �ۼ���: YonMy(yonmy@barunsoninter.com)
// �ۼ���: 2009-11-26
// ���ϸ�: 
////////////////////////////////////////////////////////////////////////
*/ 
(
	@CurrentSeasonBeginDate		DATETIME,
	@season_init_point			INT,
	@cycle_pass					TINYINT,-- 0�̸� cycle_day�� �������� ������ ���ó�¥�� cycle ����, 0�̾ƴϸ�... �ֱ⸦ ����ؼ� ������ �ְ� pass~
	@cycle_day					INT,
	@cycle_PointRate			FLOAT,
	@cycle_GivePoint			INT
)
AS
SET Nocount On;

DECLARE @ret INT
SET @ret = 1

BEGIN TRAN

	DECLARE @now_date DATETIME
	SET @now_date = GETDATE()
	
	DECLARE @last_season INT
	DECLARE @last_cycle INT
	DECLARE @last_cycle_date DATETIME
	SET @last_season = 0
	
	SELECT	TOP 1
			@last_season = [Season]
		,	@last_cycle = [Cycle]
		,	@last_cycle_date = [BeginDate]
	FROM [dbo].[TB_PvP_Ranking_SeasonLog]
	WHERE [BeginDate] IS NOT NULL
	ORDER BY [Season] DESC, [Cycle] DESC

	
	IF 0 = @@ROWCOUNT OR @CurrentSeasonBeginDate > @last_cycle_date
	BEGIN
		-- ���ο� season �����
		DECLARE @new_season INT
		DECLARE @new_cycle INT
		SET @new_season = @last_season + 1
		SET @new_cycle = 1
		
		INSERT INTO [dbo].[TB_PvP_Ranking_SeasonLog]
		([Season], [Cycle], [BeginDate], [Event])
		VALUES
		(@new_season, @new_cycle, @now_date, 1)
		
		-- season�� ���� backup
		-- create backup table 
		DECLARE @TABLENAME	NVARCHAR(50)
		DECLARE @SQL	 	NVARCHAR(4000)
		
		SET @TABLENAME = N'TB_PvP_Ranking_Season_' + CONVERT(NVARCHAR(50),@last_season)
		
		SET @SQL = N'
		if not exists (select * from dbo.sysobjects where id = object_id(N''[dbo].['+@TABLENAME+']''))
		BEGIN
			CREATE TABLE [dbo].['+@TABLENAME+'] (
				[CharacterID]	[uniqueidentifier],
				[Point]			[int],
				[Win]			[int],
				[Draw]			[int],
				[Lose]			[int],
				[Kill]			[bigint],
				[Death]			[bigint]
				CONSTRAINT [IX_UC_'+@TABLENAME+'] UNIQUE CLUSTERED 
				(
					[CharacterID] ASC
				)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
			) ON [PRIMARY]
		END
		'
		EXEC sp_executesql @SQL
		
		SET @SQL = N'INSERT INTO dbo.'+@TABLENAME+'([CharacterID], [Point], [Win], [Draw], [Lose], [Kill], [Death])
		SELECT DISTINCT [CharacterID], [PvP_Point], [PvP_Win], [PvP_Draw], [PvP_Lose], [PvP_Kill], [PvP_Death] FROM [dbo].[TB_UserCharacter_Extern]'
		EXEC sp_executesql @SQL

		IF @@ERROR <> 0
		BEGIN
			GOTO _ERROR;
		END

		-- player database ���� �ʱ�ȭ..
		UPDATE [dbo].[TB_UserCharacter_Extern]
		SET [PvP_Point] = @season_init_point
		
		IF @@ERROR <> 0
		BEGIN
			GOTO _ERROR;
		END
		
		SET @ret = 2	-- new season
		
	END
	ELSE
	BEGIN
		-- ���ο� cycle�� ���۵Ǵ��� Ȯ��
		IF 0 < @cycle_day
		BEGIN
		
			DECLARE @today datetime
			SET @today = CONVERT( char(10), @now_date, 120 )
		
			DECLARE @chk_date datetime
			SET @chk_date = CONVERT( char(10), @last_cycle_date, 120 )
		
			DECLARE @days int
			SET @days = DATEDIFF( dd, @chk_date, @today )
			IF @cycle_day <= @days
			BEGIN
				-- ���ο� cycle�� ���۵Ǿ�� �Ѵ�.
			
				IF 0 = @cycle_pass
				BEGIN
					-- 0�ΰ�� ���ο� ����Ŭ�� ������ �����ϴ³��� ������ �ȴ�.
					INSERT INTO [dbo].[TB_PvP_Ranking_SeasonLog]
					([Season], [Cycle], [BeginDate], [Event])
					VALUES
					(@last_season, @last_cycle+1, @now_date, 1)
				
					IF @@ERROR <> 0
					BEGIN
						GOTO _ERROR;
					END
				
					UPDATE [dbo].[TB_UserCharacter_Extern]
					SET [PvP_Point] = ([PvP_Point] * @cycle_PointRate) + @cycle_GivePoint
				END
				ELSE
				BEGIN
					-- ������ ���� ������ �ݿ��� ���־�� �Ѵ�.
					WHILE @days >= @cycle_day
					BEGIN
						SET @last_cycle = @last_cycle + 1
					
						INSERT INTO [dbo].[TB_PvP_Ranking_SeasonLog]
						([Season], [Cycle], [BeginDate], [Event])
						VALUES
						(@last_season, @last_cycle, @now_date, 0)
					
						UPDATE [dbo].[TB_UserCharacter_Extern]
						SET [PvP_Point] = ([PvP_Point] * @cycle_PointRate) + @cycle_GivePoint
					
						SET @days = @days - @cycle_day
					END
				
					IF @@ERROR <> 0
					BEGIN
						GOTO _ERROR;
					END
				
					UPDATE [dbo].[TB_PvP_Ranking_SeasonLog]
					SET [Event] = 1
					WHERE [Season] = @last_season AND [Cycle] = @last_cycle
				
				END
			
				SET @ret = 3 -- new cycle
			END
		END
	END

COMMIT TRAN
SELECT @ret
RETURN 0

_ERROR:
ROLLBACK TRAN
SET @ret = 0
SELECT @ret
RETURN 0

GO