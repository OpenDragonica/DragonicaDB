USE DR2_User

-- ������� �ʴ� ���� ���� ���̺� ����

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TB_UserMailIndex]'))
BEGIN
	DROP TABLE [dbo].[TB_UserMailIndex]
END
GO