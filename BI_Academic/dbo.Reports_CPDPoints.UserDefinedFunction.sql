USE [BI_Academic]
GO
/****** Object:  UserDefinedFunction [dbo].[Reports_CPDPoints]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create function [dbo].[Reports_CPDPoints] (@EventRef as varchar(6))
returns varchar(20)

	BEGIN

		Declare @CPDPoints as varchar(20)


		select @CPDPoints =
			case when lookup_full_desc like '%CPD Points' then replace(lookup_full_desc, ' CPD Points','') else 
				case when lookup_full_desc like '%CPD Point' then replace(lookup_full_desc, ' CPD Point','') else 
					case when lookup_full_desc like '%CPD - Applied for%' then replace(lookup_full_desc, 'CPD - ','') else 
					case when lookup_full_desc like '%Other (please specify)' then replace(Detail, ' CPD Points','') else lookup_full_desc end end end end
		from RSMCRM.RSM_Live.dbo.attribute A with(nolock) inner join
		RSMCRM.RSM_Live.dbo.lookup lu with(nolock) on lu.lookup_ref = a.attr_code_ref 
		where lookup_type_ref = 202 and A.Event_Ref = @EventRef
	
		Return @CPDPoints

	END




GO
