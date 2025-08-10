USE [DataPurBatch01]
GO

--SELECT TRY_CONVERT(INT, '123') AS Result;
--SELECT TRY_CONVERT(INT, 'ABC') AS Result;

BEGIN TRY
    -- This will cause a divide-by-zero error
    DECLARE @result INT;

--	 THROW 50001, 'Custom error message with throw.', 1;
 --   RAISERROR('Custom error message with riaseerror.', 10, 1);
	--SELECT 'Shamas'
	--RAISERROR('Custom error message with riaseerror.', 12, 1);
	--SELECT 'Imran'
	 SET @result = 10 / 0;
END TRY
BEGIN CATCH

DECLARE @message VARCHAR(MAX) = CHAR(10)
SELECT @message = 
CHAR(10) + 'Returns the error number: ' + CONVERT(VARCHAR(10), ERROR_NUMBER()) +
CHAR(10) + 'Returns the error description: ' + ERROR_MESSAGE() + 
CHAR(10) + 'Returns the severity level: ' + CONVERT(VARCHAR(2), ERROR_SEVERITY()) +
CHAR(10) + 'Returns the error state: ' + CONVERT(VARCHAR(2), ERROR_STATE()) +
CHAR(10) + 'Returns the line number where the error occurred. ' + CONVERT(VARCHAR(10), ERROR_LINE()) +
CHAR(10) + 'Returns the error state: ' + ISNULL(ERROR_PROCEDURE(), 'NA')

PRINT @message

END CATCH;