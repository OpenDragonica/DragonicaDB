USE DR2_User
GO

/*
2009-03-10 ���� ������ Ȯ�� �߰�
*/
IF EXISTS (SELECT * FROM sys.all_objects WHERE NAME = 'DF__TB_Charac__Quick__55016A90')
BEGIN
	ALTER TABLE [dbo].[TB_CharacterSub] DROP CONSTRAINT [DF__TB_Charac__Quick__55016A90]
END

ALTER TABLE [dbo].[TB_CharacterSub] ALTER COLUMN [QuickSlot] [binary] (281) NOT NULL

ALTER TABLE [dbo].[TB_CharacterSub] ADD CONSTRAINT [DF__TB_Charac__Quick__55016A90] DEFAULT (CONVERT([binary](281),(0),(0))) FOR [QuickSlot]

GO

/*
Ȯ�� �κ��丮 ���� �߰�
*/
IF NOT EXISTS (SELECT * FROM sys.all_objects WHERE NAME = 'DF_TB_CharacterSub_InvExtend')
BEGIN
	ALTER TABLE [dbo].[TB_CharacterSub] ADD [InvExtend] [binary] (40) NOT NULL CONSTRAINT [DF_TB_CharacterSub_InvExtend] DEFAULT (CONVERT([binary](40),(0),(0)))
END

GO

/*
��õ ����Ʈ �� ��õ ����Ʈ ���� �ð� �߰�
*/
IF NOT EXISTS (SELECT * FROM sys.all_objects WHERE NAME = 'DF_TB_CharacterSub_ReflashRP')
BEGIN
	ALTER TABLE [dbo].[TB_CharacterSub] ADD  [RefreshDate] [int] NOT NULL CONSTRAINT [DF_TB_CharacterSub_ReflashRP]  DEFAULT ((0))
END
GO

IF EXISTS (SELECT * FROM sys.all_objects WHERE NAME = 'DF_TB_CharacterSub_RecommandPoint')
BEGIN
	ALTER TABLE [dbo].[TB_CharacterSub] DROP CONSTRAINT [DF_TB_CharacterSub_RecommandPoint]
	ALTER TABLE [dbo].[TB_CharacterSub] DROP COLUMN [RecommandPoint]
END
GO

IF NOT EXISTS(SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'dbo.TB_CharacterSub') AND [name] = N'RecommendPoint')
BEGIN
	ALTER TABLE [dbo].[TB_CharacterSub] ADD  [RecommendPoint] [int] NOT NULL DEFAULT(0)
END
GO

/*
	COLUMN �߰� : Effect ���� ���� �߰�
*/
IF NOT EXISTS (SELECT * FROM sys.all_objects WHERE NAME = 'DF_TB_CharacterSub_Effect')
BEGIN
	ALTER TABLE [dbo].[TB_CharacterSub] ADD  [Effect] [binary](200) NOT NULL CONSTRAINT [DF_TB_CharacterSub_Effect] DEFAULT ((0))
END
GO

/*
	�̸�Ƽ��, �̸��, ǳ�� �̸�Ƽ�� ĳ�� ���� ���� ����
*/
IF NOT EXISTS(SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'dbo.TB_CharacterSub') AND [name] = N'Emoticon')
BEGIN
	ALTER TABLE [dbo].[TB_CharacterSub] ADD [Emoticon] [binary] (20) NOT NULL CONSTRAINT [DF_TB_CharacterSub_Emoticon] DEFAULT ((0))
END
IF NOT EXISTS(SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'dbo.TB_CharacterSub') AND [name] = N'Emotion')
BEGIN
	ALTER TABLE [dbo].[TB_CharacterSub] ADD [Emotion] [binary] (20) NOT NULL CONSTRAINT [DF_TB_CharacterSub_Emotion] DEFAULT ((0))
END
IF NOT EXISTS(SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'dbo.TB_CharacterSub') AND [name] = N'Balloon')
BEGIN
	ALTER TABLE [dbo].[TB_CharacterSub] ADD [Balloon] [binary] (20) NOT NULL CONSTRAINT [DF_TB_CharacterSub_Balloon] DEFAULT ((0))
