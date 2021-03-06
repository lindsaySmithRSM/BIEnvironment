USE [BI_Academic]
GO
/****** Object:  Table [DW].[FA1_DelegateCounts]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [DW].[FA1_DelegateCounts](
	[Code] [varchar](20) NULL,
	[NumberOfDelegates] [numeric](38, 2) NULL,
	[NoShow] [numeric](38, 2) NULL,
	[AllDelegates] [numeric](38, 2) NULL,
	[BudgetDelegates] [smallint] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_FA1_DelegateCounts]    Script Date: 07/11/2014 15:17:24 ******/
CREATE NONCLUSTERED INDEX [IX_FA1_DelegateCounts] ON [DW].[FA1_DelegateCounts]
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
