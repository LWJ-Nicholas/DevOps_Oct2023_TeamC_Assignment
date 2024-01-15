
*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${website_url}    http://127.0.0.1:5000
${login_admin_username}    Admin      
${login_admin_password}    password
${login_user_username}    Hello
${login_user_password}    1234567

*** Test Cases ***
Launching website
    
    # Go to website and check went to correct website (pre-requisite)
    [Setup]    Open Browser    ${website_url}  chrome
    Title Should Be    Home    
    ${login_button}=    Get WebElement    id=login
    Click Element    ${login_button}
    Sleep    5s

Entering Login Details User - Success  
    Input Text    id=username    ${login_user_username}
    Input Text    id=password    ${login_user_password}
    Click Element    xpath=//button[contains(text(),'Login')]
    Sleep     3s
    Wait Until Element Is Visible    css=.alert.alert-success    
    Wait Until Page Contains    ${login_user_username}
    Click Element    id=logout    #xpath=//a[@class="btn btn-default"]    #Logout
    Click Element    id=login    

Entering Login Details Administrator - Success    
    Input Text    id=username    ${login_admin_username}
    Input Text    id=password    ${login_admin_password}
    Click Element    xpath=//button[contains(text(),'Login')]
    Sleep     3s
    Wait Until Element Is Visible    css=.alert.alert-success    
    Wait Until Page Contains    Administrator
    Click Element    id=logout    #xpath=//a[@class="btn btn-default"]    #Logout
    Click Element    id=login   

Entering Login Details - Fail Wrong Username
    Input Text    id=username    adm
    Input Text    id=password   ${login_user_password}
    Click Element    xpath=//button[contains(text(),'Login')]
    Wait Until Element Is Visible    css=.alert.alert-danger    
    Sleep     3s

Entering Login Details - Fail Wrong Password
    Input Text    id=username    ${login_user_username}    
    Input Text    id=password   123456789
    Click Element     xpath=//button[contains(text(),'Login')]
    Wait Until Element Is Visible    css=.alert.alert-danger    
    Sleep     3s

Entering Login Details - Fail Blank for both input fields
    # Input Text    id=username    
    # Input Text    id=password   
    Click Element    xpath=//button[contains(text(),'Login')]
    Wait Until Element Is Visible    css=.alert.alert-danger   
    Sleep     3s 

Entering Login Details - Fail Diff Username and password
    Input Text    id=username    ${login_admin_username}    
    Input Text    id=password    ${login_user_password}   
    Click Element    xpath=//button[contains(text(),'Login')]
    Wait Until Element Is Visible    css=.alert.alert-danger
    Sleep     3s    

Close Website
    Close Browser
    [Teardown]    Close Browser

   