END
GO

/*
Ȯ�� �κ��丮 ���� �߰�
*/
IF NOT EXISTS(SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'dbo.TB_CharacterSub') AND [name] = N'ExtendIdx')
BEGIN
	ALTER TABLE [dbo].[TB_CharacterSub] ADD [ExtendIdx] [binary] (40) NOT NULL DEFAULT (CONVERT([binary](40),(0),(0)))
END
GO

/*
	by Eric Kim (2009.09.28)
	Active Status �۾�
*/
USE [DR2_User]
GO
IF NOT EXISTS(SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'dbo.TB_CharacterSub') AND [name] = N'BonusStatus')
BEGIN
	ALTER TABLE [dbo].[TB_CharacterSub] ADD [BonusStatus] [smallint] NOT NULL CONSTRAINT [DF_TB_CharacterSub_BonusStatus] DEFAULT ((0))
END
IF NOT EXISTS(SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'dbo.TB_CharacterSub') AND [name] = N'AddedSTR')
BEGIN
	ALTER TABLE [dbo].[TB_CharacterSub] ADD [AddedSTR] [smallint] NOT NULL CONSTRAINT [DF_TB_CharacterSub_AddedSTR] DEFAULT ((0))
END
IF NOT EXISTS(SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'dbo.TB_CharacterSub') AND [name] = N'AddedINT')
BEGIN
	ALTER TABLE [dbo].[TB_CharacterSub] ADD [AddedINT] [smallint] NOT NULL CONSTRAINT [DF_TB_CharacterSub_AddedINT] DEFAULT ((0))
END
IF NOT EXISTS(SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'dbo.TB_CharacterSub') AND [name] = N'AddedDEX')
BEGIN
	ALTER TABLE [dbo].[TB_CharacterSub] ADD [AddedDEX] [smallint] NOT NULL CONSTRAINT [DF_TB_CharacterSub_AddedDEX] DEFAULT ((0))
END
IF NOT EXISTS(SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'dbo.TB_CharacterSub') AND [name] = N'AddedCON')
BEGIN
	ALTER TABLE [dbo].[TB_CharacterSub] ADD [AddedCON] [smallint] NOT NULL CONSTRAINT [DF_TB_CharacterSub_AddedCON] DEFAULT ((0))
END
GO
-- Lv 61 �̻� ĳ������ BonusStatus �� ����
UPDATE [dbo].[TB_CharacterSub]
	SET [BonusStatus] = ([Lv]-60)*5, AddedSTR = 0, AddedINT = 0, AddedDEX = 0, AddedCON = 0
	WHERE [Lv] > 60 AND [BonusStatus] = 0 AND AddedSTR = 0 AND AddedINT = 0 AND AddedDEX = 0 AND AddedCON = 0


/*
	ĳ���� ���� ����Ʈ ���� �ʵ� Ȯ��
*/
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID('DF__TB_Charac__IngQu__55F58EC9') AND [Type] in (N'D'))
BEGIN
	ALTER TABLE [dbo].[TB_CharacterSub] DROP CONSTRAINT [DF__TB_Charac__IngQu__55F58EC9]
END
GO

IF NOT EXISTS(SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'dbo.TB_CharacterSub') AND [name] = N'f_EndQuestExt')
BEGIN
	ALTER TABLE dbo.TB_CharacterSub ADD [f_EndQuestExt] binary(260) NOT NULL CONSTRAINT [DF_TB_CharacterSub_f_EndQuestExt] DEFAULT (CONVERT([binary](260),(0),(0)))
END

/*
	ĳ���� ���� ����Ʈ ���� �ʵ� Ȯ��( ������� ����Ʈ) 2010.02.10 �赿ȯ
*/
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID('DF__TB_Charac__IngQu__55F58EC9') AND [Type] in (N'D'))
BEGIN
	ALTER TABLE [dbo].[TB_CharacterSub] DROP CONSTRAINT [DF__TB_Charac__IngQu__55F58EC9]
