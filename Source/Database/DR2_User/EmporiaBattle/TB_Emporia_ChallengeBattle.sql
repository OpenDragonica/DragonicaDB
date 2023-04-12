USE [DR2_User]
GO

/*
2010-05-07 심헌섭 길드운영비 추가
*/
IF EXISTS(SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'dbo.TB_Emporia_ChallengeBattle') AND [name] = N'Exp')
BEGIN
	EXECUTE sp_rename N'dbo.TB_Emporia_ChallengeBattle.Exp', N'Cost', 'COLUMN'
END
GO

IF EXISTS(SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'dbo.TB_Emporia_ChallengeBattle') AND [name] = N'Cost')
BEGIN
	EXECUTE sp_rename N'dbo.TB_Emporia_ChallengeBattle.Cost', N'Exp', 'COLUMN'
END
GO