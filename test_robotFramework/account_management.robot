*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${website_url}    http://127.0.0.1:5000/login
${login_admin_username}    Admin      
${login_admin_password}    password
${login_btn}    xpath=//button[contains(text(),'Login')]
${modify_accounts_btn}    xpath=//a[contains(text(),' Modify Accounts ')]
${return_btn}    xpath=//a[contains(text(),' Return ')]
${logout_btn}    xpath=//a[contains(text(),'Logout')]   
${success_msg}    css=.alert.alert-success     
${error_msg}    css=.alert.alert-danger

*** Keywords ***
Launch Website
    Open Browser    ${website_url}    headlesschrome
    Title Should Be    Login    
    Sleep    2s   

Close Website
    Close Browser

*** Test Cases ***
# Number of test cases: 1

Checking UI of Account Management
    [Setup]    Launch Website    
    Input Text    id=username    ${login_admin_username}
    Input Text    id=password    ${login_admin_password}
    Click Element    ${login_btn}    
    Sleep     3s
    Wait Until Element Is Visible    ${success_msg}        
    Wait Until Page Contains    Administrator
    Click Element    ${modify_accounts_btn}
    Wait Until Page Contains    Account Management
    Click Element    ${return_btn}
    Wait Until Page Contains    Welcome to the TSAO Capstone Records System
    Click Element    ${logout_btn}    
    [Teardown]    Close Website

    