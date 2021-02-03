<cfinclude template="header.cfml">

<cfscript>

    options = {
        convertColumnsCamelToSnakeCase: true
    };

    tester = new net.twentyonesolutions.dbmigration.MigrationTester(options);

    testcases = directoryList(path="testcases", filter="*.sql", sort="name");

    numTests = len(testcases);
    passed = 0;
    failed = 0;
</cfscript>

<cfoutput>

    <h3>Running #numTests# Testcases</h3>

    <cfloop array="#testcases#" item="path">
        <cfset result = tester.runTestcase(path)>
        <div style="margin-top: 1rem; padding: 0.5rem; border: solid 1px gray; border-radius: 0.5rem;">
            <div>
                <cfif (result.ok)>
                    <cfset passed++>
                    <i class="fas fa-check-square fa-2x green"></i>
                <cfelse>
                    <cfset failed++>
                    <i class="fas fa-exclamation-triangle fa-2x red"></i>
                </cfif>
                <span class="bold">#result.testcase.description#</span>
            </div>
            <div>
                <cfif (!result.ok)>
                    #result.testcase.id#<br>
                </cfif>
                #result.messages.toList("<br>")#
            </div>
        </div>
    </cfloop>

    <h3 class="mt-2">
        Failed: #failed#
        Passed: #passed#
        <cfif (failed == 0)>
            <div class="bg-green">All test cases passed!</div>
        </cfif>
    </h3>
</cfoutput>

<cfinclude template="footer.cfml">
