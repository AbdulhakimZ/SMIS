USE [master]
GO
/****** Object:  Database [SMS]    Script Date: 8/11/2022 6:38:45 PM ******/
CREATE DATABASE [SMS]
EXEC [SMS].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SMS] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SMS] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SMS] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SMS] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SMS] SET ARITHABORT OFF 
GO
ALTER DATABASE [SMS] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SMS] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SMS] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SMS] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SMS] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SMS] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SMS] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SMS] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SMS] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SMS] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SMS] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SMS] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SMS] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SMS] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SMS] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SMS] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SMS] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SMS] SET RECOVERY FULL 
GO
ALTER DATABASE [SMS] SET  MULTI_USER 
GO
ALTER DATABASE [SMS] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SMS] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SMS] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SMS] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [SMS] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [SMS] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'SMS', N'ON'
GO
ALTER DATABASE [SMS] SET QUERY_STORE = OFF
GO
USE [SMS]
GO
/****** Object:  Table [dbo].[Account]    Script Date: 8/11/2022 6:38:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[SysId] [int] IDENTITY(1,1) NOT NULL,
	[TeacherID] [int] NULL,
	[StudentID] [int] NULL,
	[Password] [nvarchar](200) NULL,
	[RoleID] [int] NULL,
	[CreatedBy] [int] NULL,
	[IsDeleted] [int] NULL,
	[Salt] [nvarchar](200) NULL,
 CONSTRAINT [PK_Account] PRIMARY KEY CLUSTERED 
(
	[SysId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Assesment]    Script Date: 8/11/2022 6:38:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Assesment](
	[SysId] [int] IDENTITY(1,1) NOT NULL,
	[Id] [nvarchar](50) NULL,
	[Type] [int] NULL,
	[Time] [time](7) NULL,
	[GivenDate] [date] NULL,
	[DeadLine] [date] NULL,
	[SectionID] [int] NULL,
	[DepartmentID] [int] NULL,
	[CourseID] [int] NULL,
	[YearID] [int] NULL,
	[Title] [nvarchar](50) NULL,
	[Description] [ntext] NULL,
	[TotalMark] [nvarchar](50) NULL,
	[CreatedBy] [int] NULL,
	[IsDeleted] [int] NOT NULL,
	[Attachment] [nvarchar](200) NULL,
 CONSTRAINT [PK_Assesment] PRIMARY KEY CLUSTERED 
(
	[SysId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AssesmentTypes]    Script Date: 8/11/2022 6:38:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AssesmentTypes](
	[SysId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
 CONSTRAINT [PK_AssasementTypes] PRIMARY KEY CLUSTERED 
(
	[SysId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Course]    Script Date: 8/11/2022 6:38:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Course](
	[SysId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[YearId] [int] NULL,
	[CreatedBy] [int] NULL,
	[IsDeleted] [int] NULL,
	[DepartmentID] [int] NULL,
 CONSTRAINT [PK_Subjects] PRIMARY KEY CLUSTERED 
(
	[SysId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Department]    Script Date: 8/11/2022 6:38:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Department](
	[SysId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
 CONSTRAINT [PK_Department] PRIMARY KEY CLUSTERED 
(
	[SysId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MenuItems]    Script Date: 8/11/2022 6:38:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MenuItems](
	[SysId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Link] [nvarchar](100) NULL,
	[Icon] [nvarchar](50) NULL,
 CONSTRAINT [PK_MenuItems] PRIMARY KEY CLUSTERED 
(
	[SysId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Messages]    Script Date: 8/11/2022 6:38:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Messages](
	[SysId] [int] IDENTITY(1,1) NOT NULL,
	[From] [nvarchar](50) NULL,
	[ToStudents] [int] NULL,
	[ToTeachers] [int] NULL,
	[Subject] [nvarchar](200) NULL,
	[Body] [ntext] NULL,
	[Status] [int] NULL,
	[IsDeleted] [int] NULL,
 CONSTRAINT [PK_Messages] PRIMARY KEY CLUSTERED 
(
	[SysId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Results]    Script Date: 8/11/2022 6:38:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Results](
	[SysId] [int] IDENTITY(1,1) NOT NULL,
	[AssessmentID] [int] NULL,
	[StudentID] [int] NULL,
	[Mark] [nvarchar](50) NULL,
	[CreatedBy] [int] NULL,
	[IsDeleted] [int] NULL,
 CONSTRAINT [PK_Results] PRIMARY KEY CLUSTERED 
(
	[SysId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 8/11/2022 6:38:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[SysId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED 
(
	[SysId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RoleMenu]    Script Date: 8/11/2022 6:38:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoleMenu](
	[SysId] [int] IDENTITY(1,1) NOT NULL,
	[RoleId] [int] NULL,
	[MenuId] [int] NULL,
	[IsDeleted] [int] NULL,
	[CreatedBy] [int] NULL,
 CONSTRAINT [PK_RoleMenu] PRIMARY KEY CLUSTERED 
(
	[SysId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sections]    Script Date: 8/11/2022 6:38:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sections](
	[SysId] [int] IDENTITY(1,1) NOT NULL,
	[Value] [nvarchar](50) NULL,
	[YearId] [int] NULL,
	[CreatedBy] [int] NULL,
	[IsDeleted] [int] NULL,
 CONSTRAINT [PK_Sections] PRIMARY KEY CLUSTERED 
(
	[SysId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Students]    Script Date: 8/11/2022 6:38:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Students](
	[SysId] [int] IDENTITY(1,1) NOT NULL,
	[Id] [nvarchar](50) NULL,
	[FirstName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NULL,
	[FullName]  AS (([FirstName]+' ')+[LastName]) PERSISTED,
	[UserName] [nvarchar](50) NULL,
	[Email] [nvarchar](50) NULL,
	[Phone] [nvarchar](50) NULL,
	[Password] [nvarchar](50) NULL,
	[SectionID] [int] NULL,
	[YearID] [int] NULL,
	[CreatedBy] [int] NULL,
	[IsDeleted] [int] NULL,
	[Role] [int] NULL,
	[Photo] [nvarchar](50) NULL,
	[DepartmentID] [int] NULL,
 CONSTRAINT [PK_Students] PRIMARY KEY CLUSTERED 
(
	[SysId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SubmitAssignment]    Script Date: 8/11/2022 6:38:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SubmitAssignment](
	[SysId] [int] IDENTITY(1,1) NOT NULL,
	[StudentId] [int] NULL,
	[AssesmentId] [int] NULL,
	[FilePath] [nvarchar](150) NULL,
	[SubmissionDate] [datetime] NULL,
 CONSTRAINT [PK_SubmitAssignment] PRIMARY KEY CLUSTERED 
(
	[SysId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SuperAdmin]    Script Date: 8/11/2022 6:38:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SuperAdmin](
	[SysId] [int] NOT NULL,
	[UserName] [nvarchar](50) NULL,
	[Password] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[IsDeleted] [int] NULL,
 CONSTRAINT [PK_SuperAdmin] PRIMARY KEY CLUSTERED 
(
	[SysId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Teachers]    Script Date: 8/11/2022 6:38:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Teachers](
	[SysId] [int] IDENTITY(1,1) NOT NULL,
	[Id] [nvarchar](50) NULL,
	[FirstName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NULL,
	[FullName]  AS (([FirstName]+' ')+[LastName]) PERSISTED,
	[Email] [nvarchar](50) NULL,
	[Role] [int] NULL,
	[Photo] [nvarchar](250) NULL,
	[Password] [nvarchar](200) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[IsDeleted] [int] NULL,
 CONSTRAINT [PK_Teachers] PRIMARY KEY CLUSTERED 
(
	[SysId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Teaches]    Script Date: 8/11/2022 6:38:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Teaches](
	[SysId] [int] IDENTITY(1,1) NOT NULL,
	[TeacherId] [int] NULL,
	[CourseId] [int] NULL,
	[DepartmentId] [int] NULL,
	[YearId] [int] NULL,
	[SectionId] [int] NULL,
 CONSTRAINT [PK_Teaches] PRIMARY KEY CLUSTERED 
(
	[SysId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Year]    Script Date: 8/11/2022 6:38:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Year](
	[SysId] [int] IDENTITY(1,1) NOT NULL,
	[Value] [nvarchar](50) NULL,
	[CreatedBy] [int] NULL,
	[IsDeleted] [int] NULL,
 CONSTRAINT [PK_Year] PRIMARY KEY CLUSTERED 
(
	[SysId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Account] ON 
GO
INSERT [dbo].[Account] ([SysId], [TeacherID], [StudentID], [Password], [RoleID], [CreatedBy], [IsDeleted], [Salt]) VALUES (2, 1, NULL, N'ezG2AQ22CWXx1po2WQ2Fgf7I9JSVjgJZzEGuZZzNMRw=', 1, NULL, 0, N'4ZuI7LcSuonbeA==')
GO
INSERT [dbo].[Account] ([SysId], [TeacherID], [StudentID], [Password], [RoleID], [CreatedBy], [IsDeleted], [Salt]) VALUES (3, 3, NULL, N'X1RiWCRv4Zon+iwTvlzqoWTp3bKEn23QfhhZ7XJP2pE=', 1, NULL, 0, N'enuhjs0COXrWZQ==')
GO
INSERT [dbo].[Account] ([SysId], [TeacherID], [StudentID], [Password], [RoleID], [CreatedBy], [IsDeleted], [Salt]) VALUES (5, NULL, 2, N'OEbZjU1pGEfZ3iQMEiPwytFfvCA1K7rk42Mw1bnCJFE=', 2, NULL, 0, N'4oIUFEmAsIm3MVp16IJlR5CUfx0=')
GO
INSERT [dbo].[Account] ([SysId], [TeacherID], [StudentID], [Password], [RoleID], [CreatedBy], [IsDeleted], [Salt]) VALUES (6, NULL, 3, N'OEbZjU1pGEfZ3iQMEiPwytFfvCA1K7rk42Mw1bnCJFE=', 2, NULL, 0, N'4oIUFEmAsIm3MVp16IJlR5CUfx0=')
GO
INSERT [dbo].[Account] ([SysId], [TeacherID], [StudentID], [Password], [RoleID], [CreatedBy], [IsDeleted], [Salt]) VALUES (7, NULL, 9, N'OEbZjU1pGEfZ3iQMEiPwytFfvCA1K7rk42Mw1bnCJFE=', 2, NULL, 0, N'4oIUFEmAsIm3MVp16IJlR5CUfx0=')
GO
INSERT [dbo].[Account] ([SysId], [TeacherID], [StudentID], [Password], [RoleID], [CreatedBy], [IsDeleted], [Salt]) VALUES (8, NULL, 4, N'OEbZjU1pGEfZ3iQMEiPwytFfvCA1K7rk42Mw1bnCJFE=', 2, NULL, 0, N'4oIUFEmAsIm3MVp16IJlR5CUfx0=')
GO
INSERT [dbo].[Account] ([SysId], [TeacherID], [StudentID], [Password], [RoleID], [CreatedBy], [IsDeleted], [Salt]) VALUES (9, NULL, 11, N'OEbZjU1pGEfZ3iQMEiPwytFfvCA1K7rk42Mw1bnCJFE=', 2, 1, 0, N'4oIUFEmAsIm3MVp16IJlR5CUfx0=')
GO
INSERT [dbo].[Account] ([SysId], [TeacherID], [StudentID], [Password], [RoleID], [CreatedBy], [IsDeleted], [Salt]) VALUES (14, 1011, NULL, N'ezG2AQ22CWXx1po2WQ2Fgf7I9JSVjgJZzEGuZZzNMRw=', 3, NULL, 0, N'4ZuI7LcSuonbeA==')
GO
INSERT [dbo].[Account] ([SysId], [TeacherID], [StudentID], [Password], [RoleID], [CreatedBy], [IsDeleted], [Salt]) VALUES (16, NULL, 12, N'OUZAdRG6v97SyqDpWLOVAy34Yzdfvim8yZzeHXX3IRg=', 2, 3, 0, N'qgsiL9AnzQa/HQ==')
GO
INSERT [dbo].[Account] ([SysId], [TeacherID], [StudentID], [Password], [RoleID], [CreatedBy], [IsDeleted], [Salt]) VALUES (17, NULL, 13, N'rTW7et5S+y8RQuxn23+RVZNoZpHiBrPMV1NsveiXxY8=', 2, 1, 0, N'Cs6Ra7Vuyq+YIQ==')
GO
SET IDENTITY_INSERT [dbo].[Account] OFF
GO
SET IDENTITY_INSERT [dbo].[Assesment] ON 
GO
INSERT [dbo].[Assesment] ([SysId], [Id], [Type], [Time], [GivenDate], [DeadLine], [SectionID], [DepartmentID], [CourseID], [YearID], [Title], [Description], [TotalMark], [CreatedBy], [IsDeleted], [Attachment]) VALUES (19, N'19', 5, CAST(N'01:00:00' AS Time), NULL, NULL, 2, 1, 1, 2, N'First Exam', N'About Hawassa Kebele Management SystemAbout Hawassa Kebele Management SystemAbout Hawassa Kebele Management System', N'10', 1, 0, NULL)
GO
INSERT [dbo].[Assesment] ([SysId], [Id], [Type], [Time], [GivenDate], [DeadLine], [SectionID], [DepartmentID], [CourseID], [YearID], [Title], [Description], [TotalMark], [CreatedBy], [IsDeleted], [Attachment]) VALUES (20, NULL, 6, CAST(N'01:48:30' AS Time), CAST(N'2019-08-19' AS Date), CAST(N'2019-08-29' AS Date), 2, 2, 4, 3, N'የ ሃዋሳ ዩንቨርስቲ የምርቃት ቀን', N'የ ሃዋሳ ዩንቨርስቲ የምርቃት ቀን', N'20', 1, 0, NULL)
GO
INSERT [dbo].[Assesment] ([SysId], [Id], [Type], [Time], [GivenDate], [DeadLine], [SectionID], [DepartmentID], [CourseID], [YearID], [Title], [Description], [TotalMark], [CreatedBy], [IsDeleted], [Attachment]) VALUES (21, NULL, 5, CAST(N'00:00:00' AS Time), CAST(N'2019-08-19' AS Date), NULL, 2, 1, 1, 2, N'የ ሃዋሳ ዩንቨርስቲ የምርቃት ቀን', N'??? ?????? ???? ?????? ? ??? 6 2011 ', N'10', 1, 0, NULL)
GO
INSERT [dbo].[Assesment] ([SysId], [Id], [Type], [Time], [GivenDate], [DeadLine], [SectionID], [DepartmentID], [CourseID], [YearID], [Title], [Description], [TotalMark], [CreatedBy], [IsDeleted], [Attachment]) VALUES (22, N'22', 5, CAST(N'12:12:00' AS Time), NULL, CAST(N'2019-12-19' AS Date), 2, 2, 5, 3, N'New try TEST', N'read accordingly', N'20', NULL, 0, NULL)
GO
INSERT [dbo].[Assesment] ([SysId], [Id], [Type], [Time], [GivenDate], [DeadLine], [SectionID], [DepartmentID], [CourseID], [YearID], [Title], [Description], [TotalMark], [CreatedBy], [IsDeleted], [Attachment]) VALUES (23, NULL, 6, CAST(N'14:13:00' AS Time), CAST(N'2019-08-19' AS Date), CAST(N'2019-08-22' AS Date), 2, 2, 5, 3, N'New try Assignment', N'show step by step other wise 00000', N'30', NULL, 0, NULL)
GO
INSERT [dbo].[Assesment] ([SysId], [Id], [Type], [Time], [GivenDate], [DeadLine], [SectionID], [DepartmentID], [CourseID], [YearID], [Title], [Description], [TotalMark], [CreatedBy], [IsDeleted], [Attachment]) VALUES (24, NULL, 6, CAST(N'13:59:00' AS Time), CAST(N'2019-08-20' AS Date), CAST(N'2019-08-22' AS Date), 2, 1, 1, 2, N'C++ exam', N'This system enable residents to get notification This system enable residents to get notification This system enable residents to get notification This system enable residents to get notification ', N'10', 1, 0, NULL)
GO
INSERT [dbo].[Assesment] ([SysId], [Id], [Type], [Time], [GivenDate], [DeadLine], [SectionID], [DepartmentID], [CourseID], [YearID], [Title], [Description], [TotalMark], [CreatedBy], [IsDeleted], [Attachment]) VALUES (25, NULL, 6, CAST(N'01:00:00' AS Time), CAST(N'2019-08-25' AS Date), CAST(N'2019-08-30' AS Date), 2, 3, 1, 2, N'be on time', N'as I told you OK!', N'30', 3, 0, NULL)
GO
INSERT [dbo].[Assesment] ([SysId], [Id], [Type], [Time], [GivenDate], [DeadLine], [SectionID], [DepartmentID], [CourseID], [YearID], [Title], [Description], [TotalMark], [CreatedBy], [IsDeleted], [Attachment]) VALUES (26, NULL, 7, CAST(N'01:00:00' AS Time), CAST(N'2019-08-25' AS Date), CAST(N'2019-08-29' AS Date), 2, 1, 1, 2, N'የ ሃዋሳ ዩንቨርስቲ የምርቃት ቀን', N'ሃዋሳ ዩኒቨርሲቲ ተመራቂ ተማሪዎቹን በ ሃምሌ 6 2011 ያስመርቃልያስመርቃል። ሃዋሳ ዩኒቨርሲቲ ተመራቂ ተማሪዎቹን በ ሃምሌ 6 2011 ያስመርቃል። ሃዋሳ ዩኒቨርሲቲ ተመራቂ ተማሪዎቹን በ ሃምሌ 6 2011 ያስመርቃል።', N'10', 3, 0, NULL)
GO
INSERT [dbo].[Assesment] ([SysId], [Id], [Type], [Time], [GivenDate], [DeadLine], [SectionID], [DepartmentID], [CourseID], [YearID], [Title], [Description], [TotalMark], [CreatedBy], [IsDeleted], [Attachment]) VALUES (27, NULL, 5, CAST(N'01:00:00' AS Time), CAST(N'2019-08-25' AS Date), CAST(N'2019-08-23' AS Date), 2, 1, 1, 3, N'Hawassa University Graduation', N'About Hawassa Kebele Management SystemAbout Hawassa Kebele Management SystemAbout Hawassa Kebele Management System', N'90', 3, 0, NULL)
GO
INSERT [dbo].[Assesment] ([SysId], [Id], [Type], [Time], [GivenDate], [DeadLine], [SectionID], [DepartmentID], [CourseID], [YearID], [Title], [Description], [TotalMark], [CreatedBy], [IsDeleted], [Attachment]) VALUES (28, NULL, 5, NULL, CAST(N'2019-08-25' AS Date), CAST(N'2019-08-29' AS Date), 2, 3, 1, 3, N'try with asse', N'I am trying with asse', N'30', 3, 0, NULL)
GO
INSERT [dbo].[Assesment] ([SysId], [Id], [Type], [Time], [GivenDate], [DeadLine], [SectionID], [DepartmentID], [CourseID], [YearID], [Title], [Description], [TotalMark], [CreatedBy], [IsDeleted], [Attachment]) VALUES (1025, NULL, 5, CAST(N'01:00:00' AS Time), CAST(N'2019-08-26' AS Date), CAST(N'2019-08-31' AS Date), 2, 1, 1, 2, N'C++ exam', N'Hawassa university will graduate its students in june 2019', N'10', NULL, 0, NULL)
GO
INSERT [dbo].[Assesment] ([SysId], [Id], [Type], [Time], [GivenDate], [DeadLine], [SectionID], [DepartmentID], [CourseID], [YearID], [Title], [Description], [TotalMark], [CreatedBy], [IsDeleted], [Attachment]) VALUES (1026, NULL, 5, CAST(N'01:00:00' AS Time), CAST(N'2019-08-26' AS Date), CAST(N'2019-08-31' AS Date), 2, 1, 1, 2, N'C++ exam', N'Hawassa university will graduate its students in june 2019 Hawassa university will graduate its students in june 2019', N'10', 3, 0, NULL)
GO
INSERT [dbo].[Assesment] ([SysId], [Id], [Type], [Time], [GivenDate], [DeadLine], [SectionID], [DepartmentID], [CourseID], [YearID], [Title], [Description], [TotalMark], [CreatedBy], [IsDeleted], [Attachment]) VALUES (2025, NULL, 6, CAST(N'12:59:00' AS Time), CAST(N'2019-08-29' AS Date), CAST(N'2019-08-31' AS Date), 2, 1, 1, 2, N'attachement trial', N'do it based on the attachement', N'50', 1, 0, N'C:\Users\Lucky\source\repos\SMS\SMS\Content\SubmittedFiles\tes.JPG')
GO
SET IDENTITY_INSERT [dbo].[Assesment] OFF
GO
SET IDENTITY_INSERT [dbo].[AssesmentTypes] ON 
GO
INSERT [dbo].[AssesmentTypes] ([SysId], [Name]) VALUES (5, N'Test')
GO
INSERT [dbo].[AssesmentTypes] ([SysId], [Name]) VALUES (6, N'Assignment')
GO
INSERT [dbo].[AssesmentTypes] ([SysId], [Name]) VALUES (7, N'Project')
GO
SET IDENTITY_INSERT [dbo].[AssesmentTypes] OFF
GO
SET IDENTITY_INSERT [dbo].[Course] ON 
GO
INSERT [dbo].[Course] ([SysId], [Name], [YearId], [CreatedBy], [IsDeleted], [DepartmentID]) VALUES (1, N'C++', 2, 1, 0, 1)
GO
INSERT [dbo].[Course] ([SysId], [Name], [YearId], [CreatedBy], [IsDeleted], [DepartmentID]) VALUES (2, N'C#', 2, 3, 0, 1)
GO
INSERT [dbo].[Course] ([SysId], [Name], [YearId], [CreatedBy], [IsDeleted], [DepartmentID]) VALUES (4, N'Business', 3, 1, 0, 2)
GO
INSERT [dbo].[Course] ([SysId], [Name], [YearId], [CreatedBy], [IsDeleted], [DepartmentID]) VALUES (5, N'Interpreunership', 3, 1, NULL, 2)
GO
INSERT [dbo].[Course] ([SysId], [Name], [YearId], [CreatedBy], [IsDeleted], [DepartmentID]) VALUES (6, N'System Programming', 3, 1, NULL, 1)
GO
SET IDENTITY_INSERT [dbo].[Course] OFF
GO
SET IDENTITY_INSERT [dbo].[Department] ON 
GO
INSERT [dbo].[Department] ([SysId], [Name]) VALUES (1, N'Computer Science')
GO
INSERT [dbo].[Department] ([SysId], [Name]) VALUES (2, N'Information System')
GO
INSERT [dbo].[Department] ([SysId], [Name]) VALUES (3, N'Information Technology')
GO
SET IDENTITY_INSERT [dbo].[Department] OFF
GO
SET IDENTITY_INSERT [dbo].[MenuItems] ON 
GO
INSERT [dbo].[MenuItems] ([SysId], [Name], [Link], [Icon]) VALUES (1, N'Home', N'Home/Index', N'nav-icon fas fa-tachometer-alt')
GO
INSERT [dbo].[MenuItems] ([SysId], [Name], [Link], [Icon]) VALUES (2, N'Teachers', N'Teachers/Index', N'nav-icon fas fa-user-plus')
GO
INSERT [dbo].[MenuItems] ([SysId], [Name], [Link], [Icon]) VALUES (3, N'Student', N'Students/Index', N'fa fa-list-alt')
GO
INSERT [dbo].[MenuItems] ([SysId], [Name], [Link], [Icon]) VALUES (1003, N'Assesments', N'Assesments/Index', N'nav-icon fas fa-plus')
GO
INSERT [dbo].[MenuItems] ([SysId], [Name], [Link], [Icon]) VALUES (1005, N'Trash', NULL, N'fas fa-trash-alt')
GO
INSERT [dbo].[MenuItems] ([SysId], [Name], [Link], [Icon]) VALUES (1006, N'Change Password', N'Account/ChangePassword', N'fas fa-wrench')
GO
INSERT [dbo].[MenuItems] ([SysId], [Name], [Link], [Icon]) VALUES (1007, N'Courses', N'CoursesStudent/Index', N'nav-icon fas fa-tachometer-alt')
GO
INSERT [dbo].[MenuItems] ([SysId], [Name], [Link], [Icon]) VALUES (1008, N'Result', N'Results/ViewResult', NULL)
GO
INSERT [dbo].[MenuItems] ([SysId], [Name], [Link], [Icon]) VALUES (1009, N'Change Password', N'Account/ChangePassword', NULL)
GO
INSERT [dbo].[MenuItems] ([SysId], [Name], [Link], [Icon]) VALUES (1011, N'Course', N'Courses/Index', N'nav-icon fas fa-plus')
GO
INSERT [dbo].[MenuItems] ([SysId], [Name], [Link], [Icon]) VALUES (1012, N'Departments', N'Departments/Index', NULL)
GO
INSERT [dbo].[MenuItems] ([SysId], [Name], [Link], [Icon]) VALUES (1013, N'Assignments', N'CoursesStudent/AllAssignments', NULL)
GO
INSERT [dbo].[MenuItems] ([SysId], [Name], [Link], [Icon]) VALUES (1014, N'Tests', N'CoursesStudent/AllTests', NULL)
GO
INSERT [dbo].[MenuItems] ([SysId], [Name], [Link], [Icon]) VALUES (1015, N'Assign Teacher', N'Teaches/Index', NULL)
GO
INSERT [dbo].[MenuItems] ([SysId], [Name], [Link], [Icon]) VALUES (1016, N'Year', N'Years/Index', NULL)
GO
INSERT [dbo].[MenuItems] ([SysId], [Name], [Link], [Icon]) VALUES (1017, N'Section', N'Sections/Index', NULL)
GO
INSERT [dbo].[MenuItems] ([SysId], [Name], [Link], [Icon]) VALUES (2015, N'Message', N'Messages/Index', N'fa fa-send')
GO
SET IDENTITY_INSERT [dbo].[MenuItems] OFF
GO
SET IDENTITY_INSERT [dbo].[Messages] ON 
GO
INSERT [dbo].[Messages] ([SysId], [From], [ToStudents], [ToTeachers], [Subject], [Body], [Status], [IsDeleted]) VALUES (1, N'Abdulhakim Zeinu', 11, NULL, N'First try message', N'this is the body of the message', 1, NULL)
GO
INSERT [dbo].[Messages] ([SysId], [From], [ToStudents], [ToTeachers], [Subject], [Body], [Status], [IsDeleted]) VALUES (2, N'Ekram Awol', NULL, 1, N'Response for your First try message', N'this is the body of the message', 1, NULL)
GO
INSERT [dbo].[Messages] ([SysId], [From], [ToStudents], [ToTeachers], [Subject], [Body], [Status], [IsDeleted]) VALUES (3, N'Abdulhakim Zeinu', 13, NULL, N'Hi amy', N'this is the body of the message', 0, NULL)
GO
INSERT [dbo].[Messages] ([SysId], [From], [ToStudents], [ToTeachers], [Subject], [Body], [Status], [IsDeleted]) VALUES (4, N'Amen Abera', NULL, 1, N'Hi Luck', N'I am received it thank you', 1, 0)
GO
SET IDENTITY_INSERT [dbo].[Messages] OFF
GO
SET IDENTITY_INSERT [dbo].[Results] ON 
GO
INSERT [dbo].[Results] ([SysId], [AssessmentID], [StudentID], [Mark], [CreatedBy], [IsDeleted]) VALUES (3, 26, 2, N'30', 3, NULL)
GO
INSERT [dbo].[Results] ([SysId], [AssessmentID], [StudentID], [Mark], [CreatedBy], [IsDeleted]) VALUES (4, 26, 3, N'74', 3, NULL)
GO
INSERT [dbo].[Results] ([SysId], [AssessmentID], [StudentID], [Mark], [CreatedBy], [IsDeleted]) VALUES (5, 26, 8, N'46', 3, NULL)
GO
INSERT [dbo].[Results] ([SysId], [AssessmentID], [StudentID], [Mark], [CreatedBy], [IsDeleted]) VALUES (7, 27, 7, N'25', 3, NULL)
GO
INSERT [dbo].[Results] ([SysId], [AssessmentID], [StudentID], [Mark], [CreatedBy], [IsDeleted]) VALUES (1003, 1026, 2, NULL, 3, NULL)
GO
INSERT [dbo].[Results] ([SysId], [AssessmentID], [StudentID], [Mark], [CreatedBy], [IsDeleted]) VALUES (1004, 1026, 3, N'89', 3, NULL)
GO
INSERT [dbo].[Results] ([SysId], [AssessmentID], [StudentID], [Mark], [CreatedBy], [IsDeleted]) VALUES (1005, 1026, 8, N'33', 3, NULL)
GO
SET IDENTITY_INSERT [dbo].[Results] OFF
GO
SET IDENTITY_INSERT [dbo].[Role] ON 
GO
INSERT [dbo].[Role] ([SysId], [Name]) VALUES (1, N'Teachers')
GO
INSERT [dbo].[Role] ([SysId], [Name]) VALUES (2, N'Students')
GO
INSERT [dbo].[Role] ([SysId], [Name]) VALUES (3, N'Admin')
GO
SET IDENTITY_INSERT [dbo].[Role] OFF
GO
SET IDENTITY_INSERT [dbo].[RoleMenu] ON 
GO
INSERT [dbo].[RoleMenu] ([SysId], [RoleId], [MenuId], [IsDeleted], [CreatedBy]) VALUES (2, 1, 1, 0, NULL)
GO
INSERT [dbo].[RoleMenu] ([SysId], [RoleId], [MenuId], [IsDeleted], [CreatedBy]) VALUES (3, 1, 3, 0, NULL)
GO
INSERT [dbo].[RoleMenu] ([SysId], [RoleId], [MenuId], [IsDeleted], [CreatedBy]) VALUES (1004, 1, 1003, 0, NULL)
GO
INSERT [dbo].[RoleMenu] ([SysId], [RoleId], [MenuId], [IsDeleted], [CreatedBy]) VALUES (1006, 3, 1005, 0, NULL)
GO
INSERT [dbo].[RoleMenu] ([SysId], [RoleId], [MenuId], [IsDeleted], [CreatedBy]) VALUES (1007, 1, 1006, 0, NULL)
GO
INSERT [dbo].[RoleMenu] ([SysId], [RoleId], [MenuId], [IsDeleted], [CreatedBy]) VALUES (1008, 2, 1007, 0, NULL)
GO
INSERT [dbo].[RoleMenu] ([SysId], [RoleId], [MenuId], [IsDeleted], [CreatedBy]) VALUES (1009, 2, 1008, 0, NULL)
GO
INSERT [dbo].[RoleMenu] ([SysId], [RoleId], [MenuId], [IsDeleted], [CreatedBy]) VALUES (1010, 2, 1009, 0, NULL)
GO
INSERT [dbo].[RoleMenu] ([SysId], [RoleId], [MenuId], [IsDeleted], [CreatedBy]) VALUES (1014, 2, 1013, 0, NULL)
GO
INSERT [dbo].[RoleMenu] ([SysId], [RoleId], [MenuId], [IsDeleted], [CreatedBy]) VALUES (1015, 2, 1014, 0, NULL)
GO
INSERT [dbo].[RoleMenu] ([SysId], [RoleId], [MenuId], [IsDeleted], [CreatedBy]) VALUES (1017, 3, 2, 0, NULL)
GO
INSERT [dbo].[RoleMenu] ([SysId], [RoleId], [MenuId], [IsDeleted], [CreatedBy]) VALUES (1018, 3, 1012, 0, NULL)
GO
INSERT [dbo].[RoleMenu] ([SysId], [RoleId], [MenuId], [IsDeleted], [CreatedBy]) VALUES (1019, 3, 1015, 0, NULL)
GO
INSERT [dbo].[RoleMenu] ([SysId], [RoleId], [MenuId], [IsDeleted], [CreatedBy]) VALUES (1020, 3, 1016, 0, NULL)
GO
INSERT [dbo].[RoleMenu] ([SysId], [RoleId], [MenuId], [IsDeleted], [CreatedBy]) VALUES (1022, 3, 1017, 0, NULL)
GO
INSERT [dbo].[RoleMenu] ([SysId], [RoleId], [MenuId], [IsDeleted], [CreatedBy]) VALUES (1023, 3, 1011, 0, NULL)
GO
INSERT [dbo].[RoleMenu] ([SysId], [RoleId], [MenuId], [IsDeleted], [CreatedBy]) VALUES (1024, 1, 1011, 0, NULL)
GO
INSERT [dbo].[RoleMenu] ([SysId], [RoleId], [MenuId], [IsDeleted], [CreatedBy]) VALUES (2017, 1, 2015, 0, NULL)
GO
INSERT [dbo].[RoleMenu] ([SysId], [RoleId], [MenuId], [IsDeleted], [CreatedBy]) VALUES (2018, 2, 2015, 0, NULL)
GO
SET IDENTITY_INSERT [dbo].[RoleMenu] OFF
GO
SET IDENTITY_INSERT [dbo].[Sections] ON 
GO
INSERT [dbo].[Sections] ([SysId], [Value], [YearId], [CreatedBy], [IsDeleted]) VALUES (2, N'1', NULL, 1, 0)
GO
INSERT [dbo].[Sections] ([SysId], [Value], [YearId], [CreatedBy], [IsDeleted]) VALUES (3, N'2', 3, 1011, NULL)
GO
SET IDENTITY_INSERT [dbo].[Sections] OFF
GO
SET IDENTITY_INSERT [dbo].[Students] ON 
GO
INSERT [dbo].[Students] ([SysId], [Id], [FirstName], [LastName], [UserName], [Email], [Phone], [Password], [SectionID], [YearID], [CreatedBy], [IsDeleted], [Role], [Photo], [DepartmentID]) VALUES (2, N'001', N'Tesfu', N'Amsale', N'tesfu', N'tesfu@gmail.com', N'0935828232', N'123', 2, 2, 1, 0, 2, N'Content/images/tesfu.jpg', 1)
GO
INSERT [dbo].[Students] ([SysId], [Id], [FirstName], [LastName], [UserName], [Email], [Phone], [Password], [SectionID], [YearID], [CreatedBy], [IsDeleted], [Role], [Photo], [DepartmentID]) VALUES (3, N'3', N'Nesredin', N'Ebrahim', N'nesre', N'dinibro0921@gmail.com', N'0921951206', N'22', 2, 2, NULL, NULL, 2, N'Content/images/nesre.jpg', 1)
GO
INSERT [dbo].[Students] ([SysId], [Id], [FirstName], [LastName], [UserName], [Email], [Phone], [Password], [SectionID], [YearID], [CreatedBy], [IsDeleted], [Role], [Photo], [DepartmentID]) VALUES (4, N'004', N'Meti', N'Tesfaye', N'silver', N'meti@gmail.com', N'0963336829', N'4048', 2, 3, 3, 0, 2, NULL, 1)
GO
INSERT [dbo].[Students] ([SysId], [Id], [FirstName], [LastName], [UserName], [Email], [Phone], [Password], [SectionID], [YearID], [CreatedBy], [IsDeleted], [Role], [Photo], [DepartmentID]) VALUES (7, N'004', N'Abenezer', N'Leta', N'sojs', N'abeni@gmail.com', N'09175423', N'1221', 2, 3, 3, 0, 2, NULL, 1)
GO
INSERT [dbo].[Students] ([SysId], [Id], [FirstName], [LastName], [UserName], [Email], [Phone], [Password], [SectionID], [YearID], [CreatedBy], [IsDeleted], [Role], [Photo], [DepartmentID]) VALUES (8, N'005', N'Jemal', N'Ahmed', N'jebina', N'jemalah@gmail.com', N'0914659391', N'1221', 2, 2, 1, NULL, 2, NULL, 1)
GO
INSERT [dbo].[Students] ([SysId], [Id], [FirstName], [LastName], [UserName], [Email], [Phone], [Password], [SectionID], [YearID], [CreatedBy], [IsDeleted], [Role], [Photo], [DepartmentID]) VALUES (9, N'009', N'Mahi', N'Ali', N'mahi', N'mahadialo@gmail.com', N'0933824048', N'4048', 2, 3, 1, NULL, 1, NULL, 2)
GO
INSERT [dbo].[Students] ([SysId], [Id], [FirstName], [LastName], [UserName], [Email], [Phone], [Password], [SectionID], [YearID], [CreatedBy], [IsDeleted], [Role], [Photo], [DepartmentID]) VALUES (11, N'cs/0047/08', N'Ekram', N'Awol', N'ekru', N'ekram@gmail.com', N'0938803231', N'4048', 2, 2, 1, NULL, 2, NULL, 1)
GO
INSERT [dbo].[Students] ([SysId], [Id], [FirstName], [LastName], [UserName], [Email], [Phone], [Password], [SectionID], [YearID], [CreatedBy], [IsDeleted], [Role], [Photo], [DepartmentID]) VALUES (12, N'cs/0115/08', N'Jemal', N'Ahmed', N'jem', N'jemalah@gmail.com', N'0914659391', N'OUZAdRG6v97SyqDpWLOVAy34Yzdfvim8yZzeHXX3IRg=', 2, 3, 3, NULL, 2, N'default.png', 1)
GO
INSERT [dbo].[Students] ([SysId], [Id], [FirstName], [LastName], [UserName], [Email], [Phone], [Password], [SectionID], [YearID], [CreatedBy], [IsDeleted], [Role], [Photo], [DepartmentID]) VALUES (13, N'cs/0034/08', N'Amen', N'Abera', N'amy', N'amy@gmail.com', N'09236475859', N'aHwJ7UElTY9FENgEsyN4eQi0odYF4qWWDkGbzZAvpeg=', 2, 2, 1, NULL, 2, NULL, 1)
GO
SET IDENTITY_INSERT [dbo].[Students] OFF
GO
SET IDENTITY_INSERT [dbo].[SubmitAssignment] ON 
GO
INSERT [dbo].[SubmitAssignment] ([SysId], [StudentId], [AssesmentId], [FilePath], [SubmissionDate]) VALUES (3, 2, 19, N'C:\Users\Lucky\source\repos\SMS\SMS\Content\SubmittedFiles\2-19-abdulhakim.JPG', CAST(N'2019-08-17T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[SubmitAssignment] ([SysId], [StudentId], [AssesmentId], [FilePath], [SubmissionDate]) VALUES (4, 2, 19, N'C:\Users\Lucky\source\repos\SMS\SMS\Content\SubmittedFiles\2-19-abdulhakim.JPG', CAST(N'2019-08-17T11:14:49.000' AS DateTime))
GO
INSERT [dbo].[SubmitAssignment] ([SysId], [StudentId], [AssesmentId], [FilePath], [SubmissionDate]) VALUES (5, 2, 19, N'C:\Users\Lucky\source\repos\SMS\SMS\Content\SubmittedFiles\2-19-abdulhakim.JPG', CAST(N'2019-08-17T12:28:12.000' AS DateTime))
GO
INSERT [dbo].[SubmitAssignment] ([SysId], [StudentId], [AssesmentId], [FilePath], [SubmissionDate]) VALUES (6, 2, 19, N'C:\Users\Lucky\source\repos\SMS\SMS\Content\SubmittedFiles\2-19-abdulhakim.JPG', CAST(N'2019-08-17T12:28:58.000' AS DateTime))
GO
INSERT [dbo].[SubmitAssignment] ([SysId], [StudentId], [AssesmentId], [FilePath], [SubmissionDate]) VALUES (7, 7, 19, N'C:\Users\Lucky\source\repos\SMS\SMS\Content\SubmittedFiles\2-19-abdulhakim.JPG', CAST(N'2019-08-17T12:34:46.000' AS DateTime))
GO
INSERT [dbo].[SubmitAssignment] ([SysId], [StudentId], [AssesmentId], [FilePath], [SubmissionDate]) VALUES (8, 2, 19, N'C:\Users\Lucky\source\repos\SMS\SMS\Content\SubmittedFiles\2-19-abdulhakim.JPG', CAST(N'2019-08-17T12:38:08.000' AS DateTime))
GO
INSERT [dbo].[SubmitAssignment] ([SysId], [StudentId], [AssesmentId], [FilePath], [SubmissionDate]) VALUES (9, 9, 23, N'C:\Users\Lucky\source\repos\SMS\SMS\Content\SubmittedFiles\2-19-abdulhakim.JPG', CAST(N'2019-08-20T06:04:56.000' AS DateTime))
GO
INSERT [dbo].[SubmitAssignment] ([SysId], [StudentId], [AssesmentId], [FilePath], [SubmissionDate]) VALUES (10, 9, 23, N'C:\Users\Lucky\source\repos\SMS\SMS\Content\SubmittedFiles\2-19-abdulhakim.JPG', CAST(N'2019-08-20T06:24:43.000' AS DateTime))
GO
INSERT [dbo].[SubmitAssignment] ([SysId], [StudentId], [AssesmentId], [FilePath], [SubmissionDate]) VALUES (11, NULL, 23, N'C:\Users\Lucky\source\repos\SMS\SMS\Content\SubmittedFiles\2-19-abdulhakim.JPG', CAST(N'2019-08-20T06:29:00.000' AS DateTime))
GO
INSERT [dbo].[SubmitAssignment] ([SysId], [StudentId], [AssesmentId], [FilePath], [SubmissionDate]) VALUES (12, NULL, 23, N'C:\Users\Lucky\source\repos\SMS\SMS\Content\SubmittedFiles\2-19-abdulhakim.JPG', CAST(N'2019-08-20T06:31:08.000' AS DateTime))
GO
INSERT [dbo].[SubmitAssignment] ([SysId], [StudentId], [AssesmentId], [FilePath], [SubmissionDate]) VALUES (13, 9, 20, N'C:\Users\Lucky\source\repos\SMS\SMS\Content\SubmittedFiles\9-20-NewFile1.cpp', CAST(N'2019-08-24T15:26:25.000' AS DateTime))
GO
INSERT [dbo].[SubmitAssignment] ([SysId], [StudentId], [AssesmentId], [FilePath], [SubmissionDate]) VALUES (14, 9, 20, N'C:\Users\Lucky\source\repos\SMS\SMS\Content\SubmittedFiles\9-20-NewFile1.cpp', CAST(N'2019-08-24T15:41:02.000' AS DateTime))
GO
INSERT [dbo].[SubmitAssignment] ([SysId], [StudentId], [AssesmentId], [FilePath], [SubmissionDate]) VALUES (15, 9, 20, N'C:\Users\Lucky\source\repos\SMS\SMS\Content\SubmittedFiles\9-20-CodeDreamers SC Business Plan (2).pdf', CAST(N'2019-08-25T19:56:24.000' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[SubmitAssignment] OFF
GO
SET IDENTITY_INSERT [dbo].[Teachers] ON 
GO
INSERT [dbo].[Teachers] ([SysId], [Id], [FirstName], [LastName], [Email], [Role], [Photo], [Password], [CreatedBy], [IsDeleted]) VALUES (1, N'T/0003/08', N'Abdulhakim', N'Zeinu', N'zluckyza@gmail.com', 1, N'Content/images/Lucky.jpg', NULL, N'Lucky', 0)
GO
INSERT [dbo].[Teachers] ([SysId], [Id], [FirstName], [LastName], [Email], [Role], [Photo], [Password], [CreatedBy], [IsDeleted]) VALUES (3, N'T/009/08', N'Aseffa', N'Tedla', N'asseydgl@gmail.com', 1, N'Content/images/asse.jpg', NULL, N'Lucky', 0)
GO
INSERT [dbo].[Teachers] ([SysId], [Id], [FirstName], [LastName], [Email], [Role], [Photo], [Password], [CreatedBy], [IsDeleted]) VALUES (1011, N'SA/011', N'SAdmin', N'SAdmin', NULL, 3, N'Content/images/Lucky.jpg', NULL, N'Lucky', 0)
GO
SET IDENTITY_INSERT [dbo].[Teachers] OFF
GO
SET IDENTITY_INSERT [dbo].[Teaches] ON 
GO
INSERT [dbo].[Teaches] ([SysId], [TeacherId], [CourseId], [DepartmentId], [YearId], [SectionId]) VALUES (29, 1, 1, 1, 2, 2)
GO
SET IDENTITY_INSERT [dbo].[Teaches] OFF
GO
SET IDENTITY_INSERT [dbo].[Year] ON 
GO
INSERT [dbo].[Year] ([SysId], [Value], [CreatedBy], [IsDeleted]) VALUES (2, N'1', NULL, 0)
GO
INSERT [dbo].[Year] ([SysId], [Value], [CreatedBy], [IsDeleted]) VALUES (3, N'2', NULL, 0)
GO
SET IDENTITY_INSERT [dbo].[Year] OFF
GO
ALTER TABLE [dbo].[Assesment] ADD  CONSTRAINT [DF_Assignments_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[Course] ADD  CONSTRAINT [DF_Subjects_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[Results] ADD  CONSTRAINT [DF_Results_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[Sections] ADD  CONSTRAINT [DF_Sections_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[Students] ADD  CONSTRAINT [DF_Students_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[SuperAdmin] ADD  CONSTRAINT [DF_SuperAdmin_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[Teachers] ADD  CONSTRAINT [DF_Teachers_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[Year] ADD  CONSTRAINT [DF_Year_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[Account]  WITH CHECK ADD  CONSTRAINT [FK_Account_Role] FOREIGN KEY([RoleID])
REFERENCES [dbo].[Role] ([SysId])
GO
ALTER TABLE [dbo].[Account] CHECK CONSTRAINT [FK_Account_Role]
GO
ALTER TABLE [dbo].[Account]  WITH CHECK ADD  CONSTRAINT [FK_Account_Students] FOREIGN KEY([StudentID])
REFERENCES [dbo].[Students] ([SysId])
GO
ALTER TABLE [dbo].[Account] CHECK CONSTRAINT [FK_Account_Students]
GO
ALTER TABLE [dbo].[Account]  WITH CHECK ADD  CONSTRAINT [FK_Account_Teachers] FOREIGN KEY([TeacherID])
REFERENCES [dbo].[Teachers] ([SysId])
GO
ALTER TABLE [dbo].[Account] CHECK CONSTRAINT [FK_Account_Teachers]
GO
ALTER TABLE [dbo].[Assesment]  WITH CHECK ADD  CONSTRAINT [FK_Assesment_AssasementTypes] FOREIGN KEY([Type])
REFERENCES [dbo].[AssesmentTypes] ([SysId])
GO
ALTER TABLE [dbo].[Assesment] CHECK CONSTRAINT [FK_Assesment_AssasementTypes]
GO
ALTER TABLE [dbo].[Assesment]  WITH CHECK ADD  CONSTRAINT [FK_Assesment_Course] FOREIGN KEY([CourseID])
REFERENCES [dbo].[Course] ([SysId])
GO
ALTER TABLE [dbo].[Assesment] CHECK CONSTRAINT [FK_Assesment_Course]
GO
ALTER TABLE [dbo].[Assesment]  WITH CHECK ADD  CONSTRAINT [FK_Assesment_Department] FOREIGN KEY([DepartmentID])
REFERENCES [dbo].[Department] ([SysId])
GO
ALTER TABLE [dbo].[Assesment] CHECK CONSTRAINT [FK_Assesment_Department]
GO
ALTER TABLE [dbo].[Assesment]  WITH CHECK ADD  CONSTRAINT [FK_Assesment_Sections] FOREIGN KEY([SectionID])
REFERENCES [dbo].[Sections] ([SysId])
GO
ALTER TABLE [dbo].[Assesment] CHECK CONSTRAINT [FK_Assesment_Sections]
GO
ALTER TABLE [dbo].[Assesment]  WITH CHECK ADD  CONSTRAINT [FK_Assesment_Teachers] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Teachers] ([SysId])
GO
ALTER TABLE [dbo].[Assesment] CHECK CONSTRAINT [FK_Assesment_Teachers]
GO
ALTER TABLE [dbo].[Assesment]  WITH CHECK ADD  CONSTRAINT [FK_Assesment_Year] FOREIGN KEY([YearID])
REFERENCES [dbo].[Year] ([SysId])
GO
ALTER TABLE [dbo].[Assesment] CHECK CONSTRAINT [FK_Assesment_Year]
GO
ALTER TABLE [dbo].[Course]  WITH CHECK ADD  CONSTRAINT [FK_Course_Department] FOREIGN KEY([DepartmentID])
REFERENCES [dbo].[Department] ([SysId])
GO
ALTER TABLE [dbo].[Course] CHECK CONSTRAINT [FK_Course_Department]
GO
ALTER TABLE [dbo].[Course]  WITH CHECK ADD  CONSTRAINT [FK_Course_Teachers] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Teachers] ([SysId])
GO
ALTER TABLE [dbo].[Course] CHECK CONSTRAINT [FK_Course_Teachers]
GO
ALTER TABLE [dbo].[Course]  WITH CHECK ADD  CONSTRAINT [FK_Subjects_Year] FOREIGN KEY([YearId])
REFERENCES [dbo].[Year] ([SysId])
GO
ALTER TABLE [dbo].[Course] CHECK CONSTRAINT [FK_Subjects_Year]
GO
ALTER TABLE [dbo].[Messages]  WITH CHECK ADD  CONSTRAINT [FK_Messages_Students] FOREIGN KEY([ToStudents])
REFERENCES [dbo].[Students] ([SysId])
GO
ALTER TABLE [dbo].[Messages] CHECK CONSTRAINT [FK_Messages_Students]
GO
ALTER TABLE [dbo].[Messages]  WITH CHECK ADD  CONSTRAINT [FK_Messages_Teachers] FOREIGN KEY([ToTeachers])
REFERENCES [dbo].[Teachers] ([SysId])
GO
ALTER TABLE [dbo].[Messages] CHECK CONSTRAINT [FK_Messages_Teachers]
GO
ALTER TABLE [dbo].[Results]  WITH CHECK ADD  CONSTRAINT [FK_Results_Assesment] FOREIGN KEY([AssessmentID])
REFERENCES [dbo].[Assesment] ([SysId])
GO
ALTER TABLE [dbo].[Results] CHECK CONSTRAINT [FK_Results_Assesment]
GO
ALTER TABLE [dbo].[Results]  WITH CHECK ADD  CONSTRAINT [FK_Results_Students] FOREIGN KEY([StudentID])
REFERENCES [dbo].[Students] ([SysId])
GO
ALTER TABLE [dbo].[Results] CHECK CONSTRAINT [FK_Results_Students]
GO
ALTER TABLE [dbo].[Results]  WITH CHECK ADD  CONSTRAINT [FK_Results_Teachers] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Teachers] ([SysId])
GO
ALTER TABLE [dbo].[Results] CHECK CONSTRAINT [FK_Results_Teachers]
GO
ALTER TABLE [dbo].[RoleMenu]  WITH CHECK ADD  CONSTRAINT [FK_RoleMenu_MenuItems] FOREIGN KEY([MenuId])
REFERENCES [dbo].[MenuItems] ([SysId])
GO
ALTER TABLE [dbo].[RoleMenu] CHECK CONSTRAINT [FK_RoleMenu_MenuItems]
GO
ALTER TABLE [dbo].[RoleMenu]  WITH CHECK ADD  CONSTRAINT [FK_RoleMenu_Role] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Role] ([SysId])
GO
ALTER TABLE [dbo].[RoleMenu] CHECK CONSTRAINT [FK_RoleMenu_Role]
GO
ALTER TABLE [dbo].[Sections]  WITH CHECK ADD  CONSTRAINT [FK_Sections_Year] FOREIGN KEY([YearId])
REFERENCES [dbo].[Year] ([SysId])
GO
ALTER TABLE [dbo].[Sections] CHECK CONSTRAINT [FK_Sections_Year]
GO
ALTER TABLE [dbo].[Students]  WITH CHECK ADD  CONSTRAINT [FK_Students_Department] FOREIGN KEY([DepartmentID])
REFERENCES [dbo].[Department] ([SysId])
GO
ALTER TABLE [dbo].[Students] CHECK CONSTRAINT [FK_Students_Department]
GO
ALTER TABLE [dbo].[Students]  WITH CHECK ADD  CONSTRAINT [FK_Students_Role] FOREIGN KEY([Role])
REFERENCES [dbo].[Role] ([SysId])
GO
ALTER TABLE [dbo].[Students] CHECK CONSTRAINT [FK_Students_Role]
GO
ALTER TABLE [dbo].[Students]  WITH CHECK ADD  CONSTRAINT [FK_Students_Sections] FOREIGN KEY([SectionID])
REFERENCES [dbo].[Sections] ([SysId])
GO
ALTER TABLE [dbo].[Students] CHECK CONSTRAINT [FK_Students_Sections]
GO
ALTER TABLE [dbo].[Students]  WITH CHECK ADD  CONSTRAINT [FK_Students_Teachers] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Teachers] ([SysId])
GO
ALTER TABLE [dbo].[Students] CHECK CONSTRAINT [FK_Students_Teachers]
GO
ALTER TABLE [dbo].[Students]  WITH CHECK ADD  CONSTRAINT [FK_Students_Year] FOREIGN KEY([YearID])
REFERENCES [dbo].[Year] ([SysId])
GO
ALTER TABLE [dbo].[Students] CHECK CONSTRAINT [FK_Students_Year]
GO
ALTER TABLE [dbo].[SubmitAssignment]  WITH CHECK ADD  CONSTRAINT [FK_SubmitAssignment_Assesment] FOREIGN KEY([AssesmentId])
REFERENCES [dbo].[Assesment] ([SysId])
GO
ALTER TABLE [dbo].[SubmitAssignment] CHECK CONSTRAINT [FK_SubmitAssignment_Assesment]
GO
ALTER TABLE [dbo].[SubmitAssignment]  WITH CHECK ADD  CONSTRAINT [FK_SubmitAssignment_Students] FOREIGN KEY([StudentId])
REFERENCES [dbo].[Students] ([SysId])
GO
ALTER TABLE [dbo].[SubmitAssignment] CHECK CONSTRAINT [FK_SubmitAssignment_Students]
GO
ALTER TABLE [dbo].[Teachers]  WITH CHECK ADD  CONSTRAINT [FK_Teachers_Role] FOREIGN KEY([Role])
REFERENCES [dbo].[Role] ([SysId])
GO
ALTER TABLE [dbo].[Teachers] CHECK CONSTRAINT [FK_Teachers_Role]
GO
ALTER TABLE [dbo].[Teaches]  WITH CHECK ADD  CONSTRAINT [FK_Teaches_Course] FOREIGN KEY([CourseId])
REFERENCES [dbo].[Course] ([SysId])
GO
ALTER TABLE [dbo].[Teaches] CHECK CONSTRAINT [FK_Teaches_Course]
GO
ALTER TABLE [dbo].[Teaches]  WITH CHECK ADD  CONSTRAINT [FK_Teaches_Department] FOREIGN KEY([DepartmentId])
REFERENCES [dbo].[Department] ([SysId])
GO
ALTER TABLE [dbo].[Teaches] CHECK CONSTRAINT [FK_Teaches_Department]
GO
ALTER TABLE [dbo].[Teaches]  WITH CHECK ADD  CONSTRAINT [FK_Teaches_Sections] FOREIGN KEY([SectionId])
REFERENCES [dbo].[Sections] ([SysId])
GO
ALTER TABLE [dbo].[Teaches] CHECK CONSTRAINT [FK_Teaches_Sections]
GO
ALTER TABLE [dbo].[Teaches]  WITH CHECK ADD  CONSTRAINT [FK_Teaches_Teachers] FOREIGN KEY([TeacherId])
REFERENCES [dbo].[Teachers] ([SysId])
GO
ALTER TABLE [dbo].[Teaches] CHECK CONSTRAINT [FK_Teaches_Teachers]
GO
ALTER TABLE [dbo].[Teaches]  WITH CHECK ADD  CONSTRAINT [FK_Teaches_Year] FOREIGN KEY([YearId])
REFERENCES [dbo].[Year] ([SysId])
GO
ALTER TABLE [dbo].[Teaches] CHECK CONSTRAINT [FK_Teaches_Year]
GO
USE [master]
GO
ALTER DATABASE [SMS] SET  READ_WRITE 
GO
