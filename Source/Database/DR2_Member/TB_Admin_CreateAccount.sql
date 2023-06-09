/* Eric Kim, 2009-07-28 최초 작성 */
/* 	계정 생성과, 캐릭터 생성을 자동화 하기 위한 작업  */
USE [DR2_Member]
GO
/****** Object:  Table [dbo].[TB_Admin_CreateAccount]    Script Date: 07/28/2009 21:04:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_Admin_CreateAccount](
	[ID] [nvarchar](20) NOT NULL,
	[PW] [nvarchar](20) NOT NULL,
	[Character1] [smallint] NOT NULL,
	[Character2] [smallint] NOT NULL,
	[Character3] [smallint] NOT NULL,
	[Character4] [smallint] NOT NULL,
	[Ret_Account] [tinyint] NOT NULL CONSTRAINT [DF_TB_Admin_CreateAccount_Ret_Account]  DEFAULT ((1)),
	[Ret_Character1] [tinyint] NOT NULL CONSTRAINT [DF_TB_Admin_CreateAccount_Ret_Character1]  DEFAULT ((1)),
	[Ret_Character2] [tinyint] NOT NULL CONSTRAINT [DF_TB_Admin_CreateAccount_Ret_Character11]  DEFAULT ((1)),
	[Ret_Character3] [tinyint] NOT NULL CONSTRAINT [DF_TB_Admin_CreateAccount_Ret_Character12]  DEFAULT ((1)),
	[Ret_Character4] [tinyint] NOT NULL CONSTRAINT [DF_TB_Admin_CreateAccount_Ret_Character13]  DEFAULT ((1)),
 CONSTRAINT [PK_TB_Admin_CreateAccount] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
