USE [DR2_Statics]
GO

/****** Object:  StoredProcedure [dbo].[up_WEB_Rank_Create]    Script Date: 06/01/2010 10:10:21 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_WEB_Rank_Create]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_WEB_Rank_Create]
GO

/****** Object:  StoredProcedure [dbo].[up_WEB_Rank_Create]    Script Date: 06/01/2010 10:10:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[up_WEB_Rank_Create]
/*
////////////////////////////////////////////////////////////////////////
//
// ���ν����� : dbo.up_WEB_Rank_Create
// �� �� �� : Richard Kim(tigerjune@barunsoninter.com)
// �� �� �� : 2008-07-07
// ���������� :
// �� �� �� : 
// �� �� �� : 
// N O T E :  ��ŷ ����
//
////////////////////////////////////////////////////////////////////////
*/
(
		@realmNo int --Realm number�� Parameter
)
as
SET NOCOUNT ON
SET XACT_ABORT ON

DECLARE @MemDB nvarchar(50)
DECLARE @USERDB nvarchar(50)
DECLARE @today nvarchar(10)
DECLARE @iClass int
DECLARE @f_type int
DECLARE @SQL nvarchar(2000)
DECLARE @Params nvarchar(2000)

SET @today = CONVERT(nvarchar(10), getdate(), 20)				--2008-06-
SET @MemDB = 'DR2_Member_'
SET @USERDB = 'DR2_User_'

SET @USERDB = @USERDB+CAST(@realmNo AS varchar(7))+'_'

SET @MemDB = @MemDB+REPLACE(@today,'-','')		--DR2_Member_2_20080619
SET @USERDB = @USERDB+REPLACE(@today,'-','')		--DR2_User_2_20080619


BEGIN TRAN

