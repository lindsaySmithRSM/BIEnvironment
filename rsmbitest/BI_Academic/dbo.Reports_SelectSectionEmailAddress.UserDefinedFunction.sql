USE [BI_Academic]
GO
/****** Object:  UserDefinedFunction [dbo].[Reports_SelectSectionEmailAddress]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[Reports_SelectSectionEmailAddress] (@IndividualRef as int)

returns varchar(500)

as

BEGIN

		declare @EmailAddress		varchar(500)


		set @EmailAddress = ''
					
		select  @EmailAddress = E.EMAIL_ADDRESS --select *
		from RSMCRM.RSM_LIVE.dbo.EMAIL E with(nolock) left outer join
			(select INDIVIDUAL_REF, MAX(EMAIL_REF) 'PICKME'
			from RSMCRM.RSM_LIVE.dbo.EMAIL E3 with(nolock) 
			Where type in (3102, 3103) and isnull(E3.valid_to, getdate()+1) > getdate() 
			group by INDIVIDUAL_REF
			)BOB on  BOB.INDIVIDUAL_REF = E.INDIVIDUAL_REF
						     and PICKME = E.EMAIL_REF
		WHERE (PICKME IS NOT NULL) AND E.EMAIL_ADDRESS like '%@%'
				AND E.INDIVIDUAL_REF IS NOT NULL
				AND E.Individual_Ref = @IndividualRef

		return @EmailAddress

END

GO
