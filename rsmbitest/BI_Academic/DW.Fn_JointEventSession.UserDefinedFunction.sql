USE [BI_Academic]
GO
/****** Object:  UserDefinedFunction [DW].[Fn_JointEventSession]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



create function [DW].[Fn_JointEventSession] (@EventRef as int)
returns varchar(1)

	BEGIN
	
		declare @JointSession as varchar(1)

		set @JointSession = 'N'

			select @JointSession = 'Y'
			from RSMCRM.RSM_LIVE.dbo.session S with(nolock)
			where S.name like 'Joint RSM event transfer%' and S.Allow_Bookings = 'Y' and Event_Ref = @EventRef

		return @JointSession

	END
GO
