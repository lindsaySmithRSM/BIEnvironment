USE [BI_Academic]
GO
/****** Object:  UserDefinedFunction [DW].[Fn_MembersInSection]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create function [DW].[Fn_MembersInSection] (@DEPNO as varchar(6))
returns int
as

	BEGIN

		Declare @NoOfMembers as int

			set @NoOfMembers = 0

				select @NoOfMembers = count(membership_no)
				from RSMCRM.RSM_LIVE.dbo.organisation O with(nolock) left outer join
				RSMCRM.RSM_LIVE.dbo.contact C with(nolock) on C.Organisation_ref = O.Organisation_ref left outer join
				RSMCRM.RSM_LIVE.dbo.lookup lu with(nolock) on lu.lookup_ref = C.contact_status left outer join
				RSMCRM.RSM_LIVE.ACOCMP1.DEPARTMT D with(nolock) on substring(DEPNAME, 8,len(D.DEPNAME)) = left(O.Company_Name,43) inner join
				RSMCRM.RSM_LIVE.dbo.Member M on M.Individual_ref = C.Individual_Ref
				where (company_name like '%section' or company_name like '%forum') 
					and lu.lookup_full_desc = 'Active' and C.valid_to is null
					and job_title = 'Section Member' and M.Leave_Date is null
					and DEPNO = @DEPNO

		Return @NoOfMembers

	END
--distinct C.Individual_Ref
GO
