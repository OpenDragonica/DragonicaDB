USE [DR2_Def]
GO
/****** Object:  Table [dbo].[TB_DefMonsterAbilTunning]    Script Date: 11/12/2009 16:42:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TB_DefMonsterAbilTunning]') AND type in (N'U'))
BEGIN
	DROP TABLE [dbo].[TB_DefMonsterAbilTunning]
END
GO
