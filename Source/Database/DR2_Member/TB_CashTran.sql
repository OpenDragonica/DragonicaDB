
/* 2009-07-07 : TB_CashTran 테이블 최초 생성 
	by Eric Kim
*/
USE [DR2_Member]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Object:  Table [dbo].[TB_CashTran]    Script Date: 07/07/2009 16:40:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TB_CashTran]') AND type in (N'U'))
DROP TABLE [dbo].[TB_CashTran]

CREATE TABLE [dbo].[TB_CashTran](
	[TranGuid] [uniqueidentifier] NOT NULL,
	[MemberGuid] [uniqueidentifier] NOT NULL,
	[CharacterGuid] [uniqueidentifier] NOT NULL,
	[CashUse] [bigint] NOT NULL CONSTRAINT [DF_TB_CashTran_CashUse]  DEFAULT ((0)),
	[MileageUse] [bigint] NOT NULL CONSTRAINT [DF_TB_CashTran_MileageUse]  DEFAULT ((0)),
	[AddedMileage] [bigint] NOT NULL CONSTRAINT [DF_TB_CashTran_AddedMileage]  DEFAULT ((0)),
	[TranType] [tinyint] NOT NULL CONSTRAINT [DF_TB_CashTran_TranType]  DEFAULT ((0)),
	[CreateDate] [datetime] NULL
) ON [PRIMARY]
