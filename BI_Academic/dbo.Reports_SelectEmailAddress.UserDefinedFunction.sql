USE [BI_Academic]
GO
/****** Object:  UserDefinedFunction [dbo].[Reports_SelectEmailAddress]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[Reports_SelectEmailAddress] (@IndividualRef as int)

returns varchar(500)

as

BEGIN

		declare @EmailAddress		varchar(500)


		set @EmailAddress = ''
					
		select  @EmailAddress = E.EMAIL_ADDRESS
		from RSMCRM.RSM_LIVE.dbo.EMAIL E with(nolock) left outer join
			(select INDIVIDUAL_REF, MAX(EMAIL_REF) 'PICKME'
			from RSMCRM.RSM_LIVE.dbo.EMAIL E3 with(nolock) 
			Where E3.type  in (1162,1163,1164,3102,3103) and email_address like '%@%'
			group by INDIVIDUAL_REF
			having sum(case when MAIN_EMAIL ='Y' then 1 else 0 end) < 1)BOB 
				on  BOB.INDIVIDUAL_REF = E.INDIVIDUAL_REF
							and PICKME = E.EMAIL_REF
		WHERE (MAIN_EMAIL = 'Y' OR PICKME IS NOT NULL) AND E.EMAIL_ADDRESS like '%@%'
				AND E.INDIVIDUAL_REF IS NOT NULL
				AND E.Individual_Ref = @IndividualRef

		return @EmailAddress

END

GO
