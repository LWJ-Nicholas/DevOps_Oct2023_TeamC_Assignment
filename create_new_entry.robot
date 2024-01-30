*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${website_url}    http://127.0.0.1:5000/form
${login_user_username}      Hello
${login_user_password}      1234567
# ${login_btn}    xpath=//button[contains(text(),'Login')]
# ${login_anchor}    xpath=//a[contains(text(),'Login')]
${save_btn}    xpath=//a[contains(text(),'Save')]
${cancel_btn}    xpath=//a[contains(text(),'Cancel')]
${success_msg}    css=.alert.alert-success    #xpath=//div[contains(@class, 'alert-success') and contains(normalize-space(text()), 'Account created!')] 
${error_msg}    css=.alert.alert-danger

*** Test Cases ***
Launching website
    
    # Go to website and check went to correct website (pre-requisite)
    [Setup]    Open Browser    ${website_url}  chrome  options=--headless;--no-sandbox;--disable-dev-shm-usage
    Title Should Be    Query    
    #Click Element    id=login   
    Sleep    2s

Create New Capstone Entry - Success 
    #Click Element    xpath=//a[contains(text(),' Create ')]
    Input Text    id=name    Devops
    Input Text    id=title    Final Assignment
    Click Element    id=student
    Input Text    id=student    Four
    Input Text    id=company    Ngee Ann Poly 
    Input Text    id=year    2023-01-14
    Input Text    id=companycontact    Mr Low
    Input Text    id=description    Final Assigmnet. #Lastsembestsem    
    #Click Element    ${success_msg}
    Wait Until Element Is Visible    ${success_msg}
    Sleep    5s
    Click Element    ${cancel_btn}

Close Website
    Close Browser
    [Teardown]    Close Browser