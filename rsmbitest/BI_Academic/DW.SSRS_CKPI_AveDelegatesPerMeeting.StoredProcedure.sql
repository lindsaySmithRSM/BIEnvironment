USE [BI_Academic]
GO
/****** Object:  StoredProcedure [DW].[SSRS_CKPI_AveDelegatesPerMeeting]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [DW].[SSRS_CKPI_AveDelegatesPerMeeting]
as

select  *
from DW.AverageDelegatesPerMeeting
where financialyear between case when month(getdate())>=10 then year(getdate())-2 else year(getdate())-3 end	
					and case when month(getdate())>=10 then year(getdate())+1 else year(getdate()) end	
order by FinancialYear




GO
