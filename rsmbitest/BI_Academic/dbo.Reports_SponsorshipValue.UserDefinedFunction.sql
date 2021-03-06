USE [BI_Academic]
GO
/****** Object:  UserDefinedFunction [dbo].[Reports_SponsorshipValue]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[Reports_SponsorshipValue] (@DelegateRef as int)
returns float
as


BEGIN
	
	DECLARE @SponsorValue as float

	set @SponsorValue =
		(select SUM(QUANTITY * UNIT_PRICE)
		from RSMCRM.RSM_Live.dbo.Delegate D inner join
		RSMCRM.RSM_Live.dbo.OPACIF O on O.Source_Ref = D.Delegate_Ref
				and O.Member_Ref = D.Member_Ref  inner join
		RSMCRM.RSM_Live.dbo.OPACIF_DETAIL OD on OD.OPACIF_REF = O.OPACIF_REF
		where D.Delegate_Ref = @DelegateRef )

	return @SponsorValue

END

GO
