USE [BI_Academic]
GO
/****** Object:  User [LONDON\lindsmi01]    Script Date: 07/11/2014 15:17:23 ******/
CREATE USER [LONDON\lindsmi01] FOR LOGIN [LONDON\lindsmi01] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [LONDON\lindsmi01]
GO