DELETE FROM dbo.tbl_Ranking WHERE f_Realm = @realmNo
IF @@error <> 0 GOTO errorHandler

		--1.����ġ
		SET @f_type = 1014
		SET @iClass = 1
		WHILE @iClass < 29
		BEGIN
			SET @SQL = N'INSERT dbo.tbl_Ranking(f_Type, f_Realm, f_CharacterID, f_Name, f_Class, f_Lv, f_Value, f_GuildName) 
					SELECT TOP 1000 @f_type, @realmNo, A.CharacterID, A.Name, C.Class, C.Lv, C.Exp, B.GuildName 
					FROM '+@USERDB+'.dbo.TB_CharacterBasic A
					INNER JOIN '+@USERDB+'.dbo.TB_CharacterSub C ON A.CharacterID = C.CharacterID
					LEFT JOIN '+@USERDB+'.dbo.TB_Guild_Member D ON A.CharacterID = D.CharacterGuid
					LEFT JOIN '+@USERDB+'.dbo.TB_Guild_Basic_Info B ON D.GuildGuid = B.GuildGuid
					INNER JOIN '+@MemDB+'.dbo.Member F ON F.MemberKey = A.MemberID
					WHERE F.GMLevel = 0 AND C.Class = @iClass AND A.state != 1 ORDER BY Lv DESC, EXP DESC '
			SET @Params = '@f_type int,@realmNo int, @iClass int'
			EXEC sp_executesql @SQL, @Params, @f_type, @realmNo, @iClass
			IF @@error <> 0 GOTO errorHandler

			SET @iClass = @iClass +1
		END

		--2.PVP
		SET @f_type = 1002
		SET @iClass = 1
		WHILE @iClass < 29
		BEGIN
			SET @SQL = N'INSERT dbo.tbl_Ranking(f_Type, f_Realm, f_CharacterID, f_Name, f_Class, f_Lv, f_Value, f_GuildName) 
					SELECT TOP 100 @f_type, @realmNo, A.CharacterID, A.Name, B.Class, B.Lv, C.Pvp_Point, E.GuildName 
					FROM '+@USERDB+'.dbo.TB_CharacterBasic A
					INNER JOIN '+@USERDB+'.dbo.TB_CharacterSub B ON A.CharacterID = B.CharacterID
					INNER JOIN '+@USERDB+'.dbo.TB_UserCharacter_Extern C ON A.CharacterID = C.CharacterID
					LEFT JOIN '+@USERDB+'.dbo.TB_Guild_Member D ON C.CharacterID = D.CharacterGuid
					LEFT JOIN '+@USERDB+'.dbo.TB_Guild_Basic_Info E ON D.GuildGuid = E.GuildGuid					
					INNER JOIN '+@MemDB+'.dbo.Member F ON F.MemberKey = A.MemberID
					WHERE F.GMLevel = 0 AND B.Class = @iClass AND A.state != 1  ORDER BY Pvp_Point DESC'
			SET @Params = '@f_type int,@realmNo int, @iClass int'
			EXEC sp_executesql @SQL, @Params, @f_type, @realmNo, @iClass
			IF @@error <> 0 GOTO errorHandler

			SET @iClass = @iClass +1
		END

		--3.COMBO
		SET @f_type = 1003
		SET @iClass = 1
		WHILE @iClass < 29
		BEGIN
			SET @SQL = N'INSERT dbo.tbl_Ranking(f_Type, f_Realm, f_CharacterID, f_Name, f_Class, f_Lv, f_Value, f_GuildName) 
					SELECT TOP 100 @f_type, @realmNo, A.CharacterID, A.Name, B.Class, B.Lv, C.MaxCombo, E.GuildName FROM 
					'+@USERDB+'.dbo.TB_CharacterBasic A
					INNER JOIN '+@USERDB+'.dbo.TB_CharacterSub B ON A.CharacterID = B.CharacterID
					INNER JOIN '+@USERDB+'.dbo.TB_UserCharacter_Point C ON A.CharacterID = C.CharacterID
					LEFT JOIN '+@USERDB+'.dbo.TB_Guild_Member D ON C.CharacterID = D.CharacterGuid
					LEFT JOIN '+@USERDB+'.dbo.TB_Guild_Basic_Info E ON D.GuildGuid = E.GuildGuid
					INNER JOIN '+@MemDB+'.dbo.Member F ON F.MemberKey = A.MemberID
					WHERE F.GMLevel = 0 AND B.Class = @iClass AND A.state != 1  ORDER BY MaxCombo DESC'
			SET @Params = '@f_type int,@realmNo int, @iClass int'
			EXEC sp_executesql @SQL, @Params, @f_type, @realmNo, @iClass
			IF @@error <> 0 GOTO errorHandler
			SET @iClass = @iClass +1
		END

		--5.�� ��ŷ
		SET @f_type = 1005
		SET @SQL = N'INSERT dbo.tbl_Ranking(f_Type, f_Realm, f_CharacterID, f_Name, f_Class, f_Lv, f_Value, f_GuildName) 
				SELECT TOP 100 @f_type, @realmNo, A.CharacterID, A.Name, B.Class, B.Lv, B.Money, D.GuildName FROM 
				'+@USERDB+'.dbo.TB_CharacterBasic A
				INNER JOIN '+@USERDB+'.dbo.TB_CharacterSub B ON A.CharacterID = B.CharacterID
				LEFT JOIN '+@USERDB+'.dbo.TB_Guild_Member C ON A.CharacterID = C.CharacterGuid
				LEFT JOIN '+@USERDB+'.dbo.TB_Guild_Basic_Info D ON C.GuildGuid = D.GuildGuid
				INNER JOIN '+@MemDB+'.dbo.Member F ON F.MemberKey = A.MemberID
				WHERE F.GMLevel = 0 AND A.state != 1 ORDER BY Money DESC'
		SET @Params = '@f_type int,@realmNo int'
		EXEC sp_executesql @SQL, @Params, @f_type, @realmNo
		IF @@error <> 0 GOTO errorHandler
		
		--6.���ĸ����
		SET @f_type = 1006
		SET @SQL = N'INSERT dbo.tbl_Ranking(f_Type, f_Realm, f_CharacterID, f_Name, f_Class, f_Lv, f_Value, f_GuildName) 
				SELECT TOP 100 @f_type, @realmNo, A.CharacterID, A.Name, B.Class, B.Lv, C.FoodMakeCount, E.GuildName FROM 	
				'+@USERDB+'.dbo.TB_CharacterBasic A
				INNER JOIN '+@USERDB+'.dbo.TB_CharacterSub B ON A.CharacterID = B.CharacterID
				INNER JOIN '+@USERDB+'.dbo.TB_UserCharacter_Point C ON A.CharacterID = C.CharacterID
				LEFT JOIN '+@USERDB+'.dbo.TB_Guild_Member D ON A.CharacterID = D.CharacterGuid
				LEFT JOIN '+@USERDB+'.dbo.TB_Guild_Basic_Info E ON D.GuildGuid = E.GuildGuid
				INNER JOIN '+@MemDB+'.dbo.Member F ON F.MemberKey = A.MemberID
				WHERE F.GMLevel = 0 AND A.state != 1 ORDER BY FoodMakeCount DESC'
		SET @Params = '@f_type int,@realmNo int'
		EXEC sp_executesql @SQL, @Params, @f_type, @realmNo
		IF @@error <> 0 GOTO errorHandler

		--7.ũ����Ż����
		/*SET @f_type = 1007
		SET @SQL = N'INSERT dbo.tbl_Ranking(f_Type, f_Realm, f_CharacterID, f_Name, f_Class, f_Lv, f_Value, f_GuildName) 
				SELECT TOP 100 @f_type, @realmNo, A.CharacterID, A.Name, B.Class, B.Lv, C.CrystalStoneCount, E.GuildName FROM 
				'+@USERDB+'.dbo.TB_CharacterBasic A
				INNER JOIN '+@USERDB+'.dbo.TB_CharacterSub B ON A.CharacterID = B.CharacterID
				INNER JOIN '+@USERDB+'.dbo.TB_UserCharacter_Point C ON A.CharacterID = C.CharacterID
				LEFT JOIN '+@USERDB+'.dbo.TB_Guild_Member D ON C.CharacterID = D.CharacterGuid
				LEFT JOIN '+@USERDB+'.dbo.TB_Guild_Basic_Info E ON D.GuildGuid = E.GuildGuid
				WHERE B.GMLevel = 0 AND A.state != 1 ORDER BY CrystalStoneCount DESC'
		SET @Params = '@f_type int,@realmNo int'
		EXEC sp_executesql @SQL, @Params, @f_type, @realmNo
		IF @@error <> 0 GOTO errorHandler*/

		--8.����ŷ
		SET @f_type = 1008
		SET @SQL = N'INSERT dbo.tbl_Ranking(f_Type, f_Realm, f_CharacterID, f_Name, f_Class, f_Lv, f_Value, f_GuildName) 
				SELECT TOP 100 @f_type, @realmNo, A.CharacterID, A.Name, B.Class, B.Lv, C.RecvMailCount, E.GuildName FROM 
				'+@USERDB+'.dbo.TB_CharacterBasic A
				INNER JOIN '+@USERDB+'.dbo.TB_CharacterSub B ON A.CharacterID = B.CharacterID
				INNER JOIN '+@USERDB+'.dbo.TB_UserCharacter_Point C ON A.CharacterID = C.CharacterID
				LEFT JOIN '+@USERDB+'.dbo.TB_Guild_Member D ON C.CharacterID = D.CharacterGuid
				LEFT JOIN '+@USERDB+'.dbo.TB_Guild_Basic_Info E ON D.GuildGuid = E.GuildGuid
				INNER JOIN '+@MemDB+'.dbo.Member F ON F.MemberKey = A.MemberID
				WHERE F.GMLevel = 0 AND A.state != 1 ORDER BY RecvMailCount DESC'
		SET @Params = '@f_type int,@realmNo int'
		EXEC sp_executesql @SQL, @Params, @f_type, @realmNo
		IF @@error <> 0 GOTO errorHandler

		--9.��þƮ ����
		SET @f_type = 1009
		SET @SQL = N'INSERT dbo.tbl_Ranking(f_Type, f_Realm, f_CharacterID, f_Name, f_Class, f_Lv, f_Value, f_GuildName) 
				SELECT TOP 100 @f_type, @realmNo, A.CharacterID, A.Name, B.Class, B.Lv, C.EnchantSucceedCount, E.GuildName FROM 
				'+@USERDB+'.dbo.TB_CharacterBasic A
				INNER JOIN '+@USERDB+'.dbo.TB_CharacterSub B ON A.CharacterID = B.CharacterID
				INNER JOIN '+@USERDB+'.dbo.TB_UserCharacter_Point C ON A.CharacterID = C.CharacterID
				LEFT JOIN '+@USERDB+'.dbo.TB_Guild_Member D ON C.CharacterID = D.CharacterGuid
				LEFT JOIN '+@USERDB+'.dbo.TB_Guild_Basic_Info E ON D.GuildGuid = E.GuildGuid
				INNER JOIN '+@MemDB+'.dbo.Member F ON F.MemberKey = A.MemberID
				WHERE F.GMLevel = 0 AND A.state != 1 ORDER BY EnchantSucceedCount DESC'
		SET @Params = '@f_type int,@realmNo int'
		EXEC sp_executesql @SQL, @Params, @f_type, @realmNo
		IF @@error <> 0 GOTO errorHandler

		--10.��þƮ ����
		SET @f_type = 1010
		SET @SQL = N'INSERT dbo.tbl_Ranking(f_Type, f_Realm, f_CharacterID, f_Name, f_Class, f_Lv, f_Value, f_GuildName) 
				SELECT TOP 100 @f_type, @realmNo, A.CharacterID, A.Name, B.Class, B.Lv, C.EnchantFailedCount, E.GuildName FROM
				'+@USERDB+'.dbo.TB_CharacterBasic A
				INNER JOIN '+@USERDB+'.dbo.TB_CharacterSub B ON A.CharacterID = B.CharacterID
				INNER JOIN '+@USERDB+'.dbo.TB_UserCharacter_Point C ON A.CharacterID = C.CharacterID
				LEFT JOIN '+@USERDB+'.dbo.TB_Guild_Member D ON C.CharacterID = D.CharacterGuid
				LEFT JOIN '+@USERDB+'.dbo.TB_Guild_Basic_Info E ON D.GuildGuid = E.GuildGuid
				INNER JOIN '+@MemDB+'.dbo.Member F ON F.MemberKey = A.MemberID
				WHERE F.GMLevel = 0 AND A.state != 1 ORDER BY EnchantFailedCount DESC'
		SET @Params = '@f_type int,@realmNo int'
		EXEC sp_executesql @SQL, @Params, @f_type, @realmNo
		IF @@error <> 0 GOTO errorHandler


		--11.20 ������ �ð�
		SET @f_type = 1004
		SET @SQL = N'INSERT dbo.tbl_Ranking(f_Type, f_Realm, f_CharacterID, f_Name, f_Class, f_Lv, f_Value, f_GuildName) 
				SELECT TOP 100 @f_type, @realmNo, A.CharacterID, A.Name, 
					Class = (Case WHEN B.Class in(1,5,6,13,14,21,22) THEN 1 
						WHEN B.Class in(2,7,8,15,16,23,24) THEN 2 	
						WHEN B.Class in(3,9,10,17,18,25,26) THEN 3
						WHEN B.Class in(4,11,12,19,20,27,28) THEN 4 	END),
					C.Level, C.PlayTimeSec, E.GuildName FROM 
				'+@USERDB+'.dbo.TB_CharacterBasic A
				INNER JOIN '+@USERDB+'.dbo.TB_CharacterSub B ON A.CharacterID = B.CharacterID
				INNER JOIN '+@USERDB+'.dbo.TB_Record_LevelUp_PlayTimeSec C ON A.CharacterID = C.CharacterID
				LEFT JOIN '+@USERDB+'.dbo.TB_Guild_Member D ON C.CharacterID = D.CharacterGuid
				LEFT JOIN '+@USERDB+'.dbo.TB_Guild_Basic_Info E ON D.GuildGuid = E.GuildGuid
				INNER JOIN '+@MemDB+'.dbo.Member F ON F.MemberKey = A.MemberID
				WHERE F.GMLevel = 0 AND C.Level =20 AND A.state != 1  ORDER BY PlayTimeSec ASC'
		SET @Params = '@f_type int,@realmNo int, @iClass int'
		EXEC sp_executesql @SQL, @Params, @f_type, @realmNo, @iClass
		IF @@error <> 0 GOTO errorHandler

		--12.40 ������ �ð�
		SET @f_type = 1011
		SET @SQL = N'INSERT dbo.tbl_Ranking(f_Type, f_Realm, f_CharacterID, f_Name, f_Class, f_Lv, f_Value, f_GuildName) 
				SELECT TOP 100 @f_type, @realmNo, A.CharacterID, A.Name, 
					Class = (Case WHEN B.Class in(1,5,6,13,14,21,22) THEN 1 
						WHEN B.Class in(2,7,8,15,16,23,24) THEN 2 	
						WHEN B.Class in(3,9,10,17,18,25,26) THEN 3
						WHEN B.Class in(4,11,12,19,20,27,28) THEN 4 	END),
				C.Level, C.PlayTimeSec, E.GuildName FROM 
				'+@USERDB+'.dbo.TB_CharacterBasic A
				INNER JOIN '+@USERDB+'.dbo.TB_CharacterSub B ON A.CharacterID = B.CharacterID
				INNER JOIN '+@USERDB+'.dbo.TB_Record_LevelUp_PlayTimeSec C ON A.CharacterID = C.CharacterID
				LEFT JOIN '+@USERDB+'.dbo.TB_Guild_Member D ON C.CharacterID = D.CharacterGuid
				LEFT JOIN '+@USERDB+'.dbo.TB_Guild_Basic_Info E ON D.GuildGuid = E.GuildGuid
				INNER JOIN '+@MemDB+'.dbo.Member F ON F.MemberKey = A.MemberID
				WHERE F.GMLevel = 0 AND C.Level = 40 AND A.state != 1  ORDER BY PlayTimeSec ASC'
		SET @Params = '@f_type int,@realmNo int, @iClass int'
		EXEC sp_executesql @SQL, @Params, @f_type, @realmNo, @iClass
		IF @@error <> 0 GOTO errorHandler

		--13.60 ������ �ð�
		SET @f_type = 1012
		SET @SQL = N'INSERT dbo.tbl_Ranking(f_Type, f_Realm, f_CharacterID, f_Name, f_Class, f_Lv, f_Value, f_GuildName) 
				SELECT TOP 100 @f_type, @realmNo, A.CharacterID, A.Name, 
					Class = (Case WHEN B.Class in(1,5,6,13,14,21,22) THEN 1 
						WHEN B.Class in(2,7,8,15,16,23,24) THEN 2 	
						WHEN B.Class in(3,9,10,17,18,25,26) THEN 3
						WHEN B.Class in(4,11,12,19,20,27,28) THEN 4 	END),
				C.Level, C.PlayTimeSec, E.GuildName FROM
				'+@USERDB+'.dbo.TB_CharacterBasic A
				INNER JOIN '+@USERDB+'.dbo.TB_CharacterSub B ON A.CharacterID = B.CharacterID
				INNER JOIN '+@USERDB+'.dbo.TB_Record_LevelUp_PlayTimeSec C ON A.CharacterID = C.CharacterID
				LEFT JOIN '+@USERDB+'.dbo.TB_Guild_Member D ON C.CharacterID = D.CharacterGuid
				LEFT JOIN '+@USERDB+'.dbo.TB_Guild_Basic_Info E ON D.GuildGuid = E.GuildGuid
				INNER JOIN '+@MemDB+'.dbo.Member F ON F.MemberKey = A.MemberID
				WHERE F.GMLevel = 0 AND C.Level = 60 AND A.state != 1  ORDER BY PlayTimeSec ASC'
		SET @Params = '@f_type int,@realmNo int, @iClass int'
		EXEC sp_executesql @SQL, @Params, @f_type, @realmNo, @iClass
		IF @@error <> 0 GOTO errorHandler

		--14.80 ������ �ð�
		SET @f_type = 1013
		SET @SQL = N'INSERT dbo.tbl_Ranking(f_Type, f_Realm, f_CharacterID, f_Name, f_Class, f_Lv, f_Value, f_GuildName) 
				SELECT TOP 100 @f_type, @realmNo, A.CharacterID, A.Name, 
					Class = (Case WHEN B.Class in(1,5,6,13,14,21,22) THEN 1 
						WHEN B.Class in(2,7,8,15,16,23,24) THEN 2 	
						WHEN B.Class in(3,9,10,17,18,25,26) THEN 3
						WHEN B.Class in(4,11,12,19,20,27,28) THEN 4 	END),
				C.Level, C.PlayTimeSec, E.GuildName FROM
				'+@USERDB+'.dbo.TB_CharacterBasic A
				INNER JOIN '+@USERDB+'.dbo.TB_CharacterSub B ON A.CharacterID = B.CharacterID
				INNER JOIN '+@USERDB+'.dbo.TB_Record_LevelUp_PlayTimeSec C ON A.CharacterID = C.CharacterID
				LEFT JOIN '+@USERDB+'.dbo.TB_Guild_Member D ON C.CharacterID = D.CharacterGuid
				LEFT JOIN '+@USERDB+'.dbo.TB_Guild_Basic_Info E ON D.GuildGuid = E.GuildGuid
				INNER JOIN '+@MemDB+'.dbo.Member F ON F.MemberKey = A.MemberID
				WHERE F.GMLevel = 0 AND C.Level = 80 AND A.state != 1  ORDER BY PlayTimeSec ASC'
		SET @Params = '@f_type int,@realmNo int, @iClass int'
		EXEC sp_executesql @SQL, @Params, @f_type, @realmNo, @iClass
		IF @@error <> 0 GOTO errorHandler

		--15.100 ������ �ð�
		SET @f_type = 1015
		SET @SQL = N'INSERT dbo.tbl_Ranking(f_Type, f_Realm, f_CharacterID, f_Name, f_Class, f_Lv, f_Value, f_GuildName) 
				SELECT TOP 100  @f_type, @realmNo, A.CharacterID, A.Name, 
					Class = (Case WHEN B.Class in(1,5,6,13,14,21,22) THEN 1 
						WHEN B.Class in(2,7,8,15,16,23,24) THEN 2 	
						WHEN B.Class in(3,9,10,17,18,25,26) THEN 3
						WHEN B.Class in(4,11,12,19,20,27,28) THEN 4 	END),
				C.Level, C.PlayTimeSec, E.GuildName FROM
				'+@USERDB+'.dbo.TB_CharacterBasic A
				INNER JOIN '+@USERDB+'.dbo.TB_CharacterSub B ON A.CharacterID = B.CharacterID
				INNER JOIN '+@USERDB+'.dbo.TB_Record_LevelUp_PlayTimeSec C ON A.CharacterID = C.CharacterID
				LEFT JOIN '+@USERDB+'.dbo.TB_Guild_Member D ON C.CharacterID = D.CharacterGuid
				LEFT JOIN '+@USERDB+'.dbo.TB_Guild_Basic_Info E ON D.GuildGuid = E.GuildGuid
				INNER JOIN '+@MemDB+'.dbo.Member F ON F.MemberKey = A.MemberID
				WHERE F.GMLevel = 0 AND C.Level = 100 AND A.state != 1  ORDER BY PlayTimeSec ASC'
		SET @Params = '@f_type int,@realmNo int, @iClass int'
		EXEC sp_executesql @SQL, @Params, @f_type, @realmNo, @iClass
		IF @@error <> 0 GOTO errorHandler

		--17.��� �ο���
		SET @f_type = 1018
		SET @SQL = N'INSERT dbo.tbl_Ranking(f_Type, f_Realm, f_CharacterID, f_Name, f_Class, f_Lv, f_Value, f_GuildName) 
				SELECT @f_type, @realmNo, NULL, NULL, NULL, NULL
					, ( SELECT COUNT(*) FROM '+@USERDB+'.dbo.TB_Guild_Member B WHERE B.GuildGUID = A.GuildGUID ) AS GuildCount
					, GuildName 
				 FROM '+@USERDB+'.dbo.TB_Guild_Basic_Info A
				 INNER JOIN '+@USERDB+'.dbo.TB_CharacterBasic B ON B.CharacterID = A.MasterCharacterGuid
				 INNER JOIN '+@MemDB+'.dbo.Member C ON C.MemberKey = B.MemberID
				 WHERE C.GMLevel = 0
				 ORDER BY ( SELECT COUNT(*) FROM '+@USERDB+'.dbo.TB_Guild_Member B WHERE B.GuildGUID = A.GuildGUID ) DESC  '
		SET @Params = '@f_type int,@realmNo int'
		EXEC sp_executesql @SQL, @Params, @f_type, @realmNo
		IF @@error <> 0 GOTO errorHandler

		--18.��� ����
		SET @f_type = 1019
		SET @SQL = N'INSERT dbo.tbl_Ranking(f_Type, f_Realm, f_CharacterID, f_Name, f_Class, f_Lv, f_Value, f_GuildName) 
				SELECT @f_type, @realmNo, NULL, NULL, NULL, NULL
					, CurrentLevel
					, GuildName 
				 FROM '+@USERDB+'.dbo.TB_Guild_Basic_Info A
				 INNER JOIN '+@USERDB+'.dbo.TB_CharacterBasic B ON B.CharacterID = A.MasterCharacterGuid
				 INNER JOIN '+@MemDB+'.dbo.Member C ON C.MemberKey = B.MemberID
				 WHERE C.GMLevel = 0
				 ORDER BY CurrentLevel DESC  '
		SET @Params = '@f_type int,@realmNo int'
		EXEC sp_executesql @SQL, @Params, @f_type, @realmNo
		IF @@error <> 0 GOTO errorHandler

		--19.��� ����ġ
		SET @f_type = 1020
		SET @SQL = N'INSERT dbo.tbl_Ranking(f_Type, f_Realm, f_CharacterID, f_Name, f_Class, f_Lv, f_Value, f_GuildName) 
				SELECT @f_type, @realmNo, NULL, NULL, NULL, NULL
					, CurrentExp
					, GuildName 
				 FROM '+@USERDB+'.dbo.TB_Guild_Basic_Info A
				 INNER JOIN '+@USERDB+'.dbo.TB_CharacterBasic B ON B.CharacterID = A.MasterCharacterGuid
				 INNER JOIN '+@MemDB+'.dbo.Member C ON C.MemberKey = B.MemberID
				 WHERE C.GMLevel = 0
				 ORDER BY CurrentExp DESC  '
		SET @Params = '@f_type int,@realmNo int'
		EXEC sp_executesql @SQL, @Params, @f_type, @realmNo
		IF @@error <> 0 GOTO errorHandler

		--20.�һ��� ���� ��ŷ
		SET @f_type = 1021
		SET @SQL = N'INSERT dbo.tbl_Ranking(f_Type, f_Realm, f_CharacterID, f_Name, f_Class, f_Lv, f_Value, f_GuildName) 
				SELECT TOP 100 @f_type, @realmNo, A.CharacterID, A.Name, B.Class, B.Lv, C.UsePhoenixFeatherCount, E.GuildName FROM 
				'+@USERDB+'.dbo.TB_CharacterBasic A
				INNER JOIN '+@USERDB+'.dbo.TB_CharacterSub B ON A.CharacterID = B.CharacterID
				INNER JOIN '+@USERDB+'.dbo.TB_UserCharacter_Point C ON A.CharacterID = C.CharacterID
				LEFT JOIN '+@USERDB+'.dbo.TB_Guild_Member D ON C.CharacterID = D.CharacterGuid
				LEFT JOIN '+@USERDB+'.dbo.TB_Guild_Basic_Info E ON D.GuildGuid = E.GuildGuid
				INNER JOIN '+@MemDB+'.dbo.Member F ON F.MemberKey = A.MemberID
				WHERE F.GMLevel = 0 AND A.state != 1 ORDER BY UsePhoenixFeatherCount DESC'
		SET @Params = '@f_type int,@realmNo int'
		EXEC sp_executesql @SQL, @Params, @f_type, @realmNo
		IF @@error <> 0 GOTO errorHandler

COMMIT TRAN
RETURN

errorHandler:
		ROLLBACK TRAN
		RETURN

GO


