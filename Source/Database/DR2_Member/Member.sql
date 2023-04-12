USE DR2_Member
GO

ALTER TABLE [dbo].[Member] ADD
[BonusCash] [bigint] NOT NULL CONSTRAINT [DF_Member_BonusCash] DEFAULT ((0))

/* 2009.06.25 BasePW �� password ���� �����, PW���� MD5 �� encrypt �ϱ� */
UPDATE [dbo].[Member] SET [PW] = NULL
GO
ALTER TABLE [dbo].[Member] ALTER COLUMN [PW] [binary](60) NULL
GO
UPDATE [dbo].[Member] SET [PW] = HashBytes('MD5', REVERSE(UPPER([ID])) + [BasePW])
GO
ALTER TABLE [dbo].[Member] DROP CONSTRAINT DF_Member_BasePw
GO
ALTER TABLE [dbo].[Member] DROP COLUMN [BasePW]
GO
ALTER TABLE [dbo].[Member] ADD
[EventKey] [int] NULL,
[EventRewardKey] [int] NULL
GO

/*	2009.11.18
	Eric Kim
	�޽İ���ġ �����ϱ� ���� Column �߰�
*/
ALTER TABLE [dbo].[Member] ADD
	[RestAddedExpRate] [int] NOT NULL CONSTRAINT [DF_Member_RestAddedExpRate] DEFAULT ((0))
/*	2009.11.18
	Eric Kim
	�޽İ���ġ �����ϱ� ���� Column �߰� --> ���躹��
*/
ALTER TABLE [dbo].[Member] DROP CONSTRAINT [DF_Member_RestAddedExpRate]
ALTER TABLE [dbo].[Member] DROP COLUMN [RestAddedExpRate]

/* 2009.12.22
	Eric Kim : Vietnam ������ ���� ID Length 20 --> 50 ���� ����
*/
ALTER TABLE [dbo].[Member] ALTER COLUMN [ID] [nvarchar](50) NOT NULL
GO