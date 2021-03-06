-- ===============================================================
-- Author:		Alex Evdokimenko
-- Create date: 2018-05-15  
-- Requested by: DBAmp cookbook users	
-- Description: Helper function that returns all the reports - 
--				direct and indirect of the provided manager.
--				Uses common table expressions in MS SQL to traverse
--				organizational hierarchy. 
--	Notes:		To use this funcion you need to replicate [User] 
--				object to the local DB. 
-- ===============================================================
Create function [dbo].[GetAllReports](@ManagerName nvarchar(255))
RETURNS @AllReports TABLE 
(
    -- Columns returned by the function
    id nchar(18) PRIMARY KEY NOT NULL, 
	ManagerId nchar(18) NULL,
    Name nvarchar(255) NULL, 
    Email nvarchar(255) NULL, 
    Manager nvarchar(255) NULL, 
    [Level] int NULL
)
AS 
begin
	WITH DirectReports (Email, Name, ID, ManagerId, Manager, Level)
	AS
	(
	-- Anchor member definition
	SELECT Email, Name, ID, ManagerId, Manager__c, 0
	FROM [user]
	where isActive = 'true' and Name = @ManagerName
		UNION ALL
	-- Recursive member definition
		SELECT u.Email, u.Name, u.ID, u.ManagerId, u.Manager__c, d.level+1 
		FROM [user] AS u
		INNER JOIN DirectReports AS d
			ON u.ManagerID = d.id
		where IsActive = 'true'
	)

	insert @AllReports
	select id, ManagerId, Name, Email, Manager, Level
	from directreports
	return
end
