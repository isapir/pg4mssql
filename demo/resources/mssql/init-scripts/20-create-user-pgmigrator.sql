
CREATE LOGIN pgmigrator 
    WITH PASSWORD = 'PostgresFTW!';

USE AdventureWorks;
GO

CREATE USER pgmigrator 
    FOR LOGIN pgmigrator;

GRANT VIEW DEFINITION TO pgmigrator;
GRANT SELECT TO pgmigrator;
GRANT EXECUTE TO pgmigrator;

