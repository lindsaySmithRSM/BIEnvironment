USE [BI_Academic]
GO
/****** Object:  StoredProcedure [DW].[TBuild_PublicEngagementMeetings]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [DW].[TBuild_PublicEngagementMeetings]
as

truncate table DW.PublicEngatementMeeting
insert into DW.PublicEngatementMeeting
select  cast(sum(1) as float)/cast(count(distinct E.Code) as float) 'AveDelegates', count(distinct E.Code) 'NoMeetings',
	case when month(E.Start_Date) >= 10 then year(E.Start_Date )+1 else year(E.Start_Date) end 'FinancialYear'
from RSMCRM.RSM_LIVE.dbo.delegate D with(nolock) left outer join
RSMCRM.RSM_LIVE.dbo.Event E with(nolock) on E.Event_Ref = D.Event_Ref inner join
RSMCRM.RSM_LIVE.dbo.lookup lu on lu.lookup_ref = E.Category inner join
RSMCRM.RSM_LIVE.ACOCMP1.DEPARTMT DT on DT.DEPNO = E.DeptNo left outer join
RSMCRM.RSM_LIVE.dbo.lookup ES with (nolock) on ES.lookup_ref = e.status 
where isnull(D.status, 1916)  in (1916, 1919) and isnull(D.Type, 1922) = 1922 
		and case when month(E.Start_Date) >= 10 then year(E.Start_Date )+1 else year(E.Start_Date) end 
			 between case when month(getdate()) >= 10 then year(getdate() )+1 else year(getdate()) end -3
				and case when month(getdate()) >= 10 then year(getdate() )+1 else year(getdate()) end
	and isnull(lu.lookup_full_desc, '') in ('Public Engagement', 'Public Engagement - Externally Managed')
	and isnull(ES.lookup_full_desc, 'Active') in ('Active', 'Closed')	
group by case when month(E.Start_Date) >= 10 then year(E.Start_Date )+1 else year(E.Start_Date) end 
order by FinancialYear

GO
