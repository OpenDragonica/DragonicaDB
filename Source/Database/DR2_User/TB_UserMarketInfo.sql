USE DR2_User

-- ������� �ʴ� ���� ���� ���̺� ����

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TB_UserMarketInfo]'))
BEGIN
	DROP TABLE [dbo].[TB_UserMarketInfo]
END
GO