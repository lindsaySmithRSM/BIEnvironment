USE [BI_Academic]
GO
/****** Object:  User [LONDON\Domain Admins]    Script Date: 07/11/2014 15:17:24 ******/
CREATE USER [LONDON\Domain Admins] FOR LOGIN [LONDON\Domain Admins]
GO
ALTER ROLE [db_owner] ADD MEMBER [LONDON\Domain Admins]
GO
