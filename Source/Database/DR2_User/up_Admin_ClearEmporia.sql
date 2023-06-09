USE [DR2_User]
GO
/****** Object:  StoredProcedure [dbo].[up_Admin_ClearEmporia]    Script Date: 09/12/2012 14:29:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Admin_ClearEmporia]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_Admin_ClearEmporia]
GO

CREATE PROCEDURE [dbo].[up_Admin_ClearEmporia]
/*
////////////////////////////////////////////////////////////////////////
// Lasst Update by : YonMy	
// Update date  : 2010-02-20
// Description : 엠포리아 정보 초기화
// [PARAMETER] : 
// [RETURN] : 
// [REMARK]
////////////////////////////////////////////////////////////////////////
*/
	@Confirm nvarchar(20)	-- 실수 방지 하기 위한 확인 메시지
	
AS
set nocount on
SET XACT_ABORT ON

BEGIN
	IF @Confirm = 'ImSure' OR @Confirm = 'ImSurePerfect'
	BEGIN
		
		TRUNCATE TABLE [dbo].[TB_Emporia_Mercenary]
		TRUNCATE TABLE [dbo].[TB_Emporia_ChallengeBattle]
		TRUNCATE TABLE [dbo].[TB_Emporia_Function]
		TRUNCATE TABLE [dbo].[TB_Emporia_Tournament]
		TRUNCATE TABLE [dbo].[TB_Emporia]
		TRUNCATE TABLE [dbo].[TB_EmporiaPack]
		
		EXEC [up_CreateEmporia] '08d22596-2500-46be-ac82-8e50c6e9391b', 0
--		INSERT INTO [dbo].[TB_EmporiaPack]
--			([EmporiaID],[State],[BattlePeriodsForWeeks],[RegistDate])
--		VALUES
--			('08d22596-2500-46be-ac82-8e50c6e9391b',0,0,GETDATE())

	END
	ELSE
	BEGIN
		print('This procedure will delete ALL Emporia')
		print('If you are convinced that you know well what you will do and you are sure')
		print('EXEC up_Admin_ClearEmporia ImSure or ImSurePerfect')
	END
END
GO
