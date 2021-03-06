-- =============================================
-- Author:		Alex Evdokimenko
-- Create date: 2016-05-01
-- Description:	Converts from UNIX time to datetime
-- Example:
--		select dbo.FromUnixTime(-446774400)
--		select dbo.FromUnixTime(1445385600)
-- =============================================
CREATE FUNCTION [dbo].[FromUnixTime] 
(
	-- Add the parameters for the function here
	@unixTime int
)
RETURNS datetime
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result datetime

	-- Add the T-SQL statements to compute the return value here
	SELECT @Result = dateadd(S, @unixTime, '1970-01-01')

	-- Return the result of the function
	RETURN @Result
END
