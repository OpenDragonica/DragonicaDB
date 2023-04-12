USE DR2_Member

ALTER TABLE [dbo].[tbl_CashLog] ADD
[f_usedmileage] [bigint] NULL,
[f_newmileage] [bigint] NULL,
[f_curmileage] [bigint] NULL
GO

ALTER TABLE [dbo].[TBL_CashLog] ADD [f_CashCode] [nvarchar](255) NULL
GO

-- 2009.07.10 Eric Kim : Cash ���� ����
--	f_status char(1) ���� f_status tinyint �� ����
USE DR2_Member
GO

ALTER TABLE [dbo].[TBL_CashLog] ALTER COLUMN [f_Status] tinyint NULL
GO
