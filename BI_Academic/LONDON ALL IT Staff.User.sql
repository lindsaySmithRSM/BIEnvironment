USE [BI_Academic]
GO
/****** Object:  User [LONDON\ALL IT Staff]    Script Date: 07/11/2014 15:17:24 ******/
CREATE USER [LONDON\ALL IT Staff] FOR LOGIN [LONDON\ALL IT Staff]
GO
ALTER ROLE [db_datareader] ADD MEMBER [LONDON\ALL IT Staff]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [LONDON\ALL IT Staff]
GO
