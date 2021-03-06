USE [BI_Academic]
GO
/****** Object:  Table [dbo].[Reports_EventEvaluation]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Reports_EventEvaluation](
	[EventCode] [varchar](50) NULL,
	[Name] [varchar](254) NULL,
	[Start_Date] [datetime] NULL,
	[DeptNo] [varchar](6) NULL,
	[R1] [int] NULL,
	[R2] [int] NULL,
	[R3] [int] NULL,
	[R4] [int] NULL,
	[R5] [int] NULL,
	[O1] [int] NULL,
	[O2] [int] NULL,
	[O3] [int] NULL,
	[O4] [int] NULL,
	[O5] [int] NULL,
	[Responses] [int] NULL,
	[Speakers] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
