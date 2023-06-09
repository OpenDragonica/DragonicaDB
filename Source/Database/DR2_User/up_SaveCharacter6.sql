USE [DR2_User]
GO

IF EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_SaveCharacter6]') AND [TYPE] in (N'P'))
BEGIN
	DROP PROCEDURE [dbo].[up_SaveCharacter6]
END

/****** Object:  StoredProcedure [dbo].[up_SaveCharacter6]    Script Date: 10/08/2009 18:23:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
////////////////////////////////////////////////////////////////////////
// Lasst Update by : 
// Update date  : 
// Description : 
// [PARAMETER] : 
// [RETURN] : 
// [REMARK]
//	2008-12-09 : 육정범 종료 퀘스트 저장공간 늘림
//	2008-12-29 : Eric Kim, ContentsServer 의 Data만 저장하도록 수정
//	2010-03-31 : 심헌섭, 스킬전략 내용 저장
//	2010-11-22 : 조현건, 캐릭터 접속종료시각 저장
////////////////////////////////////////////////////////////////////////
*/
CREATE PROCEDURE [dbo].[up_SaveCharacter6]
(
	@CharacterID UNIQUEIDENTIFIER,		--1
	@Class TINYINT,
	@Lv SMALLINT,
	@Exp BIGINT,
	@SP SMALLINT,
	@Skills BINARY(450),
	@IngQuest BINARY(350),
	@EndQuest BINARY(130),
	@EndQuest2 BINARY(130),
	@EndQuestExt BINARY(260),
	@EndQuestExt2 BINARY(480),
	@TotalPlayTimeSec BIGINT,
	@Fran BIGINT,
	@TacticsLevel SMALLINT,
	@TacticsExp BIGINT,
	@SP_Sec SMALLINT,
	@Skills_Sec BINARY(450)
)
AS
SET NOCOUNT ON

DECLARE @iErr INT
SET @iErr = 0

	UPDATE dbo.TB_CharacterSub SET
		[Class] = @Class,
		[Lv] = @Lv,
		[Exp] = @Exp,
		[ExtraSkillPoint] = @SP,
		[Skills] = @Skills,
		[IngQuest] = @IngQuest,
		[EndQuest] = @EndQuest,
		[EndQuest2] = @EndQuest2,
		[f_EndQuestExt] = @EndQuestExt,
		[f_EndQuestExt2] = @EndQuestExt2,
		[TotalPlayTimeSec] = @TotalPlayTimeSec,
		[Fran] = @Fran,
		[ExtraSkillPoint_Sec] = @SP_Sec,
		[Skills_Sec] = @Skills_Sec,
		[f_LogOutTime] = GETDATE()
		WHERE CharacterID = @CharacterID
	
	IF @@ROWCOUNT <> 1
	BEGIN
		SET @iErr = 99
	END	

	ELSE
	BEGIN
		SET @iErr = 1
	END	

SELECT @iErr
RETURN @iErr
