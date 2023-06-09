USE [DR2_Def]
GO
/****** Object:  Table [dbo].[TB_DefClass]    Script Date: 12/28/2012 11:15:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TB_DefClass]') AND [type] IN (N'U'))
BEGIN
CREATE TABLE [dbo].[TB_DefClass](
	[NationCodeStr] nvarchar(50) NOT NULL,
	[iClass] [int] NOT NULL,
	[iLevel] [smallint] NOT NULL,
	[ClassName] [int] NOT NULL CONSTRAINT [DF_TB_DefClass_ClassName_1]  DEFAULT ((0)),
	[Memo] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,
	[Experience] [bigint] NOT NULL CONSTRAINT [DF_TB_DefClass_Experience_1]  DEFAULT ((0)),
	[MaxHP] [smallint] NOT NULL CONSTRAINT [DF_TB_DefClass_MaxHP_1]  DEFAULT ((0)),
	[MaxMP] [smallint] NOT NULL CONSTRAINT [DF_TB_DefClass_MaxMP_1]  DEFAULT ((0)),
	[Str] [smallint] NOT NULL CONSTRAINT [DF_TB_DefClass_Str_1]  DEFAULT ((0)),
	[Int] [smallint] NOT NULL CONSTRAINT [DF_TB_DefClass_Int_1]  DEFAULT ((0)),
	[Dex] [smallint] NOT NULL CONSTRAINT [DF_TB_DefClass_Dex_1]  DEFAULT ((0)),
	[Con] [smallint] NOT NULL CONSTRAINT [DF_TB_DefClass_Con_1]  DEFAULT ((0)),
	[HP_Recovery_Speed] [smallint] NOT NULL CONSTRAINT [DF_TB_DefClass_HP_Recovery_Speed_1]  DEFAULT ((0)),
	[HP_Recovery] [smallint] NOT NULL CONSTRAINT [DF_TB_DefClass_HP_Recovery_1]  DEFAULT ((0)),
	[MP_Recovery_Speed] [smallint] NOT NULL,
	[MP_Recovery] [smallint] NOT NULL CONSTRAINT [DF_TB_DefClass_MP_Recovery_1]  DEFAULT ((0)),
	[MoveSpeed] [smallint] NOT NULL,
	[Abil01] [int] NOT NULL CONSTRAINT [DF_TB_DefClass_Abil01_1]  DEFAULT ((0)),
	[Abil02] [int] NOT NULL CONSTRAINT [DF_TB_DefClass_Abil02_1]  DEFAULT ((0)),
	[Abil03] [int] NOT NULL CONSTRAINT [DF_TB_DefClass_Abil03_1]  DEFAULT ((0)),
	[Abil04] [int] NOT NULL CONSTRAINT [DF_TB_DefClass_Abil04_1]  DEFAULT ((0)),
	[Abil05] [int] NOT NULL CONSTRAINT [DF_TB_DefClass_Abil05_1]  DEFAULT ((0)),
	[Abil06] [int] NOT NULL CONSTRAINT [DF_TB_DefClass_Abil06_1]  DEFAULT ((0)),
	[Abil07] [int] NOT NULL CONSTRAINT [DF_TB_DefClass_Abil07_1]  DEFAULT ((0)),
	[Abil08] [int] NOT NULL CONSTRAINT [DF_TB_DefClass_Abil08_1]  DEFAULT ((0)),
	[Abil09] [int] NOT NULL CONSTRAINT [DF_TB_DefClass_Abil09_1]  DEFAULT ((0)),
	[Abil10] [int] NOT NULL CONSTRAINT [DF_TB_DefClass_Abil10_1]  DEFAULT ((0)),
 CONSTRAINT [PK_TB_DefClass] PRIMARY KEY CLUSTERED 
(
	[NationCodeStr],
	[iClass],
	[iLevel]
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Character class and level definition' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_DefClass'
END
GO

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[TB_DefClass]') AND [name] = N'NationCodeStr')
BEGIN
CREATE TABLE [dbo].[Tmp_TB_DefClass](
	[NationCodeStr] nvarchar(50) NOT NULL,
	[iClass] [int] NOT NULL,
	[iLevel] [smallint] NOT NULL,
	[ClassName] [int] NOT NULL CONSTRAINT [DF_TB_DefClass_ClassName_2]  DEFAULT ((0)),
	[Memo] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,
	[Experience] [bigint] NOT NULL CONSTRAINT [DF_TB_DefClass_Experience_2]  DEFAULT ((0)),
	[MaxHP] [smallint] NOT NULL CONSTRAINT [DF_TB_DefClass_MaxHP_2]  DEFAULT ((0)),
	[MaxMP] [smallint] NOT NULL CONSTRAINT [DF_TB_DefClass_MaxMP_2]  DEFAULT ((0)),
	[Str] [smallint] NOT NULL CONSTRAINT [DF_TB_DefClass_Str_2]  DEFAULT ((0)),
	[Int] [smallint] NOT NULL CONSTRAINT [DF_TB_DefClass_Int_2]  DEFAULT ((0)),
	[Dex] [smallint] NOT NULL CONSTRAINT [DF_TB_DefClass_Dex_2]  DEFAULT ((0)),
	[Con] [smallint] NOT NULL CONSTRAINT [DF_TB_DefClass_Con_2]  DEFAULT ((0)),
	[HP_Recovery_Speed] [smallint] NOT NULL CONSTRAINT [DF_TB_DefClass_HP_Recovery_Speed_2]  DEFAULT ((0)),
	[HP_Recovery] [smallint] NOT NULL CONSTRAINT [DF_TB_DefClass_HP_Recovery_2]  DEFAULT ((0)),
	[MP_Recovery_Speed] [smallint] NOT NULL,
	[MP_Recovery] [smallint] NOT NULL CONSTRAINT [DF_TB_DefClass_MP_Recovery_2]  DEFAULT ((0)),
	[MoveSpeed] [smallint] NOT NULL,
	[Abil01] [int] NOT NULL CONSTRAINT [DF_TB_DefClass_Abil01_2]  DEFAULT ((0)),
	[Abil02] [int] NOT NULL CONSTRAINT [DF_TB_DefClass_Abil02_2]  DEFAULT ((0)),
	[Abil03] [int] NOT NULL CONSTRAINT [DF_TB_DefClass_Abil03_2]  DEFAULT ((0)),
	[Abil04] [int] NOT NULL CONSTRAINT [DF_TB_DefClass_Abil04_2]  DEFAULT ((0)),
	[Abil05] [int] NOT NULL CONSTRAINT [DF_TB_DefClass_Abil05_2]  DEFAULT ((0)),
	[Abil06] [int] NOT NULL CONSTRAINT [DF_TB_DefClass_Abil06_2]  DEFAULT ((0)),
	[Abil07] [int] NOT NULL CONSTRAINT [DF_TB_DefClass_Abil07_2]  DEFAULT ((0)),
	[Abil08] [int] NOT NULL CONSTRAINT [DF_TB_DefClass_Abil08_2]  DEFAULT ((0)),
	[Abil09] [int] NOT NULL CONSTRAINT [DF_TB_DefClass_Abil09_2]  DEFAULT ((0)),
	[Abil10] [int] NOT NULL CONSTRAINT [DF_TB_DefClass_Abil10_2]  DEFAULT ((0)),
 CONSTRAINT [PK_TB_DefClass_2] PRIMARY KEY CLUSTERED 
(
	[NationCodeStr],
	[iClass],
	[iLevel]
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


	INSERT INTO dbo.Tmp_TB_DefClass
			 (NationCodeStr, iClass, iLevel, ClassName, Memo, Experience, MaxHP, MaxMP, [Str], [Int], [Dex], [Con],
				HP_Recovery_Speed, HP_Recovery, MP_Recovery_Speed, MP_Recovery, MoveSpeed,
				Abil01, Abil02, Abil03, Abil04, Abil05, Abil06, Abil07, Abil08, Abil09, Abil10)
	SELECT 0, iClass, iLevel, ClassName, Memo, Experience, MaxHP, MaxMP, [Str], [Int], [Dex], [Con],
				HP_Recovery_Speed, HP_Recovery, MP_Recovery_Speed, MP_Recovery, MoveSpeed,
				Abil01, Abil02, Abil03, Abil04, Abil05, Abil06, Abil07, Abil08, Abil09, Abil10
	  FROM dbo.TB_DefClass WITH (HOLDLOCK TABLOCKX)
	
	DROP TABLE TB_DefClass
	
	EXECUTE sp_rename N'dbo.Tmp_TB_DefClass', 'TB_DefClass', 'OBJECT'

	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Character class and level definition' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TB_DefClass'
END