END
GO
ALTER TABLE dbo.TB_CharacterSub ALTER COLUMN [IngQuest] binary(350) NOT NULL
GO
IF NOT EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID('DF_TB_CharacterSub_IngQuest') AND [Type] in (N'D'))
BEGIN
	ALTER TABLE dbo.TB_CharacterSub Add CONSTRAINT [DF_TB_CharacterSub_IngQuest] DEFAULT (CONVERT([binary](350),(0),(0))) For [IngQuest]
END
GO

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'dbo.TB_CharacterSub') AND [name] = N'SkillSetItemCount')
BEGIN
	ALTER TABLE dbo.TB_CharacterSub ADD [SkillSetItemCount] [tinyint] NOT NULL CONSTRAINT [DF_TB_CharacterSub_SkillSetItemCount] DEFAULT ((0))
END
GO

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'dbo.TB_CharacterSub') AND [name] = N'SkillExtend')
BEGIN
	ALTER TABLE dbo.TB_CharacterSub ADD [SkillExtend] [binary] (560) NOT NULL CONSTRAINT [DF_TB_CharacterSub_SkillExtend] DEFAULT (CONVERT([binary](560),(0),(0)))
END
GO

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'dbo.TB_CharacterSub') AND [name] = N'SkillTabOpen')
BEGIN
	ALTER TABLE dbo.TB_CharacterSub ADD [SkillTabOpen] [tinyint] NOT NULL CONSTRAINT [DF_TB_CharacterSub_SkillTabOpen] DEFAULT ((0))
END
GO

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'dbo.TB_CharacterSub') AND [name] = N'SkillTabNo')
BEGIN
	ALTER TABLE dbo.TB_CharacterSub ADD [SkillTabNo] [tinyint] NOT NULL CONSTRAINT [DF_TB_CharacterSub_SkillTabNo] DEFAULT ((0))
END
GO

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'dbo.TB_CharacterSub') AND [name] = N'ExtraSkillPoint_Sec')
BEGIN
	ALTER TABLE dbo.TB_CharacterSub ADD [ExtraSkillPoint_Sec] [smallint] NOT NULL CONSTRAINT [DF_TB_CharacterSub_ExtraSkillPoint_Sec] DEFAULT ((0))
END
GO

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'dbo.TB_CharacterSub') AND [name] = N'Skills_Sec')
BEGIN
	ALTER TABLE dbo.TB_CharacterSub ADD [Skills_Sec] [binary] (450) NOT NULL CONSTRAINT [DF_TB_CharacterSub_Skills_Sec] DEFAULT (CONVERT([binary](450),(0),(0)))
END
GO

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'dbo.TB_CharacterSub') AND [name] = N'SkillExtend_Sec')
BEGIN
	ALTER TABLE dbo.TB_CharacterSub ADD [SkillExtend_Sec] [binary] (560) NOT NULL CONSTRAINT [DF_TB_CharacterSub_SkillExtend_Sec] DEFAULT (CONVERT([binary](560),(0),(0)))
END
GO

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'dbo.TB_CharacterSub') AND [name] = N'QuickSlot_Sec')
BEGIN
	ALTER TABLE dbo.TB_CharacterSub ADD [QuickSlot_Sec] [binary] (281) NOT NULL CONSTRAINT [DF_TB_CharacterSub_QuickSlot_Sec] DEFAULT (CONVERT([binary](281),(0),(0)))
END
GO


IF EXISTS(SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'dbo.TB_CharacterSub') AND [name] = N'IX_C_TB_CharacterSub_CharacterID')
BEGIN
	DROP INDEX IX_C_TB_CharacterSub_CharacterID ON dbo.TB_CharacterSub
END
GO

IF NOT EXISTS(SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'dbo.TB_CharacterSub') and [name] = N'PK_TB_CharacterSub')
BEGIN
	ALTER TABLE dbo.TB_CharacterSub ADD CONSTRAINT
		PK_TB_CharacterSub PRIMARY KEY CLUSTERED 
		(
		CharacterID
		) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
END
GO

IF NOT EXISTS(SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'dbo.TB_CharacterSub') and [name] = N'f_ConnectionChannel')
BEGIN
	ALTER TABLE dbo.TB_CharacterSub ADD [f_ConnectionChannel] SMALLINT NOT NULL CONSTRAINT [DF_TB_CharacterSub_f_ConnectionChannel] DEFAULT (0)
