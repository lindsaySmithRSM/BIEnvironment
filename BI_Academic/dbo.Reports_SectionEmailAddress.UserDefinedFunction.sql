USE [BI_Academic]
GO
/****** Object:  UserDefinedFunction [dbo].[Reports_SectionEmailAddress]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



create function [dbo].[Reports_SectionEmailAddress] (@SectionRef as int)

returns varchar(500)

as

BEGIN

		declare @EmailAddress		varchar(500)

		set @EmailAddress = ''
					
		select  @EmailAddress = E.EMAIL_ADDRESS
		from RSMCRM.RSM_LIVE.dbo.EMAIL E with(nolock) left outer join
			(select ORGANISATION_REF, MAX(EMAIL_REF) 'PICKME'
			from RSMCRM.RSM_LIVE.dbo.EMAIL E3 with(nolock) 
			Where E3.type  in (1163) and email_address like '%@%'
			group by ORGANISATION_REF
			having sum(case when MAIN_EMAIL ='Y' then 1 else 0 end) < 1)BOB 
				on  BOB.ORGANISATION_REF = E.ORGANISATION_REF
							and PICKME = E.EMAIL_REF 
		WHERE (MAIN_EMAIL = 'Y' OR PICKME IS NOT NULL) AND E.EMAIL_ADDRESS like '%@%'
				AND E.ORGANISATION_REF IS NOT NULL
				AND E.Organisation_Ref = @SectionRef

		return @EmailAddress

END



GO
