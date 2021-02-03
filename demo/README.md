

## Create the migration source (MSSQL) database by restoring from  backup file AdventureWorks2017.bak

# Log in to the mssql container:

$ docker-compose exec mssql bash

# Create the migration source database using RESTORE DATABASE:

/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P $SA_PASSWORD -Q 'RESTORE DATABASE AdventureWorks FROM DISK="/var/backups/AdventureWorks2017.bak" WITH MOVE "AdventureWorks2017" TO "/var/opt/mssql/data/AdventureWorks2017", MOVE "AdventureWorks2017_log" TO "/var/opt/mssql/data/AdventureWorks2017_log"'

# Or in SQL Client:
RESTORE DATABASE AdventureWorks 
	FROM DISK='/var/backups/AdventureWorks2017.bak' WITH 
		MOVE 'AdventureWorks2017' TO '/var/opt/mssql/data/AdventureWorks2017', 
		MOVE 'AdventureWorks2017_log' TO '/var/opt/mssql/data/AdventureWorks2017_log';


## Create the migration destination (Postgres) database

# Log in to the postgres container:

$ docker-compose exec postgres bash

# Connect to Postgres with psql:

$ psql -U postgres

# Create a migration target database: 

postgres=# create database adventure_works;



## Create DDL file using Migrate2Postgres:

$ cd Migrate2Postgres-1.0.7b-dist
$ java -cp "lib/*" net.twentyonesolutions.m2pg.PgMigrator ddl examples/conf/MsSqlAWT2Postgres.conf migrate-AdventureWorks-ddl.sql

-- run generated DDL script

## Run DML command to import the data

$ java -cp "lib/*" net.twentyonesolutions.m2pg.PgMigrator dml examples/conf/MsSqlAWT2Postgres.conf migrate-AdventureWorks-dml.sql

## View the log etc.

