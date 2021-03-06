USE [BI_Academic]
GO
/****** Object:  UserDefinedFunction [DW].[Fn_JointEventExternal]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



create function [DW].[Fn_JointEventExternal] (@EventRef as int)
returns varchar(1)

	BEGIN
	
		declare @JointExternal as varchar(1)

		set @JointExternal = 'N'

			select @JointExternal = 'Y'
			from RSMCRM.RSM_LIVE.dbo.ATTRIBUTE A 
			where attribute_code in ('JOITE') and Event_Ref = @EventRef
--removed 'INAWE' as per NL email 20121108
		return @JointExternal

	END
GO
