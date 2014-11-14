USE [BI_Academic]
GO
/****** Object:  Table [DW].[CPDEvents]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [DW].[CPDEvents](
	[event_ref] [int] NULL,
	[Code] [varchar](20) NULL,
	[EventDate] [datetime] NULL,
	[CPDPoints] [varchar](8000) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
