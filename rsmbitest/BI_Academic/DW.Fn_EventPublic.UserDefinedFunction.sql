USE [BI_Academic]
GO
/****** Object:  UserDefinedFunction [DW].[Fn_EventPublic]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create function [DW].[Fn_EventPublic] (@EventRef as int)
returns varchar(1)
as


	BEGIN
	
		declare @Public as varchar(1)

		set @Public = 'N'


			select @Public = 'Y'
			from RSMCRM.RSM_LIVE.dbo.Attribute
			where Attribute_code = 'OFITP' and Event_Ref = @EventRef

		return @Public

	END
GO
