USE [DR2_User]
GO
/****** Object:  StoredProcedure [dbo].[up_Notify_Achievement_Complete]    Script Date: 11/06/2009 17:13:39 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Notify_Achievement_Complete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[up_Notify_Achievement_Complete]

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[up_Notify_Achievement_Complete]
@Ownerguid uniqueidentifier,
@AchievementIdx int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


END
