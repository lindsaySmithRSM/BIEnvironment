USE [BI_Academic]
GO
/****** Object:  User [LONDON\JennEve01]    Script Date: 07/11/2014 15:17:24 ******/
CREATE USER [LONDON\JennEve01] FOR LOGIN [LONDON\JennEve01] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_datareader] ADD MEMBER [LONDON\JennEve01]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [LONDON\JennEve01]
GO
