USE [DR2_User]
GO
/****** Object:  StoredProcedure [dbo].[UP_Load_LimitedItemRecord]    Script Date: 08/21/2009 13:47:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Object:  StoredProcedure [dbo].[UP_Load_LimitedItemRecord]    Script Date: 08/21/2009 13:47:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UP_Load_LimitedItemRecord]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[UP_Load_LimitedItemRecord]
GO

CREATE proc [dbo].[UP_Load_LimitedItemRecord]
as
begin
	select EventNo, LimitRefreshDate, SafeRefreshDate, StartDate, EndDate, Limit_ResetPeriod, Safe_ResetPeriod, RefreshCount, LimitCount, SafeCount from [dbo].[TB_LimitedItemRecord]
end
