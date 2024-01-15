*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${website_url}    http://127.0.0.1:5000/form
${login_user_username}      Hello
${login_user_password}      1234567

*** Test Cases ***
Launching website
    
    # Go to website and check went to correct website (pre-requisite)
    [Setup]    Open Browser    ${website_url}  chrome
    Title Should Be    Query    
    #Click Element    id=login   
    Sleep    2s

Create New Entry - Success 
    #Click Element    xpath=//a[contains(text(),' Create ')]
    Input Text    id=name    Devops
    Input Text    id=title    Final Assignment
    Click Element    id=student
    Input Text    id=student    Four
    Input Text    id=company    Ngee Ann Poly 
    Input Text    id=year    2023-01-14
    Input Text    id=companycontact    Mr Low
    Input Text    id=description    Final Assigmnet. #Lastsembestsem    
    #Click Element    xpath=//a[contains(text(),'Save')]
    Sleep    5s
    Click Element    xpath=//a[contains(text(),'Cancel')]

Close Website
    Close Browser
    [Teardown]    Close Browser