USE [BI_Academic]
GO
/****** Object:  User [ReportSchedule]    Script Date: 07/11/2014 15:17:23 ******/
CREATE USER [ReportSchedule] FOR LOGIN [ReportSchedule] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_datareader] ADD MEMBER [ReportSchedule]
GO
