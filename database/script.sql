-- =============================================
-- IT Equipment Management - Database Script
-- SQL Server 2019+
-- Generated from Entity Framework Core 8.0 Models
-- =============================================

USE [master]
GO

-- Create database if not exists
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'ITEquipmentManagement')
BEGIN
    CREATE DATABASE [ITEquipmentManagement]
END
GO

USE [ITEquipmentManagement]
GO

-- =============================================
-- 1. Departments
-- =============================================
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Departments')
CREATE TABLE [dbo].[Departments] (
    [Id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [DepartmentCode] NVARCHAR(50) NOT NULL,
    [DepartmentName] NVARCHAR(200) NOT NULL,
    [IsActive] BIT NOT NULL DEFAULT 1,
    [CreatedDate] DATETIME2 NOT NULL DEFAULT GETDATE(),
    [CreatedBy] NVARCHAR(MAX) NULL
);
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Departments_DepartmentCode')
    CREATE UNIQUE INDEX [IX_Departments_DepartmentCode] ON [dbo].[Departments]([DepartmentCode]);
GO

-- =============================================
-- 2. Employees
-- =============================================
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Employees')
CREATE TABLE [dbo].[Employees] (
    [Id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [EmployeeCode] NVARCHAR(50) NOT NULL,
    [EmployeeName] NVARCHAR(100) NOT NULL,
    [Department] NVARCHAR(100) NULL,
    [Email] NVARCHAR(200) NULL,
    [Phone] NVARCHAR(50) NULL,
    [EmployeeType] NVARCHAR(50) NULL,
    [UserId] INT NULL,
    [IsActive] BIT NOT NULL DEFAULT 1,
    [CreatedDate] DATETIME2 NOT NULL DEFAULT GETDATE()
);
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Employees_EmployeeCode')
    CREATE UNIQUE INDEX [IX_Employees_EmployeeCode] ON [dbo].[Employees]([EmployeeCode]);
GO

-- =============================================
-- 3. Users
-- =============================================
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Users')
CREATE TABLE [dbo].[Users] (
    [Id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [UserId] NVARCHAR(50) NOT NULL,
    [PasswordHash] NVARCHAR(256) NOT NULL,
    [FullName] NVARCHAR(100) NOT NULL,
    [Email] NVARCHAR(200) NULL,
    [Role] NVARCHAR(50) NOT NULL DEFAULT 'User',
    [EmployeeId] INT NULL,
    [IsActive] BIT NOT NULL DEFAULT 1,
    [CreatedDate] DATETIME2 NOT NULL DEFAULT GETDATE(),
    [LastLoginDate] DATETIME2 NULL,
    CONSTRAINT [FK_Users_Employees] FOREIGN KEY ([EmployeeId]) REFERENCES [dbo].[Employees]([Id]) ON DELETE SET NULL
);
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Users_UserId')
    CREATE UNIQUE INDEX [IX_Users_UserId] ON [dbo].[Users]([UserId]);
GO

-- =============================================
-- 4. Suppliers
-- =============================================
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Suppliers')
CREATE TABLE [dbo].[Suppliers] (
    [Id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [SupplierCode] NVARCHAR(50) NOT NULL,
    [SupplierName] NVARCHAR(200) NOT NULL,
    [ContactPerson] NVARCHAR(100) NULL,
    [Phone] NVARCHAR(50) NULL,
    [Email] NVARCHAR(200) NULL,
    [Address] NVARCHAR(500) NULL,
    [Note] NVARCHAR(MAX) NULL,
    [IsActive] BIT NOT NULL DEFAULT 1,
    [CreatedDate] DATETIME2 NOT NULL DEFAULT GETDATE(),
    [CreatedBy] NVARCHAR(MAX) NULL,
    [UpdatedDate] DATETIME2 NULL,
    [UpdatedBy] NVARCHAR(MAX) NULL
);
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Suppliers_SupplierCode')
    CREATE UNIQUE INDEX [IX_Suppliers_SupplierCode] ON [dbo].[Suppliers]([SupplierCode]);
GO

-- =============================================
-- 5. Locations
-- =============================================
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Locations')
CREATE TABLE [dbo].[Locations] (
    [Id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [LocationCode] NVARCHAR(50) NOT NULL,
    [LocationName] NVARCHAR(200) NOT NULL,
    [Description] NVARCHAR(500) NULL,
    [IsActive] BIT NOT NULL DEFAULT 1,
    [CreatedDate] DATETIME2 NOT NULL DEFAULT GETDATE(),
    [CreatedBy] NVARCHAR(MAX) NULL,
    [UpdatedDate] DATETIME2 NULL,
    [UpdatedBy] NVARCHAR(MAX) NULL
);
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Locations_LocationCode')
    CREATE UNIQUE INDEX [IX_Locations_LocationCode] ON [dbo].[Locations]([LocationCode]);
GO

-- =============================================
-- 6. LocationNameHistories
-- =============================================
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'LocationNameHistories')
CREATE TABLE [dbo].[LocationNameHistories] (
    [Id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [LocationId] INT NOT NULL,
    [OldName] NVARCHAR(200) NOT NULL,
    [NewName] NVARCHAR(200) NOT NULL,
    [ChangedDate] DATETIME2 NOT NULL DEFAULT GETDATE(),
    [ChangedBy] NVARCHAR(MAX) NULL,
    CONSTRAINT [FK_LocationNameHistories_Locations] FOREIGN KEY ([LocationId]) REFERENCES [dbo].[Locations]([Id]) ON DELETE CASCADE
);
GO

-- =============================================
-- 7. ItemCategories
-- =============================================
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'ItemCategories')
CREATE TABLE [dbo].[ItemCategories] (
    [Id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [CategoryCode] NVARCHAR(50) NOT NULL,
    [CategoryName] NVARCHAR(200) NOT NULL,
    [ItemType] NVARCHAR(20) NOT NULL,
    [Description] NVARCHAR(500) NULL,
    [RequireChecklist] BIT NOT NULL DEFAULT 0,
    [RequireMaintenance] BIT NOT NULL DEFAULT 0,
    [MaintenanceFrequencyDays] INT NOT NULL DEFAULT 0,
    [IsActive] BIT NOT NULL DEFAULT 1,
    [CreatedDate] DATETIME2 NOT NULL DEFAULT GETDATE(),
    [CreatedBy] NVARCHAR(MAX) NULL,
    [UpdatedDate] DATETIME2 NULL,
    [UpdatedBy] NVARCHAR(MAX) NULL
);
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_ItemCategories_CategoryCode')
    CREATE UNIQUE INDEX [IX_ItemCategories_CategoryCode] ON [dbo].[ItemCategories]([CategoryCode]);
GO

-- =============================================
-- 8. CategoryAttributes
-- =============================================
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'CategoryAttributes')
CREATE TABLE [dbo].[CategoryAttributes] (
    [Id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [CategoryId] INT NOT NULL,
    [AttributeName] NVARCHAR(200) NOT NULL,
    [AttributeCode] NVARCHAR(100) NOT NULL,
    [DataType] NVARCHAR(50) NULL DEFAULT 'Text',
    [ListValues] NVARCHAR(MAX) NULL,
    [IsRequired] BIT NOT NULL DEFAULT 0,
    [DisplayOrder] INT NOT NULL DEFAULT 0,
    [IsActive] BIT NOT NULL DEFAULT 1,
    [CreatedDate] DATETIME2 NOT NULL DEFAULT GETDATE(),
    CONSTRAINT [FK_CategoryAttributes_ItemCategories] FOREIGN KEY ([CategoryId]) REFERENCES [dbo].[ItemCategories]([Id]) ON DELETE CASCADE
);
GO

-- =============================================
-- 9. Equipment
-- =============================================
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Equipment')
CREATE TABLE [dbo].[Equipment] (
    [Id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [EquipmentCode] NVARCHAR(50) NOT NULL,
    [EquipmentName] NVARCHAR(200) NOT NULL,
    [CategoryId] INT NOT NULL,
    [SupplierId] INT NULL,
    [LocationId] INT NULL,
    [DepartmentId] INT NULL,
    [InstallerId] INT NULL,
    [CheckerId] INT NULL,
    [Status] NVARCHAR(50) NULL DEFAULT 'InStock',
    [PreviousStatus] NVARCHAR(50) NULL,
    [PurchaseDate] DATETIME2 NULL,
    [InstallDate] DATETIME2 NULL,
    [Note] NVARCHAR(MAX) NULL,
    [IsActive] BIT NOT NULL DEFAULT 1,
    [CreatedDate] DATETIME2 NOT NULL DEFAULT GETDATE(),
    [CreatedBy] NVARCHAR(MAX) NULL,
    [UpdatedDate] DATETIME2 NULL,
    [UpdatedBy] NVARCHAR(MAX) NULL,
    CONSTRAINT [FK_Equipment_ItemCategories] FOREIGN KEY ([CategoryId]) REFERENCES [dbo].[ItemCategories]([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_Equipment_Suppliers] FOREIGN KEY ([SupplierId]) REFERENCES [dbo].[Suppliers]([Id]),
    CONSTRAINT [FK_Equipment_Locations] FOREIGN KEY ([LocationId]) REFERENCES [dbo].[Locations]([Id]),
    CONSTRAINT [FK_Equipment_Departments] FOREIGN KEY ([DepartmentId]) REFERENCES [dbo].[Departments]([Id]),
    CONSTRAINT [FK_Equipment_Installer] FOREIGN KEY ([InstallerId]) REFERENCES [dbo].[Employees]([Id]) ON DELETE NO ACTION,
    CONSTRAINT [FK_Equipment_Checker] FOREIGN KEY ([CheckerId]) REFERENCES [dbo].[Employees]([Id]) ON DELETE NO ACTION
);
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Equipment_EquipmentCode')
    CREATE UNIQUE INDEX [IX_Equipment_EquipmentCode] ON [dbo].[Equipment]([EquipmentCode]);
GO

-- =============================================
-- 10. EquipmentAttributeValues
-- =============================================
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'EquipmentAttributeValues')
CREATE TABLE [dbo].[EquipmentAttributeValues] (
    [Id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [EquipmentId] INT NOT NULL,
    [AttributeId] INT NOT NULL,
    [AttributeValue] NVARCHAR(MAX) NULL,
    [UpdatedDate] DATETIME2 NOT NULL DEFAULT GETDATE(),
    [UpdatedBy] NVARCHAR(MAX) NULL,
    CONSTRAINT [FK_EquipmentAttributeValues_Equipment] FOREIGN KEY ([EquipmentId]) REFERENCES [dbo].[Equipment]([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_EquipmentAttributeValues_CategoryAttributes] FOREIGN KEY ([AttributeId]) REFERENCES [dbo].[CategoryAttributes]([Id]) ON DELETE NO ACTION
);
GO

-- =============================================
-- 11. EquipmentNameHistories
-- =============================================
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'EquipmentNameHistories')
CREATE TABLE [dbo].[EquipmentNameHistories] (
    [Id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [EquipmentId] INT NOT NULL,
    [OldName] NVARCHAR(200) NOT NULL,
    [NewName] NVARCHAR(200) NOT NULL,
    [ChangedDate] DATETIME2 NOT NULL DEFAULT GETDATE(),
    [ChangedBy] NVARCHAR(MAX) NULL,
    CONSTRAINT [FK_EquipmentNameHistories_Equipment] FOREIGN KEY ([EquipmentId]) REFERENCES [dbo].[Equipment]([Id]) ON DELETE CASCADE
);
GO

-- =============================================
-- 12. Components
-- =============================================
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Components')
CREATE TABLE [dbo].[Components] (
    [Id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [ComponentCode] NVARCHAR(50) NOT NULL,
    [ComponentName] NVARCHAR(200) NOT NULL,
    [CategoryId] INT NOT NULL,
    [SupplierId] INT NULL,
    [OpeningStock] INT NOT NULL DEFAULT 0,
    [CurrentStock] INT NOT NULL DEFAULT 0,
    [SafetyStock] INT NOT NULL DEFAULT 0,
    [Unit] NVARCHAR(50) NOT NULL,
    [Status] NVARCHAR(50) NULL DEFAULT 'InStock',
    [PurchaseDate] DATETIME2 NULL,
    [Note] NVARCHAR(MAX) NULL,
    [IsActive] BIT NOT NULL DEFAULT 1,
    [CreatedDate] DATETIME2 NOT NULL DEFAULT GETDATE(),
    [CreatedBy] NVARCHAR(MAX) NULL,
    [UpdatedDate] DATETIME2 NULL,
    [UpdatedBy] NVARCHAR(MAX) NULL,
    CONSTRAINT [FK_Components_ItemCategories] FOREIGN KEY ([CategoryId]) REFERENCES [dbo].[ItemCategories]([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_Components_Suppliers] FOREIGN KEY ([SupplierId]) REFERENCES [dbo].[Suppliers]([Id])
);
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Components_ComponentCode')
    CREATE UNIQUE INDEX [IX_Components_ComponentCode] ON [dbo].[Components]([ComponentCode]);
GO

-- =============================================
-- 13. ComponentAttributeValues
-- =============================================
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'ComponentAttributeValues')
CREATE TABLE [dbo].[ComponentAttributeValues] (
    [Id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [ComponentId] INT NOT NULL,
    [AttributeId] INT NOT NULL,
    [AttributeValue] NVARCHAR(MAX) NULL,
    [UpdatedDate] DATETIME2 NOT NULL DEFAULT GETDATE(),
    [UpdatedBy] NVARCHAR(MAX) NULL,
    CONSTRAINT [FK_ComponentAttributeValues_Components] FOREIGN KEY ([ComponentId]) REFERENCES [dbo].[Components]([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_ComponentAttributeValues_CategoryAttributes] FOREIGN KEY ([AttributeId]) REFERENCES [dbo].[CategoryAttributes]([Id]) ON DELETE NO ACTION
);
GO

-- =============================================
-- 14. ComponentNameHistories
-- =============================================
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'ComponentNameHistories')
CREATE TABLE [dbo].[ComponentNameHistories] (
    [Id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [ComponentId] INT NOT NULL,
    [OldName] NVARCHAR(200) NOT NULL,
    [NewName] NVARCHAR(200) NOT NULL,
    [ChangedDate] DATETIME2 NOT NULL DEFAULT GETDATE(),
    [ChangedBy] NVARCHAR(MAX) NULL,
    CONSTRAINT [FK_ComponentNameHistories_Components] FOREIGN KEY ([ComponentId]) REFERENCES [dbo].[Components]([Id]) ON DELETE CASCADE
);
GO

-- =============================================
-- 15. Transactions
-- =============================================
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Transactions')
CREATE TABLE [dbo].[Transactions] (
    [Id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [TransactionCode] NVARCHAR(50) NOT NULL,
    [TransactionType] NVARCHAR(20) NOT NULL,
    [TransactionDate] DATETIME2 NOT NULL DEFAULT GETDATE(),
    [ComponentId] INT NOT NULL,
    [Quantity] INT NOT NULL DEFAULT 1,
    [RelatedEquipmentId] INT NULL,
    [DocumentRef] NVARCHAR(200) NULL,
    [PurchaseDate] DATETIME2 NULL,
    [PerformedById] INT NULL,
    [ReceiverName] NVARCHAR(200) NULL,
    [Reason] NVARCHAR(500) NULL,
    [Note] NVARCHAR(MAX) NULL,
    [CreatedBy] NVARCHAR(MAX) NULL,
    [CreatedDate] DATETIME2 NOT NULL DEFAULT GETDATE(),
    CONSTRAINT [FK_Transactions_Components] FOREIGN KEY ([ComponentId]) REFERENCES [dbo].[Components]([Id]) ON DELETE NO ACTION,
    CONSTRAINT [FK_Transactions_Equipment] FOREIGN KEY ([RelatedEquipmentId]) REFERENCES [dbo].[Equipment]([Id]) ON DELETE NO ACTION,
    CONSTRAINT [FK_Transactions_Employees] FOREIGN KEY ([PerformedById]) REFERENCES [dbo].[Employees]([Id]) ON DELETE NO ACTION
);
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Transactions_TransactionCode')
    CREATE UNIQUE INDEX [IX_Transactions_TransactionCode] ON [dbo].[Transactions]([TransactionCode]);
GO

-- =============================================
-- 16. MaintenanceSchedules
-- =============================================
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'MaintenanceSchedules')
CREATE TABLE [dbo].[MaintenanceSchedules] (
    [Id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [CategoryId] INT NULL,
    [EquipmentId] INT NOT NULL,
    [ScheduleName] NVARCHAR(200) NOT NULL,
    [FrequencyType] NVARCHAR(20) NULL DEFAULT 'Yearly',
    [FrequencyDays] INT NOT NULL DEFAULT 0,
    [LastMaintenanceDate] DATETIME2 NULL,
    [NextMaintenanceDate] DATETIME2 NOT NULL,
    [AssignedEmployeeId] INT NULL,
    [Status] NVARCHAR(50) NULL DEFAULT 'Pending',
    [IsActive] BIT NOT NULL DEFAULT 1,
    [CreatedDate] DATETIME2 NOT NULL DEFAULT GETDATE(),
    [CreatedBy] NVARCHAR(MAX) NULL,
    CONSTRAINT [FK_MaintenanceSchedules_ItemCategories] FOREIGN KEY ([CategoryId]) REFERENCES [dbo].[ItemCategories]([Id]),
    CONSTRAINT [FK_MaintenanceSchedules_Equipment] FOREIGN KEY ([EquipmentId]) REFERENCES [dbo].[Equipment]([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_MaintenanceSchedules_Employees] FOREIGN KEY ([AssignedEmployeeId]) REFERENCES [dbo].[Employees]([Id]) ON DELETE NO ACTION
);
GO

-- =============================================
-- 17. MaintenanceTickets
-- =============================================
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'MaintenanceTickets')
CREATE TABLE [dbo].[MaintenanceTickets] (
    [Id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [TicketCode] NVARCHAR(50) NOT NULL,
    [MaintenanceType] NVARCHAR(20) NULL DEFAULT 'Planned',
    [EquipmentId] INT NOT NULL,
    [ScheduleId] INT NULL,
    [PerformedById] INT NULL,
    [MaintenanceDate] DATETIME2 NOT NULL,
    [Description] NVARCHAR(MAX) NULL,
    [Result] NVARCHAR(MAX) NULL,
    [Status] NVARCHAR(50) NULL DEFAULT 'Planned',
    [CompletedDate] DATETIME2 NULL,
    [Note] NVARCHAR(MAX) NULL,
    [CreatedDate] DATETIME2 NOT NULL DEFAULT GETDATE(),
    [CreatedBy] NVARCHAR(MAX) NULL,
    CONSTRAINT [FK_MaintenanceTickets_Equipment] FOREIGN KEY ([EquipmentId]) REFERENCES [dbo].[Equipment]([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_MaintenanceTickets_MaintenanceSchedules] FOREIGN KEY ([ScheduleId]) REFERENCES [dbo].[MaintenanceSchedules]([Id]),
    CONSTRAINT [FK_MaintenanceTickets_Employees] FOREIGN KEY ([PerformedById]) REFERENCES [dbo].[Employees]([Id]) ON DELETE NO ACTION
);
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_MaintenanceTickets_TicketCode')
    CREATE UNIQUE INDEX [IX_MaintenanceTickets_TicketCode] ON [dbo].[MaintenanceTickets]([TicketCode]);
GO

-- =============================================
-- 18. RepairTickets
-- =============================================
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'RepairTickets')
CREATE TABLE [dbo].[RepairTickets] (
    [Id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [TicketCode] NVARCHAR(50) NOT NULL,
    [EquipmentId] INT NOT NULL,
    [AssignedEmployeeId] INT NULL,
    [ReportDate] DATETIME2 NOT NULL,
    [IssueDescription] NVARCHAR(MAX) NOT NULL,
    [RepairDescription] NVARCHAR(MAX) NULL,
    [Status] NVARCHAR(50) NULL DEFAULT 'Reported',
    [CompletedDate] DATETIME2 NULL,
    [Note] NVARCHAR(MAX) NULL,
    [CreatedDate] DATETIME2 NOT NULL DEFAULT GETDATE(),
    [CreatedBy] NVARCHAR(MAX) NULL,
    CONSTRAINT [FK_RepairTickets_Equipment] FOREIGN KEY ([EquipmentId]) REFERENCES [dbo].[Equipment]([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_RepairTickets_Employees] FOREIGN KEY ([AssignedEmployeeId]) REFERENCES [dbo].[Employees]([Id]) ON DELETE NO ACTION
);
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_RepairTickets_TicketCode')
    CREATE UNIQUE INDEX [IX_RepairTickets_TicketCode] ON [dbo].[RepairTickets]([TicketCode]);
GO

-- =============================================
-- 19. ChecklistMasterItems
-- =============================================
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'ChecklistMasterItems')
CREATE TABLE [dbo].[ChecklistMasterItems] (
    [Id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [ItemName] NVARCHAR(200) NOT NULL,
    [ItemCode] NVARCHAR(100) NOT NULL,
    [Description] NVARCHAR(500) NULL,
    [IsActive] BIT NOT NULL DEFAULT 1,
    [DisplayOrder] INT NOT NULL DEFAULT 0,
    [CreatedDate] DATETIME2 NOT NULL DEFAULT GETDATE(),
    [CreatedBy] NVARCHAR(MAX) NULL
);
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_ChecklistMasterItems_ItemCode')
    CREATE UNIQUE INDEX [IX_ChecklistMasterItems_ItemCode] ON [dbo].[ChecklistMasterItems]([ItemCode]);
GO

-- =============================================
-- 20. CategoryChecklistMappings
-- =============================================
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'CategoryChecklistMappings')
CREATE TABLE [dbo].[CategoryChecklistMappings] (
    [Id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [CategoryId] INT NOT NULL,
    [ChecklistItemId] INT NOT NULL,
    [IsActive] BIT NOT NULL DEFAULT 1,
    CONSTRAINT [FK_CategoryChecklistMappings_ItemCategories] FOREIGN KEY ([CategoryId]) REFERENCES [dbo].[ItemCategories]([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_CategoryChecklistMappings_ChecklistMasterItems] FOREIGN KEY ([ChecklistItemId]) REFERENCES [dbo].[ChecklistMasterItems]([Id]) ON DELETE CASCADE
);
GO

-- =============================================
-- 21. ChecklistHeaders
-- =============================================
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'ChecklistHeaders')
CREATE TABLE [dbo].[ChecklistHeaders] (
    [Id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [ChecklistCode] NVARCHAR(50) NOT NULL,
    [EquipmentId] INT NOT NULL,
    [InstallDate] DATETIME2 NOT NULL,
    [InstallerId] INT NULL,
    [CheckerId] INT NULL,
    [Status] NVARCHAR(50) NULL DEFAULT 'Pending',
    [DueDate] DATETIME2 NULL,
    [CompletedDate] DATETIME2 NULL,
    [EmailNotification] BIT NOT NULL DEFAULT 0,
    [NotifyEmail] NVARCHAR(500) NULL,
    [Note] NVARCHAR(MAX) NULL,
    [CreatedDate] DATETIME2 NOT NULL DEFAULT GETDATE(),
    [CreatedBy] NVARCHAR(MAX) NULL,
    CONSTRAINT [FK_ChecklistHeaders_Equipment] FOREIGN KEY ([EquipmentId]) REFERENCES [dbo].[Equipment]([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_ChecklistHeaders_Installer] FOREIGN KEY ([InstallerId]) REFERENCES [dbo].[Employees]([Id]) ON DELETE NO ACTION,
    CONSTRAINT [FK_ChecklistHeaders_Checker] FOREIGN KEY ([CheckerId]) REFERENCES [dbo].[Employees]([Id]) ON DELETE NO ACTION
);
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_ChecklistHeaders_ChecklistCode')
    CREATE UNIQUE INDEX [IX_ChecklistHeaders_ChecklistCode] ON [dbo].[ChecklistHeaders]([ChecklistCode]);
GO

-- =============================================
-- 22. ChecklistDetails
-- =============================================
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'ChecklistDetails')
CREATE TABLE [dbo].[ChecklistDetails] (
    [Id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [ChecklistHeaderId] INT NOT NULL,
    [ChecklistItemId] INT NOT NULL,
    [Status] NVARCHAR(10) NULL,
    [Note] NVARCHAR(MAX) NULL,
    [CheckedDate] DATETIME2 NULL,
    [CheckedBy] NVARCHAR(MAX) NULL,
    CONSTRAINT [FK_ChecklistDetails_ChecklistHeaders] FOREIGN KEY ([ChecklistHeaderId]) REFERENCES [dbo].[ChecklistHeaders]([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_ChecklistDetails_ChecklistMasterItems] FOREIGN KEY ([ChecklistItemId]) REFERENCES [dbo].[ChecklistMasterItems]([Id]) ON DELETE CASCADE
);
GO

-- =============================================
-- 23. DisposalRecords
-- =============================================
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'DisposalRecords')
CREATE TABLE [dbo].[DisposalRecords] (
    [Id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [DisposalCode] NVARCHAR(50) NOT NULL,
    [ItemType] NVARCHAR(20) NOT NULL,
    [EquipmentId] INT NULL,
    [ComponentId] INT NULL,
    [Quantity] INT NOT NULL DEFAULT 1,
    [DisposalDate] DATETIME2 NOT NULL,
    [Reason] NVARCHAR(MAX) NULL,
    [ApprovedById] INT NULL,
    [Status] NVARCHAR(50) NULL DEFAULT 'Pending',
    [Note] NVARCHAR(MAX) NULL,
    [CreatedDate] DATETIME2 NOT NULL DEFAULT GETDATE(),
    [CreatedBy] NVARCHAR(MAX) NULL,
    CONSTRAINT [FK_DisposalRecords_Equipment] FOREIGN KEY ([EquipmentId]) REFERENCES [dbo].[Equipment]([Id]),
    CONSTRAINT [FK_DisposalRecords_Components] FOREIGN KEY ([ComponentId]) REFERENCES [dbo].[Components]([Id]),
    CONSTRAINT [FK_DisposalRecords_Employees] FOREIGN KEY ([ApprovedById]) REFERENCES [dbo].[Employees]([Id]) ON DELETE NO ACTION
);
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_DisposalRecords_DisposalCode')
    CREATE UNIQUE INDEX [IX_DisposalRecords_DisposalCode] ON [dbo].[DisposalRecords]([DisposalCode]);
GO

-- =============================================
-- 24. UpdateHistories
-- =============================================
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'UpdateHistories')
CREATE TABLE [dbo].[UpdateHistories] (
    [Id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [EquipmentId] INT NOT NULL,
    [CategoryId] INT NULL,
    [UpdatePeriod] NVARCHAR(20) NULL,
    [UpdateType] NVARCHAR(100) NOT NULL,
    [Status] NVARCHAR(50) NULL DEFAULT 'Pending',
    [CompletedDate] DATETIME2 NULL,
    [AssignedEmployeeId] INT NULL,
    [Note] NVARCHAR(MAX) NULL,
    [CreatedDate] DATETIME2 NOT NULL DEFAULT GETDATE(),
    [CreatedBy] NVARCHAR(MAX) NULL,
    CONSTRAINT [FK_UpdateHistories_Equipment] FOREIGN KEY ([EquipmentId]) REFERENCES [dbo].[Equipment]([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_UpdateHistories_ItemCategories] FOREIGN KEY ([CategoryId]) REFERENCES [dbo].[ItemCategories]([Id]),
    CONSTRAINT [FK_UpdateHistories_Employees] FOREIGN KEY ([AssignedEmployeeId]) REFERENCES [dbo].[Employees]([Id]) ON DELETE NO ACTION
);
GO

-- =============================================
-- 25. EmailSettings
-- =============================================
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'EmailSettings')
CREATE TABLE [dbo].[EmailSettings] (
    [Id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [SmtpServer] NVARCHAR(200) NOT NULL,
    [SmtpPort] INT NOT NULL DEFAULT 587,
    [SmtpUsername] NVARCHAR(200) NULL,
    [SmtpPassword] NVARCHAR(200) NULL,
    [FromEmail] NVARCHAR(200) NULL,
    [FromName] NVARCHAR(200) NULL,
    [EnableSsl] BIT NOT NULL DEFAULT 1,
    [IsActive] BIT NOT NULL DEFAULT 1,
    [UpdatedDate] DATETIME2 NULL
);
GO

-- =============================================
-- 26. NotificationConfigs
-- =============================================
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'NotificationConfigs')
CREATE TABLE [dbo].[NotificationConfigs] (
    [Id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [NotificationType] NVARCHAR(100) NOT NULL,
    [DisplayName] NVARCHAR(200) NULL,
    [IsEnabled] BIT NOT NULL DEFAULT 1,
    [Description] NVARCHAR(500) NULL,
    [SubjectTemplate] NVARCHAR(500) NULL,
    [RecipientEmails] NVARCHAR(1000) NULL,
    [SendFrequency] NVARCHAR(20) NOT NULL DEFAULT 'Daily',
    [SendTime] NVARCHAR(5) NOT NULL DEFAULT '07:00',
    [GroupByRecipient] BIT NOT NULL DEFAULT 1,
    [LastSentDate] DATETIME2 NULL
);
GO

-- =============================================
-- 27. EmailLogs
-- =============================================
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'EmailLogs')
CREATE TABLE [dbo].[EmailLogs] (
    [Id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [NotificationType] NVARCHAR(100) NOT NULL,
    [ToEmail] NVARCHAR(500) NOT NULL,
    [Subject] NVARCHAR(500) NOT NULL,
    [Body] NVARCHAR(MAX) NULL,
    [Status] NVARCHAR(50) NOT NULL,
    [ErrorMessage] NVARCHAR(MAX) NULL,
    [SentDate] DATETIME2 NOT NULL DEFAULT GETDATE()
);
GO

-- =============================================
-- SEED DATA
-- =============================================

-- Admin user (password: Admin@123)
IF NOT EXISTS (SELECT 1 FROM [dbo].[Users] WHERE [UserId] = 'admin')
BEGIN
    SET IDENTITY_INSERT [dbo].[Users] ON;
    INSERT INTO [dbo].[Users] ([Id], [UserId], [PasswordHash], [FullName], [Email], [Role], [IsActive], [CreatedDate])
    VALUES (1, 'admin', '$2a$11$bMIpoHPzJIBP7/qhOt3q8uXOnCswTLNhchZ6oNecVcQ2P.yHaBSq6', 'Administrator', 'admin@company.com', 'Admin', 1, '2024-01-01');
    SET IDENTITY_INSERT [dbo].[Users] OFF;
END
GO

-- Notification Configs (English subjects)
IF NOT EXISTS (SELECT 1 FROM [dbo].[NotificationConfigs] WHERE [NotificationType] = 'MaintenanceDue')
BEGIN
    INSERT INTO [dbo].[NotificationConfigs] ([NotificationType], [DisplayName], [IsEnabled], [Description], [SubjectTemplate], [SendFrequency], [SendTime], [GroupByRecipient])
    VALUES
    ('MaintenanceDue', 'Maintenance Due', 1, 'Send alert when equipment is due for maintenance (within 7 days)', '[Alert] {count} equipment(s) due for maintenance', 'Daily', '07:00', 1),
    ('MaintenanceOverdue', 'Maintenance Overdue', 1, 'Send alert when equipment maintenance is overdue', '[URGENT] {count} equipment(s) OVERDUE for maintenance', 'Daily', '07:00', 1),
    ('ChecklistOverdue', 'Checklist Overdue', 1, 'Send alert when Checklist is incomplete and overdue', '[Alert] {count} Checklist(s) incomplete and overdue', 'Daily', '07:00', 1),
    ('ChecklistAssigned', 'Checklist Assigned', 1, 'Send notification when assigned to inspect a Checklist', '[Checklist] You have been assigned to inspect - {code}', 'Immediate', '07:00', 0),
    ('MaintenanceAssigned', 'Maintenance Assigned', 1, 'Send notification when assigned maintenance tickets', '[Maintenance] You have been assigned {count} new maintenance ticket(s)', 'Immediate', '07:00', 0),
    ('RepairAssigned', 'Repair Assigned', 1, 'Send notification when assigned a repair ticket', '[Repair] Ticket {code} - You have been assigned', 'Immediate', '07:00', 0),
    ('UpdateDue', 'Update Due', 0, 'Send alert when periodic updates are due', '[Alert] {count} equipment(s) due for update', 'Daily', '07:00', 1),
    ('LowStock', 'Low Stock', 0, 'Alert when components are below safety stock level', '[Alert] {count} component(s) below safety stock level', 'Daily', '07:00', 1),
    ('DisposalApproval', 'Disposal Approval', 1, 'Send notification when a disposal request needs approval', '[Disposal] Request {code} needs your approval', 'Immediate', '07:00', 0);
END
GO

PRINT '=========================================='
PRINT 'Database created successfully!'
PRINT 'Default login: admin / Admin@123'
PRINT '=========================================='
GO
