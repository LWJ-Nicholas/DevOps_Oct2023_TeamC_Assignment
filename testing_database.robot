*** Settings ***
Library           DatabaseLibrary
Library           OperatingSystem

Suite Setup       Initialize Database Connection
Suite Teardown    Disconnect From Database

*** Variables ***
${DBName}    database.db
${DBUser}    null
${DBPass}    null
${DBHost}    localhost
${DBPort}    3306

*** Keywords ***
Initialize Database Connection
    Connect To Database    pymysql    ${DBName}    ${DBUser}    ${DBPass}    ${DBHost}    ${DBPort}

*** Test Cases ***
Example Flask-SQLAlchemy Test
    Insert Into Table    User    name    testing1
    Insert Into Table    User    password    testing1
    ${result}=    Query    SELECT * FROM User
    Should Contain    ${result}    testing1
