USE [BI_Academic]
GO
/****** Object:  User [LONDON\SPFarmBI]    Script Date: 07/11/2014 15:17:23 ******/
CREATE USER [LONDON\SPFarmBI] FOR LOGIN [LONDON\SPFarmBI] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_datareader] ADD MEMBER [LONDON\SPFarmBI]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [LONDON\SPFarmBI]
GO
