USE [DR2_User]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UP_GMCMD_CashItemGift_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[UP_GMCMD_CashItemGift_Delete]
GO

/****** 개체:  StoredProcedure [dbo].[UP_GMCMD_CashItemGift_Delete]    스크립트 날짜: 09/24/2009 23:33:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
-- =============================================
-- Author:		
-- Create date: 
-- Description:	
-- =============================================
*/
CREATE PROC [dbo].[UP_GMCMD_CashItemGift_Delete]
(
	@EventNo INT
)
AS
BEGIN TRAN
SET NOCOUNT ON;

DELETE FROM [dbo].[TB_Event]
      WHERE EventNo = @EventNo AND EventType = 12 AND intData01 = 64511

IF @@ROWCOUNT = 0
BEGIN
	ROLLBACK TRAN
	SELECT 1
	RETURN 1
END

DELETE FROM [dbo].[TB_EventUserState]
      WHERE EventId = @EventNo AND EventType = 64511

COMMIT TRAN
SELECT 0
RETURN 0
