USE [DR2_Log]
GO

IF EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_LoadDefConvert2Nc]') AND [type] IN (N'P'))
BEGIN
	DROP PROC [dbo].[up_LoadDefConvert2Nc]
END

IF EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_LoadDefConvertLog2Nc]') AND [type] IN (N'P'))
BEGIN
	DROP PROC [dbo].[up_LoadDefConvertLog2Nc]
END

/****** Object:  StoredProcedure [dbo].[up_LoadDefConvert2Nc]    Script Date: 06/24/2010 14:21:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[up_LoadDefConvertLog2Nc]
AS 
SET nocount ON 
SET XACT_ABORT ON	
BEGIN
	SELECT 
		[f_NC_Log_ModelType]
		,[f_DR_LogType]
		,[f_DR_SubLogType]
		,[f_DR_OrderType]
		,[f_DR_ActionType]
		,[f_NC_LogID]
		,[f_NC_iData1]
		,[f_NC_iData2]
		,[f_NC_iData3]
		,[f_NC_iData4]
		,[f_NC_iData5]
		,[f_NC_iData6]
		,[f_NC_iData7]
		,[f_NC_bData1]
		,[f_NC_bData2]
		,[f_NC_bData3]
		,[f_NC_bData4]
		,[f_NC_bData5]
		,[f_NC_bData6]
		,[f_NC_sData1]
		,[f_NC_sData2]
		,[f_NC_sData3]
		,[f_NC_sData4]
		,[f_NC_sData5]
		,[f_NC_sData6]
		,[f_NC_sData7]
		,[f_NC_sData8]
		,[f_NC_sData9]
		,[f_NC_sData10]
		,[f_NC_sData11]
		,[f_NC_sData12]
		,[f_NC_sData13]
		,[f_NC_sData14]
		,[f_NC_sData15]
	FROM [DR2_Log].[dbo].[TB_DefConvertLog2NC]

END
