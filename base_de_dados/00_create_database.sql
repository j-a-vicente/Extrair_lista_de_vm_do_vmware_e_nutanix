/*************************************************************************************************************
===================================== Script de criação da base de dados ====================================

A base de dados de inventario_vm de dados é dividida em varios schemas, cada schema tem um file group para separa
os dados fisicamente.
Schema       | File Group     | Descrição 
dbo          | PRIMARY        | 
ServerHost   | ServerHost     | Servidores, estações de trabalho físicos e virtuais ou notebooks
SGBD         | SGBD           | Instância de banco, base de dados, schema, tabelas, colunas, index etc. 
Aplication   | Aplication     | Servidores web, aplicações, configuração interna.
UserGroup    | UserGroup      | Usuários importado dos Active Directory
AUDITING     | AUDITING       | Dados de auditoria do sistema de inventário.
LOG          | LOG            | Log transacional do banco de dados.

Observação: este script foi criado em DESENVOLVIMENTO, por este motivo os arquivos estão no mesmo lugar para produção
é recomendado a distribuição dos arquivos em disco diferentes.

*************************************************************************************************************/
USE [master]
GO

CREATE DATABASE [inventario_vm]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'dbo_00', FILENAME = N'D:\Data\inventario_vm_dbo_00.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB ),
( NAME = N'dbo_01', FILENAME = N'D:\Data\inventario_vm_dbo_01.ndf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB ),
( NAME = N'dbo_02', FILENAME = N'D:\Data\inventario_vm_dbo_02.ndf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB ),

 FILEGROUP [staging] 
( NAME = N'staging _10', FILENAME = N'D:\Data\inventario_vm_staging _10.ndf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB ),
( NAME = N'staging _11', FILENAME = N'D:\Data\inventario_vm_staging _11.ndf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB ),
( NAME = N'staging _12', FILENAME = N'D:\Data\inventario_vm_staging _12.ndf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB ),

 FILEGROUP [ServerHost] 
( NAME = N'ServerHost_10', FILENAME = N'D:\Data\inventario_vm_ServerHost_10.ndf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB ),
( NAME = N'ServerHost_11', FILENAME = N'D:\Data\inventario_vm_ServerHost_11.ndf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB ),
( NAME = N'ServerHost_12', FILENAME = N'D:\Data\inventario_vm_ServerHost_12.ndf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB ),

 FILEGROUP [SGBD] 
( NAME = N'SGBD_10', FILENAME = N'D:\Data\inventario_vm_SGBD_10.ndf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB ),
( NAME = N'SGBD_11', FILENAME = N'D:\Data\inventario_vm_SGBD_11.ndf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB ),
( NAME = N'SGBD_12', FILENAME = N'D:\Data\inventario_vm_SGBD_12.ndf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB ),

 FILEGROUP [Aplication] 
( NAME = N'Aplication_10', FILENAME = N'D:\Data\inventario_vm_Aplication_10.ndf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB ),
( NAME = N'Aplication_11', FILENAME = N'D:\Data\inventario_vm_Aplication_11.ndf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB ),
( NAME = N'Aplication_12', FILENAME = N'D:\Data\inventario_vm_Aplication_12.ndf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB ),

 FILEGROUP [UserGroup] 
( NAME = N'UserGroup_10', FILENAME = N'D:\Data\inventario_vm_UserGroup_10.ndf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB ),
( NAME = N'UserGroup_11', FILENAME = N'D:\Data\inventario_vm_UserGroup_11.ndf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB ),
( NAME = N'UserGroup_12', FILENAME = N'D:\Data\inventario_vm_UserGroup_12.ndf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB ),

 FILEGROUP [AUDITING] 
( NAME = N'auditing_00', FILENAME = N'D:\Data\inventario_vm_auditing_00.ndf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB ), 
( NAME = N'auditing_01', FILENAME = N'D:\Data\inventario_vm_auditing_01.ndf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB ), 

 FILEGROUP [Fato1] 
( NAME = N'fato_10', FILENAME = N'D:\Data\inventario_vm_fato_10.ndf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB ), 
( NAME = N'fato_11', FILENAME = N'D:\Data\inventario_vm_fato_11.ndf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB ), 

 FILEGROUP [Fato2] 
( NAME = N'fato_20', FILENAME = N'D:\Data\inventario_vm_fato_20.ndf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB ), 
( NAME = N'fato_21', FILENAME = N'D:\Data\inventario_vm_fato_21.ndf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB ), 

 FILEGROUP [Fato3] 
( NAME = N'fato_30', FILENAME = N'D:\Data\inventario_vm_fato_30.ndf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB ), 
( NAME = N'fato_31', FILENAME = N'D:\Data\inventario_vm_fato_31.ndf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB ), 

 FILEGROUP [INDEX] 
( NAME = N'index_00', FILENAME = N'D:\Data\inventario_vm_index_00.ndf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB ), 
( NAME = N'index_01', FILENAME = N'D:\Data\inventario_vm_index_01.ndf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB ), 
( NAME = N'index_02', FILENAME = N'D:\Data\inventario_vm_index_02.ndf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )

 LOG ON 
( NAME = N'Log', FILENAME = N'E:\Log\inventario_vm_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [inventario_vm].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [inventario_vm] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [inventario_vm] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [inventario_vm] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [inventario_vm] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [inventario_vm] SET ARITHABORT OFF 
GO

ALTER DATABASE [inventario_vm] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [inventario_vm] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [inventario_vm] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [inventario_vm] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [inventario_vm] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [inventario_vm] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [inventario_vm] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [inventario_vm] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [inventario_vm] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [inventario_vm] SET  DISABLE_BROKER 
GO

ALTER DATABASE [inventario_vm] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [inventario_vm] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [inventario_vm] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [inventario_vm] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [inventario_vm] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [inventario_vm] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [inventario_vm] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [inventario_vm] SET RECOVERY SIMPLE 
GO

ALTER DATABASE [inventario_vm] SET  MULTI_USER 
GO

ALTER DATABASE [inventario_vm] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [inventario_vm] SET DB_CHAINING OFF 
GO

ALTER DATABASE [inventario_vm] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO

ALTER DATABASE [inventario_vm] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO

ALTER DATABASE [inventario_vm] SET DELAYED_DURABILITY = DISABLED 
GO

ALTER DATABASE [inventario_vm] SET QUERY_STORE = OFF
GO

USE [inventario_vm]
GO

ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO

ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO

ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO

ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO

ALTER DATABASE [inventario_vm] SET  READ_WRITE 
GO


