USE [BI_Academic]
GO
/****** Object:  User [LONDON\Communications and Marketing Global Group]    Script Date: 07/11/2014 15:17:24 ******/
CREATE USER [LONDON\Communications and Marketing Global Group] FOR LOGIN [LONDON\Communications and Marketing Global Group]
GO
ALTER ROLE [db_datareader] ADD MEMBER [LONDON\Communications and Marketing Global Group]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [LONDON\Communications and Marketing Global Group]
GO
