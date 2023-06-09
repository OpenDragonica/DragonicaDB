USE [DR2_User]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Hatch_Pet]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_Hatch_Pet]
GO

CREATE PROCEDURE [dbo].[up_Hatch_Pet]
/*
////////////////////////////////////////////////////////////////////////
//
// 프로시져명: 펫생성
// 작성자: YonMy(yonmy@barunsoninter.com)
// 작성일: 2009-06-16
// 최종수정자: YonMy
// 수정일: 
// 파일명: 
// Note
//	2009-08-21 : YonMy, Pet 2차 정보 추가
////////////////////////////////////////////////////////////////////////
*/
(
	@PetID				UNIQUEIDENTIFIER,	-- Pet ID
	@OwnerGuid			UNIQUEIDENTIFIER,
	@InvType			TINYINT,
	@InvPos				TINYINT,
	@ItemNo				INT,
	@Count				SMALLINT,
	@Enchant1			BIGINT,
	@Enchant2			BIGINT,
	@Enchant3			BIGINT,
	@Enchant4			BIGINT,
	@State				TINYINT,
	@GenDate			DATETIME,
	@NAME				NVARCHAR(20),		-- Pet Name
	@Class				INT,				-- Pet Class
	@Lv					SMALLINT,			-- Pet Level
	@Exp				BIGINT,				-- Pet Exp			
	@MP					INT,
	@Health				SMALLINT,			-- 건강
	@Mental				SMALLINT,			-- 지력
	@Color				TINYINT				-- 색깔
)
AS
SET NOCOUNT ON
SET XACT_ABORT ON

DECLARE @Err INT
SET @Err = 0

BEGIN TRAN
	
	EXEC [dbo].[up_Item_Create] @PetID, @OwnerGuid, @InvType, @InvPos, @ItemNo, @Count, @Enchant1, @Enchant2, @Enchant3, @Enchant4, @State, @GenDate
	IF @@ERROR <> 0
	BEGIN
		GOTO __ERROR
	END
	
	INSERT INTO [dbo].[TB_Pet]
	(
		[PetID]
	,	[Name]
	,	[Class]
	,	[Lv]
	,	[Exp]
	,	[MP]
	,	[Health]
	,	[Mental]
	,	[Color]
	)VALUES(
		@PetID
	,	@NAME
	,	@Class
	,	@Lv
	,	@Exp		
	,	@MP
	,	@Health
	,	@Mental
	,	@Color
	)
	
	IF @@ERROR <> 0
	BEGIN
		GOTO __ERROR
	END

COMMIT TRAN
SELECT @Err
RETURN @Err

__ERROR:
ROLLBACK TRAN
SET @Err = 0
SELECT @Err
RETURN @Err
