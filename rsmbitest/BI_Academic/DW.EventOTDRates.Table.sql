USE [BI_Academic]
GO
/****** Object:  Table [DW].[EventOTDRates]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [DW].[EventOTDRates](
	[EventRef] [int] NULL,
	[RateDetails] [varchar](73) NULL,
	[Rank] [bigint] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
