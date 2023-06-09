USE [DR2_SiteConfig]
GO

/****** Object:  StoredProcedure [dbo].[up_LoadChannelNotice]    Script Date: 10/21/2009 12:10:21 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_LoadChannelNotice]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[up_LoadChannelNotice]
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
	loading TB_Channel_Notice table
	2009.10.21 : Eric Kim, 최초작성
*/
CREATE PROCEDURE [dbo].[up_LoadChannelNotice]
	@tblName nvarchar(100),
	@RealmNo smallint
AS
BEGIN
SET NOCOUNT ON
DECLARE @SQL nvarchar(200)
DECLARE @SQL_Params nvarchar(100)

SET @SQL = N'(SELECT [Realm],[Channel],[Notice_Chnlist],[Notice_InGame] FROM [dbo].['+@tblName+'] WHERE [Realm] = @RealmNo)'
SET @SQL_Params = N'@RealmNo smallint'

EXEC sp_executesql @SQL, @SQL_Params, @RealmNo
end


