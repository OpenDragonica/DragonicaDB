declare @path nvarchar(100)
declare @path0 nvarchar(100)
declare @date nvarchar(100)
DECLARE @MyTag nvarchar(10)

SET @MyTag = N'Eric'
set @date = convert(nvarchar(20), getDate(), 112)
set @path0 = 'E:\Backup_SQL\Eric\'

--/*
PRINT 'Backup Begin DR2_Def'
set @path = @path0 + @MyTag + '_DR2_Def_'+@date+'.bak'
backup database DR2_Def to disk = @path with name = 'DR2_Def', CHECKSUM , stats =10 
PRINT '... Ended Backup DR2_Def'
--*/

--/*
PRINT 'Backup Begin DR2_Local'
set @path = @path0 + @MyTag + '_DR2_Local_'+@date+'.bak'
backup database DR2_Local to disk = @path with name = 'DR2_Local', CHECKSUM , stats =10
PRINT '... Ended Backup DR2_Local'
--*/

--/*
PRINT 'Backup Begin DR2_Member'
set @path = @path0 + @MyTag + '_DR2_Member_'+@date+'.bak'
backup database DR2_Member to disk = @path with name = 'DR2_Member', CHECKSUM , stats =10
PRINT '... Ended Backup DR2_Member'
--*/

--/*
PRINT 'Backup Begin DR2_User'
set @path = @path0 + @MyTag + '_DR2_User_'+@date+'.bak'
backup database DR2_User to disk = @path with name = 'DR2_User', CHECKSUM , stats =10
PRINT '... Ended Backup DR2_User'
--*/

/*
PRINT 'Backup Begin DR2_GM'
set @path = @path0 + @MyTag + '_DR2_GM_'+@date+'.bak'
backup database DR2_GM to disk = @path with name = 'DR2_GM', CHECKSUM , stats =10
PRINT '... Ended Backup DR2_GM'
*/

/*
PRINT 'Backup Begin DR2_Log'
set @path = @path0 + @MyTag + '_DR2_Log_'+@date+'.bak'
backup database DR2_Log to disk = @path with name = 'DR2_Log', CHECKSUM , stats =10
PRINT '... Ended Backup DR2_Log'
*/

/*
PRINT 'Backup Begin DR2_SiteConfig'
set @path = @path0 + @MyTag + '_DR2_SiteConfig_'+@date+'.bak'
backup database DR2_SiteConfig to disk = @path with name = 'DR2_SiteConfig', CHECKSUM , stats =10
PRINT '... Ended Backup DR2_SiteConfig'
*/

PRINT '............. BACKUP Completed ....................'

