USE [DR2_SiteConfig]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 2009-10-21 : Eric Kim
--	채널에 알림 메시지 보여주기 위한 테이블 생성
CREATE TABLE [dbo].[TB_Channel_Notice](
	[Realm] [smallint] NOT NULL,
	[Channel] [smallint] NOT NULL,
	[Notice] [nvarchar](500) NOT NULL,
	[Memo] [nvarchar](200) NULL,
 CONSTRAINT [PK_TB_Channel_Notice] PRIMARY KEY CLUSTERED 
(
	[Realm] ASC,
	[Channel] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

-- Notice 를 ChannelList Notice 와 InChannelNotice 로 분리
ALTER TABLE [dbo].[TB_Channel_Notice] DROP COLUMN [Notice]
GO
ALTER TABLE [dbo].[TB_Channel_Notice] 
	ADD [Notice_Chnlist] [nvarchar](100) NULL,
	[Notice_InGame] [nvarchar](500) NULL
GO



