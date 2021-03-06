USE [BI_Academic]
GO
/****** Object:  Table [DW].[Audit_FinancialActuals]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [DW].[Audit_FinancialActuals](
	[ChildEventCode] [varchar](5) NULL,
	[ActualAmount] [numeric](28, 4) NULL,
	[ActualSponsor] [numeric](28, 4) NULL,
	[Trandate] [datetime] NULL,
	[NLYear] [int] NULL,
	[NLPeriod] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
