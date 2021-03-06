USE [BI_Academic]
GO
/****** Object:  StoredProcedure [DW].[TBuild_CouncilMembers]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [DW].[TBuild_CouncilMembers]
as

--declare
	--@SectionID as int,
	--@FinancialYear as int

--set @SectionID = 670
--set @FinancialYear = 2013

--declare	@StartDate as datetime,
--		@EndDate as datetime

--set @StartDate = (select min(MonthStartDate) from [BI_Reference].LU.TDates where FinancialYear = @FinancialYear)
--set @EndDate = (select Max(MonthEndDate) from [BI_Reference].LU.TDates where FinancialYear = @FinancialYear)

truncate table DW.CouncilMembers

insert into DW.CouncilMembers
select	distinct o.COMPANY_NAME 'Section Name', Member_ref 'Member Ref', c.DISPLAY_NAME 'Member Name', O.company_name,
		Membership_No 'Membership No', Join_Date 'Joined', Leave_Date 'Left',
		isnull(MemberStatus, '') 'Member Status',
		dbo.Reports_properCase(c.JOB_TITLE) 'Position', 
		c.Valid_From 'Position From Date', c.VALID_To 'Position To Date',
		FirstDate 'Joined Council Date',
		dbo.Reports_SelectEmailAddress(c.individual_ref) 'Main Email',
		case when dbo.Reports_SelectEmailAddress(c.individual_ref) = dbo.Reports_SelectSectionEmailAddress(c.individual_ref)
			then '' else  dbo.Reports_SelectSectionEmailAddress(c.individual_ref) end 'Section Email',
		IL.Address1, IL.Address2, IL.Address3, IL.Town, IL.County, IL.PostCode, 
		case when isnull(IL.Country, '.') = '.' then '' else IL.Country end 'Country'
from RSMCRM.RSM_LIVE.dbo.CONTACT c inner join 
RSMCRM.RSM_LIVE.dbo.ORGANISATION o on c.ORGANISATION_REF = o.ORGANISATION_REF left outer join 
(select * from RSMCRM.RSM_LIVE.dbo.TELEPHONE where Main_Number = 'Y')t on c.ORGANISATION_REF = t.ORGANISATION_REF left outer join
RSMCRM.RSM_LIVE.dbo.INDIVIDUAL i on i.INDIVIDUAL_REF = c.INDIVIDUAL_REF left outer join
	(select INDIVIDUAL_REF, ICName, FirstDate, ORGANISATION_REF
from	(select INDIVIDUAL_REF, LOOKUP_FULL_DESC 'ICName', VALID_FROM 'FirstDate'
		from RSMCRM.RSM_LIVE.dbo.v_Attributes 
		where LOOKUP_TYPE_REF = 254 and INDIVIDUAL_REF is not null)AI inner join
(select ORGANISATION_REF, LOOKUP_FULL_DESC 'OCName' 
from RSMCRM.RSM_LIVE.dbo.v_Attributes 
where LOOKUP_TYPE_REF = 254 and ORGANISATION_REF is not null)AO 
												on AO.OCName = AI.ICName)FD on FD.INDIVIDUAL_REF = c.INDIVIDUAL_REF
																			and FD.ORGANISATION_REF = c.ORGANISATION_REF left outer join
(select Member_Ref, Individual_Ref, case when Leave_Date is not null then 'Lapsed' else 
		case when member_status <> 33 then 'Lapsed' else 'Active'  end end 'MemberStatus',
		Leave_Date, Join_Date, Membership_No
from RSMCRM.RSM_LIVE.dbo.member )M on M.Individual_Ref = I.Individual_Ref left outer join
			(Select IL.Individual_Ref, L.Address1, L.Address2, L.Address3, Town, County, PostCode, Country
			from RSMCRM.RSM_LIVE.dbo.INDIVIDUAL_LOC IL  inner join
			RSMCRM.RSM_LIVE.dbo.LOCATION L on L.Location_Ref = IL.Location_Ref
			where IL.Main_Location = 'Y')IL on IL.Individual_Ref = M.Individual_Ref
where	isnull(c.CONTACT_STATUS, 0) in (0, 1513) and isnull(c.TYPE, '2441') = '2441'
		--and isnull(t.type, '2280') = '2280' --and isnull(e.type, '1166') = '1166' 
		and isnull(i.INDIVIDUAL_STATUS, 0) <> 1148 
		and icname is not null
		and c.ORGANISATION_REF in (4,6,8,10,12,14,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,
									102,103,104,105,106,107,108,109,110,111,113,114,115,116,118,119,121,122,123,124,125,670,1217)
		--and (
		--(c.Valid_From < @EndDate and C.Valid_To is null) --scenario1
		--or 
		--(c.Valid_From >= @StartDate and C.Valid_To is null)  --scenario2
		--or 
		--(c.Valid_From < @EndDate and C.Valid_To >= @EndDate) --scenario3
		--or
		--(c.Valid_From>= @StartDate and C.Valid_To <= @EndDate) --scenario4
		--or
		--(c.Valid_From< @EndDate and C.Valid_To > @EndDate)  --scenario5
		--)
		


GO
