USE [BI_Academic]
GO
/****** Object:  User [LONDON\Academic Staff]    Script Date: 07/11/2014 15:17:24 ******/
CREATE USER [LONDON\Academic Staff] FOR LOGIN [LONDON\Academic Staff]
GO
ALTER ROLE [db_datareader] ADD MEMBER [LONDON\Academic Staff]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [LONDON\Academic Staff]
GO
