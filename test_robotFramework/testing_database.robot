### Unable to connect to establish database connection

# *** Settings ***
# Library           DatabaseLibrary
# Library           OperatingSystem

# *** Variables ***
# ${DB_NAME}    database.db
# ${expected_username}    Testing
# ${expected_password}    Testing
# ${new_user}    Testing3
# ${new_password}    Testing3


# *** Test Cases ***
# Check User and Password Columns   
#     [Documentation]    Verify the existence of "user" and "password" columns in the database
#     [Setup]    Connect To Database    sqlite:///database.db
#     ${columns}=    Query    PRAGMA table_info(user)
#     ${user_column}=    Get From List    ${columns}    1    # Assuming "user" is the second column
#     ${password_column}=    Get From List    ${columns}    2    # Assuming "password" is the third column
#     Should Be Equal As Strings    ${user_column[1]}    user
#     Should Be Equal As Strings    ${password_column[1]}    password
#     [Teardown]    Disconnect From Database

# Insert Statement Test
#     [Documentation]    Insert a new user into the database
#     [Setup]    Connect To Database    sqlite:///database.db
#     ${insert_result}=    Execute Sql String    INSERT INTO user (user, password) VALUES ('${new_user}', '${new_password}')
#     Should Be Equal As Strings    ${insert_result}    1    # Assuming 1 row is affected
#     [Teardown]    Disconnect From Database

# Attempt to insert a duplicate user
#     [Documentation]    Inserting same user into the database
#     [Setup]    Connect To Database    sqlite:///database.db
#     ${duplicate_result}=    Execute Sql String    INSERT INTO user (user, password) VALUES ('${new_user}', '${new_password}')
#     Should Be Equal As Numbers    ${duplicate_result}    0    # Expecting 0 rows affected for a duplicate insert
#     [Teardown]    Disconnect From Database

# Retrieve Password by Username
#     [Documentation]    Retrieve the password for a specific username
#     [Setup]    Connect To Database    sqlite:///database.db
#     ${password_result}=    Query    SELECT password FROM user WHERE user = '${expected_username}'
#     Should Be Equal As Strings    ${password_result[0][0]}    expected_password
#     [Teardown]    Disconnect From Database

# Retrieve Username by Password
#     [Documentation]    Retrieve the username for a specific password
#     [Setup]    Connect To Database    sqlite:///database.db
#     ${username_result}=    Query    SELECT user FROM user WHERE password = '${expected_password}'
#     Should Be Equal As Strings    ${username_result[0][0]}    existing_user
#     [Teardown]    Disconnect From Database
