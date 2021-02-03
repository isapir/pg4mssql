<cfinclude template="header.cfml">

<a href="/slides" target="_blank"><h3>Open Slides</h3></a>
<a href="/runtests.cfm" target="_blank"><h3>Run Test Cases</h3></a>

<cfscript>

    options = {
        convertColumnsCamelToSnakeCase: true
    };

    tester = new net.twentyonesolutions.dbmigration.MigrationTester(options);

    msSqlStmt = "SELECT current_timestamp AS db_time, @@version as version;";
    pgSqlStmt = "SELECT current_timestamp AS db_time, version();";

    timer type="outline" {
        result = tester.executeQuery("ms", msSqlStmt);
        dump(result.result ?: result.error.message);
    }
    
    timer type="outline" {
        result = tester.executeQuery("pg", pgSqlStmt);
        dump(result.result ?: result.error.message);
    }

</cfscript>

<cfinclude template="footer.cfml">
