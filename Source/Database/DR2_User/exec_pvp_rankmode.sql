-- !!!!!!! TB_UserCharacter_Extern �� ���� ���� �ؾ��մϴ�.

USE [DR2_User]
GO

SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
SET XACT_ABORT ON
GO

-- �ߺ����� ���� �ʰ� �˻�
IF EXISTS ( SELECT 1 FROM [dbo].[TB_UserCharacter_Extern] WHERE [PvP_Win_Exercise] > 0 OR [PvP_Draw_Exercise] > 0 OR [PvP_Lose_Exercise] > 0 ) 
BEGIN
	PRINT N'Can not UPDATE'
END
ELSE
BEGIN
	BEGIN TRANSACTION
	
	-- 1. ���� PvP ������ _Exercise �������� �̵�
	PRINT N'UPDATE [PvP_Win_Exercise], [PvP_Draw_Exercise], [PvP_Lose_Exercise] INTO [TB_UserCharacter_Extern]'

	UPDATE [dbo].[TB_UserCharacter_Extern]
	SET [PvP_Win_Exercise] = [PvP_Win]
	,	[PvP_Draw_Exercise] = [PvP_Draw]
	,	[PvP_Lose_Exercise] = [PvP_Lose]

	IF @@ERROR = 0
	BEGIN
		-- 2. ��� �ʱ�ȭ
		PRINT N'Initialize PvP Records!!'
		
		UPDATE [dbo].[TB_UserCharacter_Extern]
		SET	[PvP_Win] = 0
		,	[PvP_Draw] = 0
		,	[PvP_Lose] = 0
		,	[PvP_Point] = 0
		,	[PvP_Kill] = 0
		,	[PvP_Death] = 0
				
		IF @@ERROR = 0
		BEGIN
			COMMIT TRANSACTION
			RETURN
		END
	END
	ROLLBACK TRANSACTION
END

