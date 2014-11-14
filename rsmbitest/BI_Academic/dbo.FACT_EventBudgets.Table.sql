USE [BI_Academic]
GO
/****** Object:  Table [dbo].[FACT_EventBudgets]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FACT_EventBudgets](
	[BudgetNLYear] [int] NULL,
	[AccountCode] [varchar](12) NULL,
	[Department] [varchar](6) NULL,
	[Costcentre] [varchar](6) NULL,
	[Budget] [money] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
