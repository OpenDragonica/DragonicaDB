USE [DR2_User]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UP_Event_CashItemGift1]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[UP_Event_CashItemGift1]
GO

/****** 개체:  StoredProcedure [dbo].[UP_Event_CashItemGift1]    스크립트 날짜: 09/22/2009 03:13:04 ******/
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
CREATE PROC [dbo].[UP_Event_CashItemGift1]
(
	@EventId INT
	,@RecvGuid UNIQUEIDENTIFIER
	,@SendName NVARCHAR(50)
	,@Comment NVARCHAR(50)
	,@ItemIdx INT
	,@TimeType TINYINT
	,@UseTime INT
	,@Option INT
)
AS

SET NOCOUNT ON;

DECLARE @MemberID UNIQUEIDENTIFIER
DECLARE @RecvName NVARCHAR(50)
DECLARE @errCode INT
DECLARE @EventType INT
SET @EventType = 64511

SELECT @MemberID = [MemberID], @RecvName = [NAME]
FROM dbo.TB_CharacterBasic 
WHERE [CharacterID] = @RecvGuid AND [State] = 0

IF @@ROWCOUNT = 0
BEGIN
	SELECT 3
	RETURN 3
END

if 0 < @Option & 0x02
BEGIN
	DECLARE @MyLv smallint
	DECLARE @MinLv smallint
	DECLARE @MaxLv smallint

	SELECT @MyLv=ISNULL(Lv,0) FROM dbo.TB_CharacterSub WHERE CharacterID=@RecvGuid
	SET @MinLv = (@Option & 0xFF0000) / 0xFFFF
	SET @MaxLv = (@Option & 0x00FF00) / 0xFF

	if @MinLv > @MyLv OR @MyLv > @MaxLv
	BEGIN
		SELECT 5
		RETURN 5
	END
END

BEGIN TRAN
	DECLARE @FindIdx int
	DECLARE @DataDate DATETIME
	if 0 < @Option & 0x01
	BEGIN
		select @FindIdx=Idx, @DataDate=DataDate01 from dbo.TB_EventUserState WITH (TABLOCKX HOLDLOCK) where EventType = @EventType and EventId = @EventId AND CharacterID=@RecvGuid
	END
	ELSE
	BEGIN
		select @FindIdx=Idx, @DataDate=DataDate01 from dbo.TB_EventUserState WITH (HOLDLOCK TABLOCKX) where EventType = @EventType and EventId = @EventId AND MemberID=@MemberID
	END

	if @@ROWCOUNT <> 0
	BEGIN
		DECLARE @TODAY DATETIME
		SET @TODAY = CONVERT(varchar(30), GETDATE(),102)
		if @DataDate >= @TODAY
		BEGIN
			SET @errCode = 4
			GOTO ErrorHandler
		END
		
		UPDATE [dbo].[TB_EventUserState]
		   SET [CharacterID] = @RecvGuid
			  ,[DataDate01] = GETDATE()
		 WHERE Idx = @FindIdx
	END
	ELSE
	BEGIN
		INSERT INTO [dbo].[TB_EventUserState]
			   ([EventType],[EventId],[MemberID],[CharacterID],[DataDate01])
		 VALUES
			   (@EventType, @EventId, @MemberID, @RecvGuid, GETDATE())
	END

	--선물제공
	SET @SendName = ISNULL(@SendName, '')
	SET @Comment  = ISNULL(@Comment, '')
	EXEC [dbo].[UP_CS_ADDGIFT2] '882829F5-F987-46B5-8C19-55067109AF4A', @SendName, @RecvName, @Comment, @ItemIdx, @TimeType, @useTime
	
	IF @@ERROR <> 0
	BEGIN
		SET @errCode = 6
		GOTO ErrorHandler
	END

COMMIT TRAN
SELECT 0,@RecvGuid
RETURN 0

ErrorHandler:
	ROLLBACK
	SELECT @errCode
	RETURN @errCode