END

IF NOT EXISTS(SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'dbo.TB_CharacterSub') and [name] = N'f_itemGroupCoolTime')
BEGIN
	ALTER TABLE dbo.TB_CharacterSub ADD f_itemGroupCoolTime binary(256) NOT NULL CONSTRAINT [DF_TB_CharacterSub_f_itemGroupCoolTime] DEFAULT (0)
END

/*
	COLUMN �߰� : ��������ð� ����
*/
IF NOT EXISTS(SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'dbo.TB_CharacterSub') and [name] = N'f_LogOutTime')
BEGIN
	ALTER TABLE dbo.TB_CharacterSub ADD [f_LogOutTime] datetime NOT NULL CONSTRAINT DF_TB_CharacterSub_f_LogOutTime DEFAULT (GETDATE())
END

/*
	COLUMN �߰� : ����Ʈ Ȯ��
*/
IF NOT EXISTS(SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'dbo.TB_CharacterSub') AND [name] = N'f_EndQuestExt2')
BEGIN
	ALTER TABLE dbo.TB_CharacterSub ADD [f_EndQuestExt2] binary(480) NOT NULL CONSTRAINT [DF_TB_CharacterSub_f_EndQuestExt2] DEFAULT (CONVERT([binary](480),(0),(0)))
END

/*
	COLUMN �߰� : ĳ���� ���� ���� ��ġ ����
*/
IF NOT EXISTS(SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'dbo.TB_CharacterSub') AND [name] = N'f_CharactorSlot')
BEGIN
	ALTER TABLE dbo.TB_CharacterSub ADD [f_CharactorSlot] tinyint NOT NULL CONSTRAINT [DF_TB_CharacterSub_f_CharactorSlot] DEFAULT ((0))
END

/*
	COLUMN �߰� : ������ ä�η� �̵��� �� ���� ��ġ, ��, ä��, ���� ���� ����.
*/

IF NOT EXISTS (SELECT *FROM sys.columns WHERE object_id = OBJECT_ID(N'dbo.TB_CharacterSub') AND [name] = N'f_RecentChannel')
BEGIN
	ALTER TABLE dbo.TB_CharacterSub ADD [f_RecentChannel] smallint NOT NULL CONSTRAINT [DF_TB_CharacterSub_f_RecentChannel] DEFAULT (0)
	ALTER TABLE dbo.TB_CharacterSub ADD [f_RecentChannelMap] int NOT NULL CONSTRAINT [DF_TB_CharacterSub_f_RecentChannelMap] DEFAULT (0)
	ALTER TABLE dbo.TB_CharacterSub ADD [f_RecentChannelLocX] float NOT NULL CONSTRAINT [DF_TB_CharacterSub_f_RecentChannelLocX] DEFAULT (0)
	ALTER TABLE dbo.TB_CharacterSub ADD [f_RecentChannelLocY] float NOT NULL CONSTRAINT [DF_TB_CharacterSub_f_RecentChannelLocY] DEFAULT (0)
	ALTER TABLE dbo.TB_CharacterSub ADD [f_RecentChannelLocZ] float NOT NULL CONSTRAINT [DF_TB_CharacterSub_f_RecentChannelLocZ] DEFAULT (0)
	ALTER TABLE dbo.TB_CharacterSub ADD [f_RecentChannelState] smallint NOT NULL CONSTRAINT [DF_TB_CharacterSub_f_RecentChannelState] DEFAULT (0)
END

/*
	COLUMN �߰� : ���� ���潺 ���(F7) ����. ���� �Ƿε� �߰�(2011.7.22).
*/

IF NOT EXISTS (SELECT *FROM sys.columns WHERE object_id = OBJECT_ID(N'dbo.TB_CharacterSub') AND [name] = N'Strategyfatigability')
BEGIN								     
	ALTER TABLE dbo.TB_CharacterSub ADD [Strategyfatigability] smallint NOT NULL CONSTRAINT [DF_TB_CharacterSub_Strategyfatigability] DEFAULT(1700)
END