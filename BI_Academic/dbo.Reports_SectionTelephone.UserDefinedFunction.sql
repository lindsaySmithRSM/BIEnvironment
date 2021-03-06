USE [BI_Academic]
GO
/****** Object:  UserDefinedFunction [dbo].[Reports_SectionTelephone]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE function [dbo].[Reports_SectionTelephone] (@SectionRef as int)

returns varchar(500)

as

BEGIN

		declare @Telephone		varchar(500)

		set @Telephone = ''
					
		select  @Telephone = E.NUMBER  
		from RSMCRM.RSM_LIVE.dbo.TELEPHONE E with(nolock) left outer join
			(select ORGANISATION_REF, MAX(TELEPHONE_REF) 'PICKME'
			from RSMCRM.RSM_LIVE.dbo.TELEPHONE E3 with(nolock) 
			Where E3.type  in (3099, 3098, 2280) and LEN(replace(NUMBER,' ','')) = 11
			group by ORGANISATION_REF
			having sum(case when MAIN_NUMBER ='Y' then 1 else 0 end) < 1)BOB 
				on  BOB.ORGANISATION_REF = E.ORGANISATION_REF
							and PICKME = E.TELEPHONE_REF 
		WHERE (MAIN_NUMBER = 'Y' OR PICKME IS NOT NULL) AND  LEN(replace(E.NUMBER,' ','')) = 11
				AND E.ORGANISATION_REF IS NOT NULL and E.type  in (3099, 3098, 2280)
				AND E.ORGANISATION_REF = @SectionRef

		return @Telephone

END



GO
