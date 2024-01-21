
*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${website_url}    http://127.0.0.1:5000
${new_user_username}      Testing
${new_user_password}      testing
${login_btn}    xpath=//button[contains(text(),'Login')]
${login_anchor}    xpath=//a[contains(text(),'Login')]
${logout_btn}    xpath=//a[contains(text(),'Logout')]    
${create_anchor}    xpath=//a[contains(text(),' Create New User ')]
${create_btn}    xpath=//button[contains(text(),' Create New User ')]
${cancel_btn}    xpath=//a[contains(text(),' Cancel ')]
${success_msg}    xpath=//div[contains(@class, 'alert-success') and contains(normalize-space(text()), 'Account created!')]    
${error_msg1}    xpath=//div[contains(@class, 'alert-danger') and contains(normalize-space(text()), 'Email already exists')]
${error_msg2}    xpath=//div[contains(@class, 'alert-danger') and contains(normalize-space(text()), 'Username must be greater than 2 characters.')]

*** Test Cases ***
Launching website
    # Go to website and check went to correct website (pre-requisite)
    [Setup]    Open Browser    ${website_url}  chrome
    Title Should Be    Home    
    Click Element    ${login_anchor}      
    Sleep    2s

Creating New Account - Success
    Click Element    ${create_anchor}       
    Wait Until Page Contains    Create Account
    Input Text    id=username    ${new_user_username}
    Input Text    id=password    ${new_user_password}
    Click Element    ${create_btn}    
    Wait Until Element Is Visible    ${success_msg}    
    Wait Until Page Contains    ${new_user_username}
    Sleep    3s
    Click Element    ${logout_btn}
    Click Element    ${login_anchor}
    Sleep    2s

Creating New Account - Failed Existing Account
    Click Element    ${create_anchor}       
    Wait Until Page Contains    Create Account
    Input Text    id=username    ${new_user_username}
    Input Text    id=password    ${new_user_password}
    Click Element    ${create_btn}    
    Sleep    3s
    Wait Until Element Is Visible    ${error_msg1}
    Click Element    ${cancel_btn}    
    Sleep    2s

Creating New Account - Failed Username Exists Password New
    Click Element    ${create_anchor}       
    Wait Until Page Contains    Create Account
    Input Text    id=username    ${new_user_username}
    Input Text    id=password    123456789
    Click Element    ${create_btn}    
    Sleep    3s
    Wait Until Element Is Visible    ${error_msg1}
    Click Element    ${cancel_btn}    
    Sleep    2s

Creating New Account - Failed Username New Password Exists
    Click Element    ${create_anchor}   
    Wait Until Page Contains    Create Account
    Input Text    id=username    Jack
    Input Text    id=password    ${new_user_password}
    Click Element    ${create_btn}    
    Sleep    3s
    Wait Until Element Is Visible    ${error_msg1}
    Click Element    ${cancel_btn}    
    Sleep    2s

Creating New Account - Failed Attempt to create weak username
    # Username needs to be at least 2 characters 
    Click Element    ${create_anchor}    
    Wait Until Page Contains    Create Account
    Input Text    id=username    Hi
    Input Text    id=password    123456789
    Click Element    ${create_btn}    
    Sleep    3s
    Wait Until Element Is Visible    ${error_msg1}
    Click Element    ${cancel_btn}    
    Sleep    2s

Creating New Account - Failed Attempt to create weak password
    # Password needs to be at least 7 characters
    Click Element    ${create_anchor}      
    Wait Until Page Contains    Create Account
    Input Text    id=username    ${new_user_username}
    Input Text    id=password    123456
    Click Element    ${create_btn}    
    Sleep    3s
    Wait Until Element Is Visible    ${error_msg1}
    Click Element    ${cancel_btn}    
    Sleep    2s

Creating New Account - Failed Blank Inputs
    Click Element    ${create_anchor}       
    Wait Until Page Contains    Create Account
    Click Element    ${create_btn}    
    Sleep    3s
    Wait Until Element Is Visible    ${error_msg2}
    Click Element    ${cancel_btn}    
    Sleep    2s

Close Website
    Close Browser
    [Teardown]    Close Browser