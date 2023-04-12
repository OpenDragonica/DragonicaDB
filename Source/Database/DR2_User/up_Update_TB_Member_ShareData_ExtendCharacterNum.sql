USE [DR2_User]
GO
/****** Object:  StoredProcedure [dbo].[up_Update_TB_Member_ShareData_ExtendCharacterNum]    Script Date: 09/23/2009 17:11:09 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Update_TB_Member_ShareData_ExtendCharacterNum]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_Update_TB_Member_ShareData_ExtendCharacterNum]

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[up_Update_TB_Member_ShareData_ExtendCharacterNum] 
/*
////////////////////////////////////////////////////////////////////////
//
// �� �� �� : ����
// �� �� �� : 2008-10-30
// ���������� :
// �� �� �� : 
// �� �� �� : 
// N O T E : ĳ�� ���� ���� ���� â�� ��� �Ⱓ ����
//
////////////////////////////////////////////////////////////////////////
*/
@MemberKey uniqueidentifier,
@ExtendNum tinyint
AS
SET NOCOUNT ON;

if not exists(select 1 from dbo.TB_Member_ShareData where MemberKey = @MemberKey)
begin
	insert into dbo.TB_Member_ShareData (memberkey,ExtendCharacterNum) values(@MemberKey,0)
end

update dbo.TB_Member_ShareData set ExtendCharacterNum = ExtendCharacterNum + @ExtendNum
where MemberKey = @MemberKey
