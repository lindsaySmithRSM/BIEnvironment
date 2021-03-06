USE [BI_Academic]
GO
/****** Object:  StoredProcedure [DW].[TBuild_CouncilMembersAttendance]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [DW].[TBuild_CouncilMembersAttendance]
as


--	1	GET LIST OF MEETINGS PER SECTION	
--drop table #CouncilEvents
select distinct DepNo, EventDate, EventCode
into #CouncilEvents
from [DW].[EventDetails]
where len(eventcode) > 5 


--	2	GET LIST OF COUNCIL MEMBERS
--drop table #CouncilMembers
select distinct M.Member_Ref, A.detail, Join_Date, Leave_Date, Display_name, Job_title, C.valid_from, C.valid_to 
into #CouncilMembers
from RSMCRM.RSM_Live.dbo.Member M left outer join 
RSMCRM.RSM_Live.dbo.Contact C on C.Individual_ref = M.Individual_Ref inner join
RSMCRM.RSM_Live.dbo.Organisation O on O.Organisation_Ref = C.Organisation_Ref inner join
RSMCRM.RSM_Live.dbo.attribute A with(nolock) 	on A.Organisation_Ref = O.ORganisation_Ref
												and A.code_type = 290 
where O.ORGANISATION_REF in (4,6,8,10,11, 12,14,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,
										102,103,104,105,106,107,108,109,110,111,113,114,115,116,117,118,119,120,121,122,123,124,125,670,1217)

--	3	COMBINE COUNCIL MEMBERS AND EVENTS TO FORM ROLL CALL LIST
truncate table DW.CouncilMembersAttendance
insert into DW.CouncilMembersAttendance
select distinct DepNo, EventDate, Member_Ref, CE.EventCode, 0 'Attended', '' 'MemberName' ,Job_Title 'Position', '' 'SectionName'
from #CouncilEvents CE inner join
#CouncilMembers CM on CM.detail = CE.DepNo
where CE.EventDate between Join_Date and isnull(Leave_Date, dateadd(y, 1, getdate()))
	and CE.EventDate between CM.Valid_From and CM.Valid_To
union all
select	A1.Detail 'DepNo', A.MeetingDate, A.MemberRef, '' 'EventCode', isnull(A.Attended, 0) 'Attended', '', Job_Title, ''
from [SD].[CouncilAttendance2012] A  inner join
RSMCRM.RSM_Live.dbo.Member M on M.Member_Ref = A.MemberRef inner join
RSMCRM.RSM_Live.dbo.attribute A1 with(nolock) 	on A1.Organisation_Ref = A.SectionRef
												and A1.code_type = 290 inner join
#CouncilMembers CM on CM.Member_Ref = A.MemberRef	
					and A.MeetingDate between CM.Join_Date and isnull(CM.Leave_Date, dateadd(y, 1, getdate()))
					and A.MeetingDate between CM.Valid_From and CM.Valid_To


--	4	UPDATE ATTENDANCE
update DW.CouncilMembersAttendance 
set Attended = 1
from DW.CouncilMembersAttendance MA inner join
(select distinct Member_Ref, E.Code
from RSMCRM.RSM_LIVE.dbo.delegate D with(nolock) left outer join
RSMCRM.RSM_LIVE.dbo.Event E with(nolock) on E.Event_Ref = D.Event_Ref 
where len(E.Code) > 5)ATT on ATT.Member_Ref = MA.Member_Ref
						and ATT.Code = MA.EventCode
where Attended = 0

--	5	UPDATE MEMBER NAME
update DW.CouncilMembersAttendance 
set MemberName = Account_Name
from DW.CouncilMembersAttendance A inner join
RSMCRM.RSM_Live.dbo.Member M on A.Member_Ref = M.Member_Ref

--	6	UPDATE SECTION NAME
update DW.CouncilMembersAttendance 
set SectionName = Company_Name
from DW.CouncilMembersAttendance A inner join
(select distinct A.Detail, Company_Name
from RSMCRM.RSM_Live.dbo.Organisation O inner join
RSMCRM.RSM_Live.dbo.attribute A with(nolock) 	on A.Organisation_Ref = O.ORganisation_Ref
												and A.code_type = 290 )B on B.Detail = A.DepNo





GO
