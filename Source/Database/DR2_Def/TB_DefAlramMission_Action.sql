USE [DR2_Def]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id=OBJECT_ID(N'[dbo].[TB_DefAlramMission_Action]')) 
BEGIN

CREATE TABLE [dbo].[TB_DefAlramMission_Action](
	[Idx] [int] IDENTITY(1,1) NOT NULL,
	[AlramID] [int] NOT NULL,
	[Memo] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,
	[DiscriptionNo] [int] NULL,
	[ActionType] [int] NOT NULL,
	[ObjectType] [int] NOT NULL,
	[ObjectValue] [bigint] NOT NULL,
	[Count] [int] NOT NULL,
	[IsFail] [tinyint] NOT NULL CONSTRAINT [DF_TB_DefAlarmMission_Action_IsFail]  DEFAULT ('0')
) ON [PRIMARY]

CREATE INDEX [IX_TB_DefAlramMission_Action] ON [dbo].[TB_DefAlramMission_Action]
(
	[AlramID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]

END
GO
