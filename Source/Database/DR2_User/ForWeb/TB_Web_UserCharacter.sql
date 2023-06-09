USE [DR2_User]
GO
/****** Object:  Table [dbo].[TB_Web_UserCharacter]    Script Date: 06/09/2010 14:16:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_Web_UserCharacter](
	[f_RealmNo] [int] NOT NULL,
	[f_CharGuid] [uniqueidentifier] NOT NULL,
	[f_Strength] [int] NOT NULL,
	[f_Intelligence] [int] NOT NULL,
	[f_Constitution] [int] NOT NULL,
	[f_Dexterity] [int] NOT NULL,
	[f_Physical_Attack_Min] [int] NOT NULL,
	[f_Physical_Attack_Max] [int] NOT NULL,
	[f_Magical_Attack_Min] [int] NOT NULL,
	[f_Magical_Attack_Max] [int] NOT NULL,
	[f_Accuracy_Rate] [int] NOT NULL,
	[f_Dodge_Rate] [int] NOT NULL,
	[f_Physical_Defence] [int] NOT NULL,
	[f_Magical_Defence] [int] NOT NULL,
	[f_Recovery_HP] [int] NOT NULL,
	[f_Recovery_MP] [int] NOT NULL,
	[f_Max_HP] [int] NOT NULL,
	[f_Max_MP] [int] NOT NULL,
 CONSTRAINT [PK_TB_Character] PRIMARY KEY CLUSTERED 
(
	[f_RealmNo] ASC,
	[f_CharGuid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'최종 힘 값' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Web_UserCharacter', @level2type=N'COLUMN',@level2name=N'f_Strength'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'최종 지능 값' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Web_UserCharacter', @level2type=N'COLUMN',@level2name=N'f_Intelligence'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'최종 건강 값' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Web_UserCharacter', @level2type=N'COLUMN',@level2name=N'f_Constitution'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'최종 민첩 값' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Web_UserCharacter', @level2type=N'COLUMN',@level2name=N'f_Dexterity'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'최종 최소 물리 공격력' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Web_UserCharacter', @level2type=N'COLUMN',@level2name=N'f_Physical_Attack_Min'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'최종 최대 물리 공격력' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Web_UserCharacter', @level2type=N'COLUMN',@level2name=N'f_Physical_Attack_Max'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'최종 최소 마법 공격력' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Web_UserCharacter', @level2type=N'COLUMN',@level2name=N'f_Magical_Attack_Min'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'최종 최대 마법 공격력' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Web_UserCharacter', @level2type=N'COLUMN',@level2name=N'f_Magical_Attack_Max'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'최종 명중률(/100 해야 한다)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Web_UserCharacter', @level2type=N'COLUMN',@level2name=N'f_Accuracy_Rate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'최종 회피률(/100 해야 한다)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Web_UserCharacter', @level2type=N'COLUMN',@level2name=N'f_Dodge_Rate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'최종 물리 방어력' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Web_UserCharacter', @level2type=N'COLUMN',@level2name=N'f_Physical_Defence'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'최종 마법 방어력' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Web_UserCharacter', @level2type=N'COLUMN',@level2name=N'f_Magical_Defence'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tick당 HP 회복량' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Web_UserCharacter', @level2type=N'COLUMN',@level2name=N'f_Recovery_HP'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tick당 MP 회복량' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Web_UserCharacter', @level2type=N'COLUMN',@level2name=N'f_Recovery_MP'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'보너스 포함 최대 HP' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Web_UserCharacter', @level2type=N'COLUMN',@level2name=N'f_Max_HP'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'보너스 포함 최대 MP' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Web_UserCharacter', @level2type=N'COLUMN',@level2name=N'f_Max_MP'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'사용자 캐릭터 능력치 정보' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_Web_UserCharacter'