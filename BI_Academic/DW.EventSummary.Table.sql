USE [BI_Academic]
GO
/****** Object:  Table [DW].[EventSummary]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [DW].[EventSummary](
	[HostSection] [varchar](50) NULL,
	[DepNo] [varchar](6) NOT NULL,
	[EventName] [varchar](254) NULL,
	[EventDate] [datetime] NULL,
	[EventCode] [varchar](20) NULL,
	[EventRef] [int] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
