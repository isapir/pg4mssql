component {

    this.name = "Postgres4MSSQL";

    this.localMode = true;
    this.regex.type = "Java";

    this.datasources = {
        /** connection settings for SQL Server */
        ms: {
            class: "com.microsoft.sqlserver.jdbc.SQLServerDriver",
            bundleName: "mssqljdbc4",
            connectionString: "jdbc:sqlserver://mssql:1433;DatabaseName=AdventureWorks;sendStringParametersAsUnicode=true;SelectMethod=direct;loginTimeout=2",
            username: "pgmigrator",
            password: "PostgresFTW!"
        },
        /** connection settings for Postgres */
        pg: {
            class: "org.postgresql.Driver",
            bundleName: "org.postgresql.jdbc",
            connectionString: "jdbc:postgresql://postgres:5432/adventure_works?loginTimeout=2",
            username: "postgres",
            password: "PostgresFTW!"
        }
    };

}