USE [BI_Academic]
GO
/****** Object:  Table [dbo].[FACT_EventBudgetDelegates]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FACT_EventBudgetDelegates](
	[EventCode] [varchar](50) NULL,
	[Delegate] [smallint] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
