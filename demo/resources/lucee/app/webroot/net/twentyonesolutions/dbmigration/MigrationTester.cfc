component {

    this.options = {
        convertColumnsCamelToSnakeCase: false
    };

    /**
     * constructor
     *
     * @options 
     */
    public function init(struct options={}) {
        this.options.append(arguments.options);
    }

    /**
     * Executes a query against datasource and returns a struct with the keys
     * ok:boolean, datasource:string, metadata:struct, result:query, error:exception
     *
     * @datasource 
     * @sqlStmt 
     * @params 
     */
    public function executeQuery(string datasource, string sqlStmt, struct params={}) {

        try {
            
            sqlStmt = replace(arguments.sqlStmt, "::", "::::", "all");

            query   name="q" 
                    result="metadata" 
                    sql=sqlStmt 
                    params=arguments.params 
                    datasource=datasource;

            return {
                ok: true,
                datasource: arguments.datasource,
                result: q,
                metadata: metadata,
                error: null
            };
        }
        catch (ex) {

            return {
                ok: false,
                datasource: arguments.datasource,
                result: nullValue(),
                error: ex
            };
        }
    }


    /**
     * Compares two results from executeQuery()
     *
     * @expected a struct as returned from executeQuery() against source db
     * @received a struct as returned from executeQuery() against target db
     */
    public function compareResults(required struct expected, required struct received) {

        messages = [];

        /**
         * check no errors in execution
         */
        if (!expected.ok)
            messages.append("Source: #expected.error.message#");
        
        if (!received.ok)
            messages.append("Target: #received.error.message#");
        
        if (isEmpty(messages)) {
            
            /**
             * check same column names
             */
            expectedColumnList = expected.metadata.columnList;
            if (this.options.convertColumnsCamelToSnakeCase) {
                expectedColumnList = this.convertCamelToSnakeCase(expectedColumnList);
            }

            if (expectedColumnList != received.metadata.columnList)
                messages.append("expected columns [#expectedColumnList#] but received [#received.metadata.columnList#]");

            /**
             * check same record count
             */
            if (expected.metadata.recordCount != received.metadata.recordCount)
                messages.append("expected #expected.metadata.recordCount# rows but received #received.metadata.recordCount#");

            if (isEmpty(messages)) {

                expectedColumns = expected.metadata.columnList.listToArray(",");
                receivedColumns = received.metadata.columnList.listToArray(",");

                /**
                 * iterate over result set and check cells for equality
                 */
                for (row=1; row <= expected.metadata.recordCount; row++) {

                    for (col=1; col <= expectedColumns.len(); col++) {

                        expectedValue = expected.result[ expectedColumns[col] ][row];
                        receivedValue = received.result[ receivedColumns[col] ][row];
                        
                        if (expectedValue != receivedValue) {
                            messages.append(
                                "#receivedColumns[col]#[#row#] expected {#expectedValue#} but received {#receivedValue#}"
                            );
                        }
                    }
                }
            }
        }

        return {
            ok: isEmpty(messages),
            messages: messages,
            queries: {
                expected: arguments.expected,
                received: arguments.received
            }
        };
    }


    /**
     * runs a single test case given the file path
     *
     * @path 
     */
    public struct function runTestcase(required string path) {

        testcase = this.readTestcase(arguments.path);
        msResult = this.executeQuery("ms", testcase.ms);
        pgResult = this.executeQuery("pg", testcase.pg);

        result = this.compareResults(msResult, pgResult);
        result.testcase = testcase;

        return result;
    }


    /**
     * reads the testcase file from path and returns a struct with 
     * description, ms (query for SQL Server), and pg (query for Postgres)
     *
     * @path 
     */
    public struct function readTestcase(required string path) {

        testcase = trim(fileRead(arguments.path));

        description = listLast(arguments.path, "/");
        if (testcase.hasPrefix("/**")) {
            description = trim(mid(testcase, 4, find("*/", testcase) - 4));
        }

        separator = find(chr(10) & "---", testcase);

        ms = trim(left(testcase, separator));
        pg = trim(mid(testcase, separator + 4));

        return {
            id: arguments.path,
            description: description,
            ms: ms,
            pg: pg
        };
    }


    public function convertCamelToSnakeCase(required string camelCaseString){

        oldColumns = listToArray(arguments.camelCaseString);
        newColumns = [];

        for (oldCol in oldColumns) {
            newCol = replace(oldCol, " ", "_", "all");
            newCol = reReplace(newCol, "([^_A-Z0-9])([A-Z0-9])", "$1_$2", "all");
            newCol = lcase(newCol);

            newColumns.append(newCol);
        }

        return newColumns.toList(",");
    }

}