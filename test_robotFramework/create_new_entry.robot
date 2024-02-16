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
${success_msg}    css=.alert.alert-success     
${error_msg}    css=.alert.alert-danger

*** Keywords ***
Launch Website
    Open Browser    ${website_url}    headlesschrome
<<<<<<< HEAD
    Title Should Be    Create 
=======
    Title Should Be    Query    
>>>>>>> e06d70d456188c80f4d0966c13d9df966e027158
    #Click Element    ${login_anchor}
    Sleep    2s   

Close Website
    Close Browser

*** Test Cases ***
# Number of test cases: 1

Create New Capstone Entry (Checking if can input values into fields)
    [Setup]    Launch Website
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
    #Wait Until Element Is Visible    ${success_msg}
    Sleep    5s
    Click Element    ${cancel_btn}
    [Teardown]    Close Website

    