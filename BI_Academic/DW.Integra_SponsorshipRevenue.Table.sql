USE [BI_Academic]
GO
/****** Object:  Table [DW].[Integra_SponsorshipRevenue]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [DW].[Integra_SponsorshipRevenue](
	[FinancialYear] [int] NULL,
	[SectionName] [varchar](50) NULL,
	[Quarter] [varchar](2) NOT NULL,
	[Event Start] [datetime] NULL,
	[Event End] [datetime] NULL,
	[Event Code] [varchar](20) NULL,
	[Event Name] [varchar](254) NULL,
	[EventDept] [varchar](6) NULL,
	[EventCCNO] [varchar](6) NULL,
	[Session Code] [varchar](20) NULL,
	[Session Name] [varchar](254) NULL,
	[DeptNo] [varchar](6) NULL,
	[CCNO] [varchar](6) NULL,
	[Sponsor Name] [varchar](8000) NULL,
	[Payment Method] [varchar](254) NULL,
	[Sponsorship Type] [varchar](40) NULL,
	[Delegate_Ref] [int] NULL,
	[Sponsorship Value] [float] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
