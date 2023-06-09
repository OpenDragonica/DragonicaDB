USE [DR2_User]
GO
/****** Object:  Table [dbo].[TB_Web_UserCharacter_ComboInfo]    Script Date: 06/09/2010 14:16:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_Web_UserCharacter_ComboInfo](
	[f_RealmNo] [int] NOT NULL,
	[f_CharGuid] [uniqueidentifier] NOT NULL,
	[f_Latest_Combo] [int] NOT NULL,
	[f_Highest_Combo] [int] NOT NULL,
	[f_Highest_Combo_Date] [datetime] NOT NULL,
 CONSTRAINT [PK_TB_Web_UserCharacter_ComboInfo] PRIMARY KEY CLUSTERED 
(
	[f_RealmNo] ASC,
	[f_CharGuid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'최근 마지막 콤보' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Web_UserCharacter_ComboInfo', @level2type=N'COLUMN',@level2name=N'f_Latest_Combo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'최대 콤보' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Web_UserCharacter_ComboInfo', @level2type=N'COLUMN',@level2name=N'f_Highest_Combo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'최대 콤보 달성일' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Web_UserCharacter_ComboInfo', @level2type=N'COLUMN',@level2name=N'f_Highest_Combo_Date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'사용자 캐릭터 콤보 정보' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Web_UserCharacter_ComboInfo'