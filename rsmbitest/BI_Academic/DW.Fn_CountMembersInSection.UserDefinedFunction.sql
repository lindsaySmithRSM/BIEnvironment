USE [BI_Academic]
GO
/****** Object:  UserDefinedFunction [DW].[Fn_CountMembersInSection]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create function [DW].[Fn_CountMembersInSection] (@DEPNO as varchar(6))
returns int
as

	BEGIN

		Declare @NoOfMembers as int

			set @NoOfMembers = 0

				select @NoOfMembers = SectionMembers --select *
				from DW.SectionMembersCount
				where DEPNO = @DEPNO

		Return @NoOfMembers

	END

GO
