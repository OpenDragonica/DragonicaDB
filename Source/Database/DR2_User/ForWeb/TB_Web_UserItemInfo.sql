USE [DR2_User]
GO
/****** Object:  Table [dbo].[TB_Web_UserItemInfo]    Script Date: 06/11/2010 15:58:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TB_Web_UserItemInfo]') and [type] in (N'U'))
BEGIN
	CREATE TABLE [dbo].[TB_Web_UserItemInfo](
		[f_RealmNo] [int] NOT NULL,
		[f_CharGuid] [uniqueidentifier] NOT NULL,
		[f_ItemNo] [int] NOT NULL,
		[f_ItemGuid] [uniqueidentifier] NOT NULL,
		[f_CurCount] [int] NOT NULL,
		[f_InvType] [int] NOT NULL,
		[f_InvPos] [int] NOT NULL,
	 CONSTRAINT [PK_TB_Web_UserItemInfo] PRIMARY KEY NONCLUSTERED 
	(
		[f_RealmNo] ASC,
		[f_CharGuid] ASC,
		[f_ItemNo] ASC,
		[f_ItemGuid] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY]

	
	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'소유자 캐릭터Guid' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Web_UserItemInfo', @level2type=N'COLUMN',@level2name=N'f_CharGuid'
	
	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'아이템 고유 번호' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Web_UserItemInfo', @level2type=N'COLUMN',@level2name=N'f_ItemNo'
	
	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'아이템 고유 ID(장비만)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Web_UserItemInfo', @level2type=N'COLUMN',@level2name=N'f_ItemGuid'
	
	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'현재 소지 갯수(장비=현재내구도)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Web_UserItemInfo', @level2type=N'COLUMN',@level2name=N'f_CurCount'
	
	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'어느 인벤에 위치 했는가' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Web_UserItemInfo', @level2type=N'COLUMN',@level2name=N'f_InvType'
	
	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'착용 아이템의 경우 착용 위치' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Web_UserItemInfo', @level2type=N'COLUMN',@level2name=N'f_InvPos'
	
	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'사용자 캐릭터 아이템 기본 정보' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Web_UserItemInfo'
END

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[TB_Web_UserItemInfo]') AND name = N'IX_TB_Web_UserItemInfo')
DROP INDEX [IX_TB_Web_UserItemInfo] ON [dbo].[TB_Web_UserItemInfo] WITH ( ONLINE = OFF )
GO

IF NOT EXISTS(SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'dbo.TB_Web_UserItemInfo') AND [name] = N'CIX_TB_Web_UserItemInfo')
BEGIN
CREATE CLUSTERED INDEX [CIX_TB_Web_UserItemInfo] ON [dbo].[TB_Web_UserItemInfo] 
(
	[f_CharGuid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
END
GO