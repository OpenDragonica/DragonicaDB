USE [DR2_User]
GO
/****** Object:  StoredProcedure [dbo].[up_SaveSkillSet]    Script Date: 02/08/2010 23:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_SaveSkillSet]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[up_SaveSkillSet]
END
GO

/*
////////////////////////////////////////////////////////////////////////
// Lasst Update by : HeonSeop Sim
// Update date  : 2010-02-02
// Description : client의 SkillSet정보를 추가
// [PARAMETER] : 
//	@CharacterID : character guid
//	@SetNo : BYTE 형태 : SkillSetNo
//	@Delay01~10 : BYTE 형태 : 딜레이 시간
//	@Type01~10 : BYTE 형태 : Item.h에 정의된 EKindUIIconGroup값
//	@SkillNo01~10 : int 형태 : SkillNo
// [RETURN] : 
//	0 : Success
//	99 : Cannot Save
// [REMARK]
////////////////////////////////////////////////////////////////////////
*/
CREATE PROCEDURE [dbo].[up_SaveSkillSet]
(
	@CharacterID uniqueidentifier,
	@SetNo tinyint, @TabNo tinyint,
	@Delay01 tinyint, @Type01 tinyint, @SkillNo01 int,
	@Delay02 tinyint, @Type02 tinyint, @SkillNo02 int,
	@Delay03 tinyint, @Type03 tinyint, @SkillNo03 int,
	@Delay04 tinyint, @Type04 tinyint, @SkillNo04 int,
	@Delay05 tinyint, @Type05 tinyint, @SkillNo05 int,
	@Delay06 tinyint, @Type06 tinyint, @SkillNo06 int,
	@Delay07 tinyint, @Type07 tinyint, @SkillNo07 int,
	@Delay08 tinyint, @Type08 tinyint, @SkillNo08 int,
	@Delay09 tinyint, @Type09 tinyint, @SkillNo09 int,
	@Delay10 tinyint, @Type10 tinyint, @SkillNo10 int
)
AS
SET NOCOUNT ON
BEGIN


DECLARE @iErr int
SET @iErr = 0

IF EXISTS ( SELECT 1 FROM [dbo].[TB_UserSkillSet] WHERE [CharacterID]=@CharacterID AND [SetNo]=@SetNo AND [TabNo]=@TabNo)
BEGIN
	UPDATE [dbo].[TB_UserSkillSet]
	   SET [Delay01]=@Delay01,	[Type01]=@Type01,	[SkillNo01]=@SkillNo01
		  ,[Delay02]=@Delay02,	[Type02]=@Type02,	[SkillNo02]=@SkillNo02
		  ,[Delay03]=@Delay03,	[Type03]=@Type03,	[SkillNo03]=@SkillNo03
		  ,[Delay04]=@Delay04,	[Type04]=@Type04,	[SkillNo04]=@SkillNo04
		  ,[Delay05]=@Delay05,	[Type05]=@Type05,	[SkillNo05]=@SkillNo05
		  ,[Delay06]=@Delay06,	[Type06]=@Type06,	[SkillNo06]=@SkillNo06
		  ,[Delay07]=@Delay07,	[Type07]=@Type07,	[SkillNo07]=@SkillNo07
		  ,[Delay08]=@Delay08,	[Type08]=@Type08,	[SkillNo08]=@SkillNo08
		  ,[Delay09]=@Delay09,	[Type09]=@Type09,	[SkillNo09]=@SkillNo09
		  ,[Delay10]=@Delay10,	[Type10]=@Type10,	[SkillNo10]=@SkillNo10
	 WHERE [CharacterID]=@CharacterID AND [SetNo]=@SetNo AND [TabNo]=@TabNo
END
ELSE
BEGIN
	INSERT INTO [dbo].[TB_UserSkillSet]
           ([CharacterID],[SetNo],[TabNo]
           ,[Delay01],[Type01],[SkillNo01]
           ,[Delay02],[Type02],[SkillNo02]
           ,[Delay03],[Type03],[SkillNo03]
           ,[Delay04],[Type04],[SkillNo04]
           ,[Delay05],[Type05],[SkillNo05]
           ,[Delay06],[Type06],[SkillNo06]
           ,[Delay07],[Type07],[SkillNo07]
           ,[Delay08],[Type08],[SkillNo08]
           ,[Delay09],[Type09],[SkillNo09]
           ,[Delay10],[Type10],[SkillNo10])
     VALUES
           (@CharacterID, @SetNo, @TabNo
		   ,@Delay01,@Type01,@SkillNo01
		   ,@Delay02,@Type02,@SkillNo02
		   ,@Delay03,@Type03,@SkillNo03
		   ,@Delay04,@Type04,@SkillNo04
		   ,@Delay05,@Type05,@SkillNo05
		   ,@Delay06,@Type06,@SkillNo06
		   ,@Delay07,@Type07,@SkillNo07
		   ,@Delay08,@Type08,@SkillNo08
		   ,@Delay09,@Type09,@SkillNo09
		   ,@Delay10,@Type10,@SkillNo10)
END	

	IF @@ERROR <> 0
	BEGIN
		SET @iErr = 99
		GOTO RETURN_POS
	END	

RETURN_POS:
	SELECT @iErr
	return @iErr


END

