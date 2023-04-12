USE DR2_GM
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Procedure Name : UP_Failed_Order
-- Author:		������
-- Create date: 2009�� 9�� 5��
-- Description:	GM_Order ���� ó��. CmdState�� 3(����) �� �����ϰ� 
--              Errorcode�� �����ڵ带 ����Ѵ�.
-- =============================================


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.UP_Failed_Order') AND type in (N'P', N'PC'))
DROP PROCEDURE UP_Failed_Order
GO

CREATE PROCEDURE UP_Failed_Order
(
	@OrderGUID		UNIQUEIDENTIFIER,
	@FailedCode		int
)
AS
BEGIN TRAN

DECLARE @Err int;
	SET @Err = 0;
	SET NOCOUNT ON;

	--�ش� OderQuery�� �����ϴ°�?
	SELECT CmdGUID
		FROM [dbo].[Tbl_Gm_Order]
		WHERE CmdGUID = @OrderGUID;
		
	--���ٸ� ������Ʈ ����.	
	IF @@rowcount = 0
	BEGIN
		SET @Err = 1;
		GOTO rollback_tran;
	END

	--������Ʈ ����.
	UPDATE [dbo].[Tbl_Gm_Order]
	   SET CmdState = 3, ErrorCode = @FailedCode, CompleteDate = getdate()
	 WHERE CmdGUID = @OrderGUID


commit_tran:
BEGIN
	COMMIT TRAN
	SELECT @Err
	RETURN @Err
END

rollback_tran:
BEGIN
	ROLLBACK TRAN
	SELECT @Err
END