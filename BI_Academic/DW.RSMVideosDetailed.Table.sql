USE [BI_Academic]
GO
/****** Object:  Table [DW].[RSMVideosDetailed]    Script Date: 07/11/2014 15:17:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [DW].[RSMVideosDetailed](
	[PurchaseDate] [datetime] NULL,
	[EventCode] [varchar](20) NULL,
	[EventName] [varchar](254) NULL,
	[DelegateName] [varchar](254) NULL,
	[EmailAddress] [varchar](500) NULL,
	[Type] [varchar](5) NOT NULL,
	[MemberRef] [int] NULL,
	[MembershipNo] [varchar](20) NOT NULL,
	[MemberStatus] [varchar](9) NOT NULL,
	[Joined] [datetime] NULL,
	[Left] [datetime] NULL,
	[AmountPaid] [float] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
