USE [BI_Academic]
GO
/****** Object:  User [LONDON\joanros01]    Script Date: 07/11/2014 15:17:24 ******/
CREATE USER [LONDON\joanros01] FOR LOGIN [LONDON\joanros01] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_datareader] ADD MEMBER [LONDON\joanros01]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [LONDON\joanros01]
GO
