
*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${website_url}    http://127.0.0.1:5000
${new_user_username}      Heeello
${new_user_password}      12456977
${create_new_user_link}    xpath=//a[contains(text(),' Create New User ')]
${create_new_user_button}    xpath=//button[contains(text(),' Create New User ')]
${error_message}    css=.alert.alert-danger
${success_message}    css=.alert.alert-success
${cancel}       xpath=//a[contains(text(),' Cancel ')]

*** Test Cases ***
Launching website
    
    # Go to website and check went to correct website (pre-requisite)
    [Setup]    Open Browser    ${website_url}  chrome
    Title Should Be    Home    
    Click Element    id=login   
    Sleep    2s

Creating New Account - Success
    Click Element    {create_new_user_link}  
    Wait Until Page Contains    Create Account
    Input Text    id=username    ${new_user_username}
    Input Text    id=password    ${new_user_password}
    Click Element    ${create_new_user_button}
    Wait Until Element Is Visible    css=.alert.alert-success
    Wait Until Page Contains    ${new_user_username}
    Sleep    3s
    Click Element    id=logout    #xpath=//a[@class="btn btn-default"]    #Logout
    Click Element    id=login
    Sleep    2s

Creating New Account - Failed Existing Account
    Click Element    {create_new_user_link}   
    Wait Until Page Contains    Create Account
    Input Text    id=username    ${new_user_username}
    Input Text    id=password    ${new_user_password}
    Click Element    ${create_new_user_button}
    Sleep    3s
    Wait Until Element Is Visible    css=.alert.alert-danger
    Click Element    
    Sleep    2s

Creating New Account - Failed Username Exists Password New
    Click Element    xpath=//a[contains(@class,'btn-success') and contains(text(),' Create New User ')]   
    Wait Until Page Contains    Create Account
    Input Text    id=username    ${new_user_username}
    Input Text    id=password    123456789
    Click Element    xpath=//button[contains(text(),' Create New User ')]
    Sleep    3s
    Wait Until Element Is Visible    css=.alert.alert-danger
    Click Element    xpath=//a[contains(text(),' Cancel ')]
    Sleep    2s

Creating New Account - Failed Username New Password Exists
    Click Element    xpath=//a[contains(@class,'btn-success') and contains(text(),' Create New User ')]   
    Wait Until Page Contains    Create Account
    Input Text    id=username    Jack
    Input Text    id=password    ${new_user_password}
    Click Element    xpath=//button[contains(text(),' Create New User ')]
    Sleep    3s
    Wait Until Element Is Visible    css=.alert.alert-danger
    Click Element    xpath=//a[contains(text(),' Cancel ')]
    Sleep    2s

Creating New Account - Failed Attempt to create weak username
    # Username needs to be at least 2 characters 
    Click Element    xpath=//a[contains(@class,'btn-success') and contains(text(),' Create New User ')]   
    Wait Until Page Contains    Create Account
    Input Text    id=username    Hi
    Input Text    id=password    123456789
    Click Element    xpath=//button[contains(text(),' Create New User ')]
    Sleep    3s
    Wait Until Element Is Visible    css=.alert.alert-danger
    Click Element    xpath=//a[contains(text(),' Cancel ')]
    Sleep    2s

Creating New Account - Failed Attempt to create weak password
    # Password needs to be at least 7 characters
    Click Element    xpath=//a[contains(@class,'btn-success') and contains(text(),' Create New User ')]   
    Wait Until Page Contains    Create Account
    Input Text    id=username    ${new_user_username}
    Input Text    id=password    123456
    Click Element    xpath=//button[contains(text(),' Create New User ')]
    Sleep    3s
    Wait Until Element Is Visible    css=.alert.alert-danger
    Click Element    xpath=//a[contains(text(),' Cancel ')]
    Sleep    2s

Creating New Account - Failed Blank Inputs
    Click Element    xpath=//a[contains(@class,'btn-success') and contains(text(),' Create New User ')]   
    Wait Until Page Contains    Create Account
    Click Element    xpath=//button[contains(text(),' Create New User ')]
    Sleep    3s
    Wait Until Element Is Visible    css=.alert.alert-danger
    Click Element    xpath=//a[contains(text(),' Cancel ')]
    Sleep    2s

Close Website
    Close Browser
    [Teardown]    Close Browser