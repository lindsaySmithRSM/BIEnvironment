USE [BI_Academic]
GO
/****** Object:  StoredProcedure [DW].[SSRS_RSMVideosbyMonth]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [DW].[SSRS_RSMVideosbyMonth]
as

select	MonthName, FinancialYear, FinancialPeriod, Type,  
		case when MemberStatus = 'Member' then 'Member' else 'NonMember' end 'MemberStatus', 
		count(MemberRef) 'Delegates', sum(AmountPaid) 'AmountPaid'
from DW.RSMVideosDetailed V inner join
[BI_Reference].LU.TDates T on T.Tdate = V.PurchaseDate
where PurchaseDate <> '13 May 2014'
group by MonthName, FinancialYear, FinancialPeriod, Type,  
		case when MemberStatus = 'Member' then 'Member' else 'NonMember' end
GO
