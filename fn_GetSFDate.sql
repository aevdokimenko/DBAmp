-- ===============================================================
-- Author:		Alex Evdokimenko
-- Create date: 2018-05-15  
-- Requested by: DBAmp cookbook users	
-- Description: Helper function, takes SQL datetime and returns date 
--				in long SF format.
-- ===============================================================
CREATE FUNCTION [dbo].[fn_GetSFDate] (@d datetime )
RETURNS NVARCHAR(20)
AS
BEGIN
	DECLARE @s NVARCHAR(20)
	

	Select @s = convert(varchar(30), DATEADD(dd, 0, DATEDIFF(dd, 0, @d)), 126) + 'Z';
	RETURN @s
END
