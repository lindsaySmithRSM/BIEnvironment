USE [BI_Academic]
GO
/****** Object:  StoredProcedure [DW].[TBuild_EventOTDForm]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [DW].[TBuild_EventOTDForm]
as

truncate table DW.EventOTDForm
insert into DW.EventOTDForm
select distinct replace(Replace(HostSection,' : ',''), DepNo, '') 'HostSection', 
		EventName, EventDate, EventCode, E3.Organisation_Ref, E.EventRef,
		'' 'SectionEmail', 
		'' 'SectionWeb', 
		'' 'SectionFax',
		'' 'SectionTelephone',
		Coordinator,
		'' 'Venue'
from DW.EventSummary E left outer join
	(select event_ref, lookup_full_desc, detail 'Coordinator', lookup_type_ref, Lookup_code
	from RSMCRM.RSM_LIVE.dbo.attribute A inner join
	RSMCRM.RSM_LIVE.dbo.lookup lu on lu.lookup_ref = attr_code_ref
	where lookup_type_ref = 281 and Lookup_code = 'EVEC')ECO on ECO.Event_Ref = E.Eventref left outer join
(select Organisation_Ref, Detail 'OrgDept'
		from RSMCRM.RSM_LIVE.dbo.attribute
		)A on A.OrgDept = E.DepNo left outer join
RSMCRM.RSM_LIVE.dbo.Organisation E3 with(nolock) on E3.Organisation_Ref = A.Organisation_Ref

--create index IX_OTDForm_OrgRef on DW.EventOTDForm (Organisation_Ref)
--create index IX_OTDForm_EventRef on DW.EventOTDForm (EventRef)

update  DW.EventOTDForm set SectionEmail = dbo.Reports_SectionEmailAddress(Organisation_Ref) 
update  DW.EventOTDForm set	SectionWeb = dbo.Reports_SectionWebsite(Organisation_Ref) 
update  DW.EventOTDForm set	SectionFax = dbo.Reports_SectionFax(Organisation_Ref) 
update  DW.EventOTDForm set	SectionTelephone = dbo.Reports_SectionTelephone(Organisation_Ref) 
update  DW.EventOTDForm set	Venue = dbo.Reports_SessionVenue(EventRef)

--create index IX_OTDForm_EventCode on DW.EventOTDForm (EventCode)


update DW.EventOTDForm 
set SectionFax = case when isnull(sectionfax,'') = '' then '' else '('+left(replace(sectionfax,' ',''),1)+') '+substring(replace(sectionfax,' ',''),2,2)+' '+substring(replace(sectionfax,' ',''),3,4)+' '+substring(replace(sectionfax,' ',''),8,4) end,
	SectionTelephone = case when isnull(sectiontelephone,'') = '' then '' else '('+left(replace(sectiontelephone,' ',''),1)+') '+substring(replace(sectiontelephone,' ',''),2,2)+' '+substring(replace(sectiontelephone,' ',''),3,4)+' '+substring(replace(sectiontelephone,' ',''),8,4) end

update DW.EventOTDForm
set SectionWeb = 'www.rsm.ac.uk/events'
where isnull(SectionWeb, '') = ''


truncate table DW.EventOTDRates
insert into DW.EventOTDRates
select distinct EventRef, RateName +': £'+cast(RateValue as varchar) 'RateDetails',
dense_rank() OVER (Partition by EventRef Order By SessionName, RateName +': £'+cast(RateValue as varchar)) 'Rank'
from Reports_EventRatesAvailable
order by EventRef, RateName +': £'+cast(RateValue as varchar)

GO
