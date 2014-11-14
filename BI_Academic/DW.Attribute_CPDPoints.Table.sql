USE [BI_Academic]
GO
/****** Object:  Table [DW].[Attribute_CPDPoints]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [DW].[Attribute_CPDPoints](
	[Attribute_Ref] [int] NOT NULL,
	[Event_Ref] [int] NULL,
	[Lookup_full_Desc] [varchar](254) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
