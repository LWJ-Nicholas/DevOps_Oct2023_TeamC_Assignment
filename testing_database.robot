
*** Variables ***
${DB_NAME}        database.db

*** Settings ***
Library           DatabaseLibrary

Test Setup        Connect To Database Using Custom Params    sqlite3    database='${DB_NAME}'
Test Teardown     Disconnect From Database

*** Test Cases ***
Example SQLite Test
    ${result}=    Query    SELECT * FROM user
    Log    ${result}
