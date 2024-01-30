
*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${website_url}    http://127.0.0.1:5000
${login_admin_username}    Admin      
${login_admin_password}    password
${login_user_username}    Testing
${login_user_password}    Testing
${login_btn}    xpath=//button[contains(text(),'Login')]
${login_anchor}    xpath=//a[contains(text(),'Login')]
${logout_btn}    xpath=//a[contains(text(),'Logout')]   
${success_msg}    xpath=//div[contains(@class, 'alert-success') and contains(normalize-space(text()), 'Logged in successfully!')]    
${error_msg1}    xpath=//div[contains(@class, 'alert-danger') and contains(normalize-space(text()), 'Username does not exist.')]
${error_msg2}    xpath=//div[contains(@class, 'alert-danger') and contains(normalize-space(text()), 'Incorrect password, try again.')]


*** Test Cases ***
Launching website
    # Go to website and check went to correct website (pre-requisite)
    [Setup]    Open Browser    ${website_url}    headlesschrome
    Title Should Be    Home    
    Click Element    ${login_anchor}    
    Sleep    2s

Entering Login Details User - Success  
    Input Text    id=username    ${login_user_username}
    Input Text    id=password    ${login_user_password}
    Click Element    ${login_btn}    
    Sleep     3s
    Wait Until Element Is Visible    ${success_msg}        
    Wait Until Page Contains    ${login_user_username}
    Click Element    ${logout_btn}    
    Click Element    ${login_anchor}

Entering Login Details Administrator - Success    
    Input Text    id=username    ${login_admin_username}
    Input Text    id=password    ${login_admin_password}
    Click Element    ${login_btn}    
    Sleep     3s
    Wait Until Element Is Visible    ${success_msg}        
    Wait Until Page Contains    Administrator
    Click Element    ${logout_btn}    
    Click Element    ${login_anchor}   

Entering Login Details - Fail Wrong Username
    Input Text    id=username    adm
    Input Text    id=password   ${login_user_password}
    Click Element    ${login_btn}    
    Wait Until Element Is Visible    ${error_msg1}        
    Sleep     3s

Entering Login Details - Fail Wrong Password
    Input Text    id=username    ${login_user_username}    
    Input Text    id=password   123456789
    Click Element     ${login_btn}    
    Wait Until Element Is Visible    ${error_msg2}        
    Sleep     3s

Entering Login Details - Fail Blank for both input fields  
    Click Element    ${login_btn}    
    Wait Until Element Is Visible    ${error_msg1}       
    Sleep     3s 

Entering Login Details - Fail Diff Username and password
    Input Text    id=username    ${login_admin_username}    
    Input Text    id=password    ${login_user_password}   
    Click Element    ${login_btn}    
    Wait Until Element Is Visible    ${error_msg2}    
    Sleep     3s    

Close Website
    Close Browser
    [Teardown]    Close Browser

# Relaunch Website
#     [Teardown]    Close Browser
#     [Setup]    Open Browser    ${website_url}  chrome
#     Title Should Be    Home
   