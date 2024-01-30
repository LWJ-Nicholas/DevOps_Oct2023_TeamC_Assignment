# *** Settings ***
# Library           DatabaseLibrary
# Library           OperatingSystem

# Suite Setup       Initialize Database Connection
# Suite Teardown    Disconnect From Database

# *** Variables ***
# ${DBName}    database.db
# ${DBUser}    null
# ${DBPass}    null
# ${DBHost}    localhost
# ${DBPort}    3306

# *** Keywords ***
# Initialize Database Connection
#     Connect To Database    sqlite:///database.db    ${DBUser}    ${DBPass}    ${DBHost}    ${DBPort}    SQLAlchemy

# *** Test Cases ***
# Example Flask-SQLAlchemy Test
#     ${user}    Insert Into Table    User    name=testing1    password=testing1
#     ${result}    Query    SELECT * FROM user
#     Should Contain    ${result}    testing1    testing1

