USE [DR2_Log]
GO
/****** Object:  StoredProcedure [dbo].[UP_Log_Write_FromFile]    Script Date: 06/26/2009 23:45:40 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UP_Log_Write_FromFile]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[UP_Log_Write_FromFile]