USE [DR2_User]
GO

/****** 개체:  Table [dbo].[TB_EventUserState]    스크립트 날짜: 09/22/2009 02:41:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TB_EventUserState]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TB_EventUserState](
	[EventType] [int] NOT NULL,
	[EventId] [int] NOT NULL,
	[MemberID] [uniqueidentifier] NOT NULL,
	[CharacterID] [uniqueidentifier] NOT NULL,
	[intData01] [int] NULL,
	[intData02] [int] NULL,
	[intData03] [int] NULL,
	[bigintData01] [bigint] NULL,
	[guidData01] [uniqueidentifier] NULL,
	[DataDate01] [datetime] NULL,
	[stringData01] [nvarchar](100) NULL
) ON [PRIMARY]
END
GO

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[TB_EventUserState]') and name = N'EventType')
BEGIN
	ALTER TABLE [dbo].[TB_EventUserState] ALTER COLUMN [EventType] [int] NOT NULL
END
GO

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[TB_EventUserState]') and name = N'Idx')
BEGIN
	exec sp_rename N'dbo.TB_EventUserState', N'Tmp_TB_EventUserState', 'OBJECT'
	
	CREATE TABLE [dbo].[TB_EventUserState](
		[Idx] [int] IDENTITY(1,1) NOT NULL,
		[EventType] [int] NOT NULL,
		[EventId] [int] NOT NULL,
		[MemberID] [uniqueidentifier] NOT NULL,
		[CharacterID] [uniqueidentifier] NOT NULL,
		[intData01] [int] NULL,
		[intData02] [int] NULL,
		[intData03] [int] NULL,
		[bigintData01] [bigint] NULL,
		[guidData01] [uniqueidentifier] NULL,
		[DataDate01] [datetime] NULL,
		[stringData01] [nvarchar](100) NULL
	) ON [PRIMARY]

	IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'dbo.[TB_EventUserState]') AND [name] = N'IX_TB_EventUserState')
	BEGIN
		CREATE CLUSTERED INDEX [IX_TB_EventUserState] ON [dbo].[TB_EventUserState]([Idx],[EventType],[EventId],[MemberID],[CharacterID])
	END

	INSERT INTO dbo.TB_EventUserState (EventType, EventId, MemberID, CharacterID, intData01, intData02, intData03, bigintData01, guidData01, DataDate01, stringData01)
	SELECT EventType, EventId, MemberID, CharacterID, intData01, intData02, intData03, bigintData01, guidData01, DataDate01, stringData01 FROM dbo.Tmp_TB_EventUserState WITH (HOLDLOCK TABLOCKX)
	GROUP BY EventType, EventId, MemberID, CharacterID, intData01, intData02, intData03, bigintData01, guidData01, DataDate01, stringData01

	DROP TABLE dbo.Tmp_TB_EventUserState
END
GO
