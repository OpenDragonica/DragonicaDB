USE [DR2_SiteConfig]
GO
/****** Object:  Table [dbo].[TB_SiteServer]    Script Date: 04/02/2009 14:45:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_SiteServer](
	[IDX] [int] NOT NULL,
	[ChannelNo] [smallint] NOT NULL,
	[ServerNo] [smallint] NULL CONSTRAINT [DF_TB_SiteServer_ServerNo]  DEFAULT ((0)),
	[ServerType] [smallint] NOT NULL,
	[MachineIP] [nvarchar](20) NOT NULL CONSTRAINT [DF_TB_SiteServer_MachineIP]  DEFAULT (N'127.0.0.1'),
	[Name] [nvarchar](20) NOT NULL,
	[ServerBindIP] [nvarchar](20) NULL,
	[ServerBindPort] [smallint] NULL,
	[ServerNATIP] [nvarchar](20) NULL,
	[ServerNATPort] [smallint] NULL,
	[UserBindIP] [nvarchar](20) NULL,
	[UserBindPort] [smallint] NULL,
	[UserNATIP] [nvarchar](20) NULL,
	[UserNATPort] [smallint] NULL
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Site server configuration table
(refre to TB_SiteConfig table)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_SiteServer'

/* ===========================================================================================
	===========================================================================================
	=========================================================================================== */

-- GALA 측 서버에만 추가되어야 하는 GALA 연동 서버 추가
INSERT INTO [dbo].[TB_SiteServer]
           ([IDX]
           ,[ChannelNo]
           ,[ServerNo]
           ,[ServerType]
           ,[MachineIP]
           ,[Name]
           ,[ServerBindIP]
           ,[ServerBindPort]
           ,[ServerNATIP]
           ,[ServerNATPort]
           ,[UserBindIP]
           ,[UserBindPort]
           ,[UserNATIP]
           ,[UserNATPort])
     VALUES
           (2
           ,0
           ,1102
           ,31
           ,N'127.0.0.1'
           ,N'GALAServer'
           ,NULL
           ,NULL
           ,NULL
           ,NULL
           ,NULL
           ,NULL
           ,NULL
           ,NULL)
           
/*	GALAServer 삭제 */
DELETE FROM [dbo].[TB_SiteServer] WHERE [ServerType] = 31
/* ConsentServer 추가 */
INSERT INTO [dbo].[TB_SiteServer]
           ([IDX]
           ,[ChannelNo]
           ,[ServerNo]
           ,[ServerType]
           ,[MachineIP]
           ,[Name]
           ,[ServerBindIP]
           ,[ServerBindPort]
           ,[ServerNATIP]
           ,[ServerNATPort]
           ,[UserBindIP]
           ,[UserBindPort]
           ,[UserNATIP]
           ,[UserNATPort])
     VALUES
           (3
           ,0
           ,1102
           ,11
           ,N'127.0.0.1'
           ,N'ConsentServer'
           ,NULL
           ,NULL
           ,NULL
           ,NULL
           ,NULL
           ,NULL
           ,NULL
           ,NULL)