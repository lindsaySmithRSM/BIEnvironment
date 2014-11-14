USE [BI_Academic]
GO
/****** Object:  Table [DW].[Audit_Budgets]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [DW].[Audit_Budgets](
	[EventCodeLink] [varchar](5) NULL,
	[Budget] [float] NULL,
	[BudgetSponsor] [float] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
