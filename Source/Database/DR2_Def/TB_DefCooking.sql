USE [DR2_Def]
GO
/****** Object:  Table [dbo].[TB_DefItemMaking]    Script Date: 03/20/2013 09:55:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TB_DefCooking]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[TB_DefCooking](
		[No] [int] NOT NULL,
		[Memo] [nvarchar](50) NULL,
		[MakingTypeNo] [int] NOT NULL,
		[NeedMoney] [int] NOT NULL,
		[NeedElementNo01] [int] NOT NULL,
		[NeedElementCount01] [int] NOT NULL,
		[NeedElementNo02] [int] NOT NULL,
		[NeedElementCount02] [int] NOT NULL,
		[NeedElementNo03] [int] NOT NULL,
		[NeedElementCount03] [int] NOT NULL,
		[NeedElementNo04] [int] NOT NULL,
		[NeedElementCount04] [int] NOT NULL,
		[OptionElementNo01] [int] NOT NULL,
		[OptionElementCount01] [int] NOT NULL,
		[ResultItemNo01] [int] NOT NULL,
		[ResultItemCount01] [int] NOT NULL,
		[ResultItemNo02] [int] NOT NULL,
		[ResultItemCount02] [int] NOT NULL,
		[ResultItemNo03] [int] NOT NULL,
		[ResultItemCount03] [int] NOT NULL,
		[ResultItemRate01] [int] NOT NULL,
		[ResultItemRate02] [int] NOT NULL,
		[ResultItemRate03] [int] NOT NULL,
		[OptionResultItemRate01] [int] NOT NULL,
		[OptionResultItemRate02] [int] NOT NULL,
		[OptionResultItemRate03] [int] NOT NULL,
	 CONSTRAINT [PK_TB_DefCooking] PRIMARY KEY CLUSTERED 
	(
		[No] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY]
END
GO
