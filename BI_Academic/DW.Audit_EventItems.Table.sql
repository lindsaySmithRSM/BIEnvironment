USE [BI_Academic]
GO
/****** Object:  Table [DW].[Audit_EventItems]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [DW].[Audit_EventItems](
	[EventDate] [datetime] NULL,
	[EventStatus] [varchar](254) NULL,
	[DelegateCount] [numeric](38, 2) NOT NULL,
	[NoShow] [numeric](38, 2) NOT NULL,
	[BudgetDelegates] [smallint] NOT NULL,
	[LeadEventCode] [varchar](20) NULL,
	[EventCodeLink] [varchar](5) NULL,
	[Department] [varchar](50) NULL,
	[MeetingType] [varchar](20) NULL,
	[ProgrammeKPI] [varchar](11) NOT NULL,
	[CPDPoints] [varchar](20) NULL,
	[JointSession] [varchar](1) NULL,
	[MOForm] [varchar](11) NULL,
	[YearCode] [varchar](1) NULL,
	[Presentation] [money] NULL,
	[Usefulness] [money] NULL,
	[AdverseReason] [varchar](254) NOT NULL,
	[Adverse] [varchar](1) NULL,
	[Relevance] [money] NULL,
	[Objectives] [money] NULL,
	[Event_Ref] [int] NULL,
	[PublicInterest] [varchar](1) NULL,
	[SectionMembers] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
