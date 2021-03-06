USE master;

DROP DATABASE IF EXISTS TranLogDemo;

CREATE DATABASE [TranLogDemo]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TranLogDemo', FILENAME = N'C:\Data\TranLogDemo.mdf' , SIZE = 128MB , FILEGROWTH = 128MB )
 LOG ON 
( NAME = N'TranLogDemo_log', FILENAME = N'C:\Log\TranLogDemo_log.ldf' , SIZE = 128MB , FILEGROWTH = 128MB )
GO
ALTER DATABASE [TranLogDemo] SET COMPATIBILITY_LEVEL = 130
GO
ALTER DATABASE [TranLogDemo] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [TranLogDemo] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [TranLogDemo] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [TranLogDemo] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [TranLogDemo] SET ARITHABORT OFF 
GO
ALTER DATABASE [TranLogDemo] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [TranLogDemo] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [TranLogDemo] SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = OFF)
GO
ALTER DATABASE [TranLogDemo] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [TranLogDemo] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [TranLogDemo] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [TranLogDemo] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [TranLogDemo] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [TranLogDemo] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [TranLogDemo] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [TranLogDemo] SET  DISABLE_BROKER 
GO
ALTER DATABASE [TranLogDemo] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [TranLogDemo] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [TranLogDemo] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [TranLogDemo] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [TranLogDemo] SET  READ_WRITE 
GO
ALTER DATABASE [TranLogDemo] SET RECOVERY FULL 
GO
ALTER DATABASE [TranLogDemo] SET  MULTI_USER 
GO
ALTER DATABASE [TranLogDemo] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [TranLogDemo] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [TranLogDemo] SET DELAYED_DURABILITY = DISABLED 
GO
USE [TranLogDemo]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = Off;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = Primary;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = On;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = Primary;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = Off;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = Primary;
GO
USE [TranLogDemo]
GO
IF NOT EXISTS (SELECT name FROM sys.filegroups WHERE is_default=1 AND name = N'PRIMARY') ALTER DATABASE [TranLogDemo] MODIFY FILEGROUP [PRIMARY] DEFAULT
GO
