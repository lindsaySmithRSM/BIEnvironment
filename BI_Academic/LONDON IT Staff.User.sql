USE [BI_Academic]
GO
/****** Object:  User [LONDON\IT Staff]    Script Date: 07/11/2014 15:17:24 ******/
CREATE USER [LONDON\IT Staff] FOR LOGIN [LONDON\IT Staff]
GO
ALTER ROLE [db_datareader] ADD MEMBER [LONDON\IT Staff]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [LONDON\IT Staff]
GO
