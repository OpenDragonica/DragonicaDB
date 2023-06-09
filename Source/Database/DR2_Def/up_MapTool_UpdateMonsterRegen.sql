USE [DR2_Def]
GO

/****** Object:  StoredProcedure [dbo].[up_MapTool_UpdateMonsterRegen]    Script Date: 03/26/2009 17:57:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_MapTool_UpdateMonsterRegen]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_MapTool_UpdateMonsterRegen]

/****** Object:  StoredProcedure [dbo].[up_MapTool_UpdateMonsterRegen]    Script Date: 03/26/2009 17:54:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		?
-- Create date: ?
-- Description:	MapTool 에서 MonsterRegen 정보 저장하기
-- =============================================
/*
//	2009.03.26 : Eric Kim, Monster 가 바라보는 정보 추가 (Direction)
*/

CREATE PROCEDURE [dbo].[up_MapTool_UpdateMonsterRegen]

@TableName nvarchar(50),
@UpdateType int,
@PointGuid uniqueidentifier, 
@Memo nvarchar(MAX) = '',
@MapNo int = 0,
@ParentBagType tinyint = 0,
@ParentBagNo int = 0,
@PointGroup int = 0,
@RegenPeriod int = 0,
@PosX float = 0,
@PosY float = 0,
@PosZ float = 0,
@MoveRange int = 0,
@Direction tinyint = 255

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @SQL nvarchar(1000)
	DECLARE @SQL_Params nvarchar(300)

	declare @TableType int
	set @TableType = 0 --(@MapNo / 1000 * 1000) % 10000 -- 카오스맵 번호의 특징은 1000 단위 위치에 '0' 이 아닌 번호를 사용한다.

	if @UpdateType = 1
	begin

		if @TableType = 0
		begin 

			SET @SQL = N'INSERT INTO dbo.' + @TableName + 
				' (PointGuid,  Memo,  MapNo,  ParentBagType,  ParentBagNo,  PointGroup,  RegenPeriod,  PosX,  PosY,  PosZ,  MoveRange, Direction)
				VALUES
				(@PointGuid, @Memo, @MapNo, @ParentBagType, @ParentBagNo, @PointGroup, @RegenPeriod, @PosX, @PosY, @PosZ, @MoveRange, @Direction)'

			SET @SQL_Params = N'@PointGuid uniqueidentifier, @Memo nvarchar(MAX), @MapNo int, @ParentBagType tinyint, @ParentBagNo int, @PointGroup int, @RegenPeriod int, @PosX float, @PosY float, @PosZ float, @MoveRange int, @Direction tinyint'

			EXEC sp_executesql @SQL, @SQL_Params, @PointGuid, @Memo, @MapNo, @ParentBagType, @ParentBagNo, @PointGroup, @RegenPeriod, @PosX, @PosY, @PosZ, @MoveRange, @Direction

		end
		else
		begin

			INSERT INTO dbo.TB_DefMapMonsterRegen_11
				(PointGuid,  Memo,  MapNo,  ParentBagType,  ParentBagNo,  PointGroup,  RegenPeriod,  PosX,  PosY,  PosZ,  MoveRange, Direction) 
				VALUES 
				(@PointGuid, @Memo, @MapNo, @ParentBagType, @ParentBagNo, @PointGroup, @RegenPeriod, @PosX, @PosY, @PosZ, @MoveRange, @Direction)

		end

	end
	else if @UpdateType = 2
	begin

		if @TableType = 0
		begin 

			SET @SQL = N'UPDATE dbo.' + @TableName + 
				' SET 
				PointGuid = @PointGuid,
		        Memo = @Memo,
		        MapNo = @MapNo,
		        ParentBagType = @ParentBagType,
		        ParentBagNo = @ParentBagNo,
		        PointGroup = @PointGroup,
		        RegenPeriod = @RegenPeriod,
		        PosX = @PosX,
		        PosY = @PosY,
		        PosZ = @PosZ,
		        MoveRange = @MoveRange,
				Direction = @Direction
				WHERE PointGuid= @PointGuid'

			SET @SQL_Params = N'@PointGuid uniqueidentifier, @Memo nvarchar(MAX), @MapNo int, @ParentBagType tinyint, @ParentBagNo int, @PointGroup int, @RegenPeriod int, @PosX float, @PosY float, @PosZ float, @MoveRange int, @Direction tinyint'

			EXEC sp_executesql @SQL, @SQL_Params, @PointGuid, @Memo, @MapNo, @ParentBagType, @ParentBagNo, @PointGroup, @RegenPeriod, @PosX, @PosY, @PosZ, @MoveRange, @Direction

		end
		else
		begin

			UPDATE dbo.TB_DefMapMonsterRegen_11
				SET 
				PointGuid = @PointGuid,
				Memo = @Memo,
				MapNo = @MapNo,
				ParentBagType = @ParentBagType,
				ParentBagNo = @ParentBagNo,
				PointGroup = @PointGroup,
				RegenPeriod = @RegenPeriod,
				PosX = @PosX,
				PosY = @PosY,
				PosZ = @PosZ,
				MoveRange = @MoveRange,
				Direction = @Direction
				WHERE PointGuid= @PointGuid

		end
	end
	else
	begin

		if @TableType = 0
		begin 
			SET @SQL = N'DELETE FROM dbo.' + @TableName + ' WHERE PointGuid = @PointGuid'

			SET @SQL_Params = N'@PointGuid uniqueidentifier'

			EXEC sp_executesql @SQL, @SQL_Params, @PointGuid
		end
		else
		begin
			DELETE FROM dbo.TB_DefMapMonsterRegen_11 WHERE PointGuid = @PointGuid
		end
	end

END
