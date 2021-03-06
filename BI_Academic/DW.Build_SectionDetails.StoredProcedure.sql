USE [BI_Academic]
GO
/****** Object:  StoredProcedure [DW].[Build_SectionDetails]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




create proc [DW].[Build_SectionDetails]

as

truncate table DW.SectionDetails

insert into DW.SectionDetails
select  Member_Ref 'MemberRef', O.Organisation_Ref 'SectionID', Company_Name 'SectionName', C.Valid_From, C.Valid_To
from RSMCRM.RSM_LIVE.dbo.organisation O with(nolock) left outer join
RSMCRM.RSM_LIVE.dbo.contact C with(nolock) on C.Organisation_ref = O.Organisation_ref left outer join
RSMCRM.RSM_LIVE.dbo.lookup lu with(nolock) on lu.lookup_ref = C.contact_status left outer join
RSMCRM.RSM_LIVE.ACOCMP1.DEPARTMT D with(nolock) on substring(DEPNAME, 8,len(D.DEPNAME)) = O.Company_Name inner join
RSMCRM.RSM_LIVE.dbo.Member M on M.Individual_ref = C.Individual_Ref left outer join
RSMCRM.RSM_LIVE.dbo.Individual I on I.Individual_ref = M.Individual_Ref 
where lu.lookup_full_desc = 'Active' and job_title = 'Section Member' 



GO
