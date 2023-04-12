USE [DR2_User]
GO
/****** Object:  StoredProcedure [dbo].[up_SelectAchievementRank]    Script Date: 12/17/2009 16:37:30 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_SelectAchievementRank]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_SelectAchievementRank]

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[up_SelectAchievementRank]
@OwnerGuid uniqueidentifier
AS
BEGIN
	SET NOCOUNT ON

	-- ��� ������ �ѹ� ���� ���ش�.
	if 0 = (select count(1) from dbo.TB_UserAchievementRankView)
	begin
		exec dbo.up_Update_UserAchievementRankView
	end

	declare @TRank table(rank int,ownerguid uniqueidentifier, totalpoint int)

	insert into @TRank select top 10 rank,ownerguid,totalpoint from [dbo].[TB_UserAchievementRankView] order by rank

	if not exists(select 1 from @TRank where ownerguid = @ownerguid)
	begin
		insert into @TRank select 101,ownerguid,totalpoint from [dbo].[TB_UserAchievementRankTotal] where ownerguid = @ownerguid
	end

	SET NOCOUNT OFF

	-- �˻��� ĳ���� �̸� ��񿡼� ���� �ؿ´�.
	select A.ownerguid, B.name, A.rank, A.totalpoint from @TRank A left join dbo.TB_CharacterBasic B on A.ownerguid = B.characterid
	
	-- �ֻ��� 10�� ���� �޼� ���� ����
	select ownerguid, category, point from [dbo].[TB_UserAchievementRank] where ownerguid in (select ownerguid from @TRank)

END




