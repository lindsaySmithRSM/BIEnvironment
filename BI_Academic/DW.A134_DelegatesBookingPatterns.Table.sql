USE [BI_Academic]
GO
/****** Object:  Table [DW].[A134_DelegatesBookingPatterns]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [DW].[A134_DelegatesBookingPatterns](
	[Code] [varchar](20) NULL,
	[Name] [varchar](254) NULL,
	[OnDay] [int] NULL,
	[InAdvance] [int] NULL,
	[NoShow] [int] NULL,
	[AllDelegates] [int] NULL,
	[EventDate] [datetime] NULL,
	[Category] [varchar](254) NULL,
	[DepNo] [varchar](6) NULL,
	[Department] [varchar](50) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
