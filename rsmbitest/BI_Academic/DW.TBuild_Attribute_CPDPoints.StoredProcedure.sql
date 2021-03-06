USE [BI_Academic]
GO
/****** Object:  StoredProcedure [DW].[TBuild_Attribute_CPDPoints]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [DW].[TBuild_Attribute_CPDPoints]
as

		truncate table DW.Attribute_CPDPoints

		insert into DW.Attribute_CPDPoints

		select Attribute_Ref, Event_Ref, Lookup_full_Desc
		from RSMCRM.RSM_Live.dbo.attribute A with(nolock) inner join
		RSMCRM.RSM_Live.dbo.lookup lu with(nolock) on lu.lookup_ref = a.attr_code_ref 
		where lookup_type_ref = 202 
GO
