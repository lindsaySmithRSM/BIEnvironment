USE [BI_Academic]
GO
/****** Object:  User [SSRS_Viewer]    Script Date: 07/11/2014 15:17:23 ******/
CREATE USER [SSRS_Viewer] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_datareader] ADD MEMBER [SSRS_Viewer]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [SSRS_Viewer]
GO
