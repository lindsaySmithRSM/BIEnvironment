USE [BI_Academic]
GO
/****** Object:  User [LONDON\LydiGil01]    Script Date: 07/11/2014 15:17:23 ******/
CREATE USER [LONDON\LydiGil01] FOR LOGIN [LONDON\LydiGil01] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_datareader] ADD MEMBER [LONDON\LydiGil01]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [LONDON\LydiGil01]
GO
