USE [BI_Academic]
GO
/****** Object:  User [LONDON\jerethe01]    Script Date: 07/11/2014 15:17:24 ******/
CREATE USER [LONDON\jerethe01] FOR LOGIN [LONDON\jerethe01] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_datareader] ADD MEMBER [LONDON\jerethe01]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [LONDON\jerethe01]
GO
