USE DR2_Member

ALTER TABLE dbo.TB_Event_Type_Reward DROP COLUMN f_IDX
ALTER TABLE dbo.TB_Event_Type_Reward ADD [f_IDX] [INT] NOT NULL IDENTITY(1,1)
GO 
