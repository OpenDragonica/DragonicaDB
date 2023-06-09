USE [DR2_Member]
GO
/****** Object:  StoredProcedure [dbo].[up_UpdateMemberBlock_Id]    Script Date: 12/23/2009 00:15:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Object:  StoredProcedure [dbo].[up_UpdateMemberBlock_Id]    Script Date: 12/23/2009 00:17:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_UpdateMemberBlock_Id]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[up_UpdateMemberBlock_Id]
GO

CREATE PROC [dbo].[up_UpdateMemberBlock_Id]
/*
=============================================
Last Update by :	최연승
Update date: 2009-01-22
Description: - RPC로 자신이 블럭할때 블럭값: 101, OrderDB나 GM Command로 블럭할때 : 111
               GM이 블럭한 경우는 자기 스스로 이를 취소할 수없도록 수정
             - 리턴값에 계정, 블럭 코드, Start Time, EndTime 추가
PARAMETER :
	@Case : 발생원인
		0 : 블럭 해제
		1 : Order DB
		2 : GM Command
		3 : China
	@ID : member login id
	@StartTime
	@EndTime
RETURN :
=============================================
	2009-12-22 : Eric Kim, @ID Length(20->50)
*/
(
	@Case	int,
	@ID	nvarchar(50),
	@iBlock tinyint,
	@StartTime		datetime,
	@EndTime		datetime
)
AS
SET NOCOUNT ON
BEGIN
	DECLARE @Err		int
	SET @Err = 0

	DECLARE @NowBlockState tinyint

	if @Case = 3
	Begin
		select @NowBlockState = [Block] from [dbo].[Member] where [ID] = @ID
		if @NowBlockState > 101
		Begin
			SET @Err = 0
			select @Err, @Case, @ID, @iBlock, @StartTime, @EndTime
			RETURN
		end     
	end

	UPDATE [dbo].[Member] 
		SET [Block] = @iBlock
			,[BlockStartTime] = @StartTime
			,[BlockEndTime] = @EndTime
		WHERE [ID] = @ID
	IF @@ERROR <> 0
	BEGIN
		SET @Err = 2
	END

	select @Err, @Case, @ID, @iBlock, @StartTime, @EndTime
	return @Err

END

