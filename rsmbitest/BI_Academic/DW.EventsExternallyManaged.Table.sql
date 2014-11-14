USE [BI_Academic]
GO
/****** Object:  Table [DW].[EventsExternallyManaged]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [DW].[EventsExternallyManaged](
	[event_ref] [int] NOT NULL,
	[EventCode] [varchar](20) NULL,
	[lookup_full_desc] [varchar](254) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
