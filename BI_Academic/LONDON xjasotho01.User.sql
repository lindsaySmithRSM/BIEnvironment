USE [BI_Academic]
GO
/****** Object:  User [LONDON\xjasotho01]    Script Date: 07/11/2014 15:17:23 ******/
CREATE USER [LONDON\xjasotho01] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_datareader] ADD MEMBER [LONDON\xjasotho01]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [LONDON\xjasotho01]
GO
