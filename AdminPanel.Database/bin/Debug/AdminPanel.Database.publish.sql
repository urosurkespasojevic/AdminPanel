﻿/*
Deployment script for AdminPanelDB

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "AdminPanelDB"
:setvar DefaultFilePrefix "AdminPanelDB"
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET PAGE_VERIFY NONE 
            WITH ROLLBACK IMMEDIATE;
    END


GO
USE [$(DatabaseName)];


GO
PRINT N'Rename refactoring operation with key 6348d94b-85a0-43f4-bf5e-cd385a460ed0 is skipped, element [dbo].[User].[Id] (SqlSimpleColumn) will not be renamed to ID';


GO
PRINT N'Rename refactoring operation with key 98b2cf29-c3f6-4930-8169-51880591ce05 is skipped, element [dbo].[Role].[Id] (SqlSimpleColumn) will not be renamed to ID';


GO
PRINT N'Rename refactoring operation with key e2e619e6-3191-4139-8cba-59cc04b30792 is skipped, element [dbo].[Category].[Id] (SqlSimpleColumn) will not be renamed to ID';


GO
PRINT N'Rename refactoring operation with key 365ae94b-035b-4bcd-9c89-1a7687c1c9bd is skipped, element [dbo].[Role].[RoleName] (SqlSimpleColumn) will not be renamed to Name';


GO
PRINT N'Rename refactoring operation with key deb8b734-6d50-499a-b2d3-0b3677dd467d is skipped, element [dbo].[News].[Id] (SqlSimpleColumn) will not be renamed to ID';


GO
PRINT N'Creating [dbo].[Category]...';


GO
CREATE TABLE [dbo].[Category] (
    [ID]   UNIQUEIDENTIFIER NOT NULL,
    [Name] NVARCHAR (50)    NOT NULL,
    CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [UNQ_Category_ID] UNIQUE NONCLUSTERED ([ID] ASC),
    CONSTRAINT [UNQ_Category_Name] UNIQUE NONCLUSTERED ([Name] ASC)
);


GO
PRINT N'Creating [dbo].[News]...';


GO
CREATE TABLE [dbo].[News] (
    [ID]         UNIQUEIDENTIFIER NOT NULL,
    [Title]      NVARCHAR (50)    NOT NULL,
    [Text]       TEXT             NOT NULL,
    [Date]       DATETIME         NOT NULL,
    [Image]      VARBINARY (MAX)  NOT NULL,
    [Author]     NVARCHAR (50)    NOT NULL,
    [CategoryID] UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [PK_News] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [UNQ_News_ID] UNIQUE NONCLUSTERED ([ID] ASC)
);


GO
PRINT N'Creating [dbo].[Role]...';


GO
CREATE TABLE [dbo].[Role] (
    [ID]   UNIQUEIDENTIFIER NOT NULL,
    [Name] NVARCHAR (50)    NOT NULL,
    CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [UNQ_Role_ID] UNIQUE NONCLUSTERED ([ID] ASC),
    CONSTRAINT [UNQ_Role_Name] UNIQUE NONCLUSTERED ([Name] ASC)
);


GO
PRINT N'Creating [dbo].[User]...';


GO
CREATE TABLE [dbo].[User] (
    [ID]     UNIQUEIDENTIFIER NOT NULL,
    [Email]  NVARCHAR (50)    NOT NULL,
    [RoleID] UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [UNQ_User_Email] UNIQUE NONCLUSTERED ([Email] ASC),
    CONSTRAINT [UNQ_User_ID] UNIQUE NONCLUSTERED ([ID] ASC)
);


GO
PRINT N'Creating unnamed constraint on [dbo].[Category]...';


GO
ALTER TABLE [dbo].[Category]
    ADD DEFAULT NEWID() FOR [ID];


GO
PRINT N'Creating unnamed constraint on [dbo].[News]...';


GO
ALTER TABLE [dbo].[News]
    ADD DEFAULT NEWID() FOR [ID];


GO
PRINT N'Creating unnamed constraint on [dbo].[Role]...';


GO
ALTER TABLE [dbo].[Role]
    ADD DEFAULT NEWID() FOR [ID];


GO
PRINT N'Creating unnamed constraint on [dbo].[User]...';


GO
ALTER TABLE [dbo].[User]
    ADD DEFAULT NEWID() FOR [ID];


GO
PRINT N'Creating [dbo].[FK_News_Category]...';


GO
ALTER TABLE [dbo].[News] WITH NOCHECK
    ADD CONSTRAINT [FK_News_Category] FOREIGN KEY ([CategoryID]) REFERENCES [dbo].[News] ([ID]);


GO
PRINT N'Creating [dbo].[FK_User_Role]...';


GO
ALTER TABLE [dbo].[User] WITH NOCHECK
    ADD CONSTRAINT [FK_User_Role] FOREIGN KEY ([RoleID]) REFERENCES [dbo].[Role] ([ID]);


GO
-- Refactoring step to update target server with deployed transaction logs

IF OBJECT_ID(N'dbo.__RefactorLog') IS NULL
BEGIN
    CREATE TABLE [dbo].[__RefactorLog] (OperationKey UNIQUEIDENTIFIER NOT NULL PRIMARY KEY)
    EXEC sp_addextendedproperty N'microsoft_database_tools_support', N'refactoring log', N'schema', N'dbo', N'table', N'__RefactorLog'
END
GO
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '6348d94b-85a0-43f4-bf5e-cd385a460ed0')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('6348d94b-85a0-43f4-bf5e-cd385a460ed0')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '98b2cf29-c3f6-4930-8169-51880591ce05')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('98b2cf29-c3f6-4930-8169-51880591ce05')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'e2e619e6-3191-4139-8cba-59cc04b30792')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('e2e619e6-3191-4139-8cba-59cc04b30792')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '365ae94b-035b-4bcd-9c89-1a7687c1c9bd')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('365ae94b-035b-4bcd-9c89-1a7687c1c9bd')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'deb8b734-6d50-499a-b2d3-0b3677dd467d')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('deb8b734-6d50-499a-b2d3-0b3677dd467d')

GO

GO
PRINT N'Checking existing data against newly created constraints';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [dbo].[News] WITH CHECK CHECK CONSTRAINT [FK_News_Category];

ALTER TABLE [dbo].[User] WITH CHECK CHECK CONSTRAINT [FK_User_Role];


GO
PRINT N'Update complete.';


GO
