USE [BI_Academic]
GO
/****** Object:  StoredProcedure [dbo].[Reports_A134_DelegateBookingStats]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[Reports_A134_DelegateBookingStats]

as

truncate table DW.A134_DelegatesBookingPatterns
insert into DW.A134_DelegatesBookingPatterns
select E.Code, E.Name,  
	sum(case when D.Status = 1919 then 0 else 
			case when D.Create_timestamp >= E.Start_Date then 1 else 0 end end) 'OnDay', 
	sum(case when D.status = 1919 then 0 else
			case when D.Create_timestamp < E.Start_Date then 1 else 0 end end) 'InAdvance',
	sum(case when D.Status = 1919 then 1 else 0 end) 'NoShow',
	sum(1) 'AllDelegates',
	E.Start_Date 'EventDate', lookup_Full_desc 'Category', DEPTNO 'DepNo', DEPNAME 'Department'
from RSMCRM.RSM_Live.dbo.delegate D with(nolock) inner join
RSMCRM.RSM_Live.dbo.Event E with(nolock) on E.Event_Ref = D.Event_Ref inner join
RSMCRM.RSM_Live.dbo.lookup lu on lu.lookup_ref = E.Category inner join
RSMCRM.RSM_Live.ACOCMP1.DEPARTMT DT on DT.DEPNO = E.DeptNo
where D.status in (1916, 1919) and D.Type = 1922
group by E.Code, E.Name, E.Start_Date, lookup_Full_desc, DEPTNO, DEPNAME
 

GO
