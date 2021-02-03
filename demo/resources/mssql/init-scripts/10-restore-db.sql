
RESTORE DATABASE AdventureWorks 
	FROM DISK='/var/backups/AdventureWorks2017.bak' WITH 
		MOVE 'AdventureWorks2017' TO '/var/opt/mssql/data/AdventureWorks2017', 
		MOVE 'AdventureWorks2017_log' TO '/var/opt/mssql/data/AdventureWorks2017_log';
