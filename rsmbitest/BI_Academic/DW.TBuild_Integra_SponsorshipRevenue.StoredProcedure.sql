USE [BI_Academic]
GO
/****** Object:  StoredProcedure [DW].[TBuild_Integra_SponsorshipRevenue]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [DW].[TBuild_Integra_SponsorshipRevenue]
as

truncate table DW.Integra_SponsorshipRevenue

insert into DW.Integra_SponsorshipRevenue
select  
	/*case when Month(E.Start_Date) in (10,11,12) then Year(E.Start_Date)+1 else Year(E.Start_Date) end 'Financial Year',  
	dep.DEPNAME 'Section Name',
	case when Month(E.Start_Date) in (10,11,12) then 'Q1' else
		case when Month(E.Start_Date) in (1,2,3) then 'Q2' else
			case when Month(E.Start_Date) in (4,5,6) then 'Q3' else 'Q4' end end end 'Quarter',
	E.Start_Date 'Event Start', E.Code 'Event Code', E.Name 'Event Name',  
	dbo.Reports_properCase(D.Name) 'Sponsor Name', Max(ER.Description) 'Sponsorship Type',
	Max(dbo.Reports_SponsorshipValue(d.Delegate_Ref)) 'SponsorshipValue'*/
	distinct case when Month(E.Start_Date) in (10,11,12) then Year(E.Start_Date)+1 else Year(E.Start_Date) end 'FinancialYear',  
	dep.DEPNAME 'SectionName',
	case when Month(E.Start_Date) in (10,11,12) then 'Q1' else
		case when Month(E.Start_Date) in (1,2,3) then 'Q2' else
			case when Month(E.Start_Date) in (4,5,6) then 'Q3' else 'Q4' end end end 'Quarter',
	E.Start_Date 'Event Start', E.End_Date 'Event End',E.Code 'Event Code', E.Name 'Event Name',  E.DeptNo 'EventDept', 
	E.CCNO 'EventCCNO',
	S.Code 'Session Code', S.Name 'Session Name', S.DeptNo, S.CCNO,
	dbo.Reports_properCase(D.Name) 'Sponsor Name', PM.Lookup_full_desc 'Payment Method',
	Max(ER.Description) 'Sponsorship Type',D.Delegate_Ref,
	Max(dbo.Reports_SponsorshipValue(d.Delegate_Ref)) 'Sponsorship Value'
from RSMCRM.RSM_Live.dbo.[Event] E inner join
RSMCRM.RSM_Live.dbo.Session S on S.Event_Ref = E.Event_Ref left outer join
RSMCRM.RSM_Live.dbo.Delegate_Session DS on DS.Session_Ref = S.Session_Ref left outer join
RSMCRM.RSM_Live.dbo.Delegate D on D.Delegate_Ref = DS.Delegate_Ref left outer join
RSMCRM.RSM_Live.dbo.lookup PM on PM.lookup_ref = D.Pay_Method left outer join
RSMCRM.RSM_Live.dbo.EVENT_RATE ER on ER.Event_Rate_ref = DS.Event_Rate_Ref left outer join
RSMCRM.RSM_Live.ACOCMP1.DEPARTMT dep on dep.DEPNO = E.DeptNo
where S.Name = 'Sponsorship'  and isnull(dbo.Reports_SponsorshipValue(d.Delegate_Ref) , 0)<> 0
group by case when Month(E.Start_Date) in (10,11,12) then Year(E.Start_Date)+1 else Year(E.Start_Date) end,  
	dep.DEPNAME,
	case when Month(E.Start_Date) in (10,11,12) then 'Q1' else
		case when Month(E.Start_Date) in (1,2,3) then 'Q2' else
			case when Month(E.Start_Date) in (4,5,6) then 'Q3' else 'Q4' end end end,
	E.Start_Date, E.End_Date, 
	E.Code, E.Name,  E.DeptNo, E.CCNO, 
	S.Code, S.Name, S.DeptNo, S.CCNO,
	dbo.Reports_properCase(D.Name), PM.Lookup_full_desc,D.Delegate_Ref

GO
