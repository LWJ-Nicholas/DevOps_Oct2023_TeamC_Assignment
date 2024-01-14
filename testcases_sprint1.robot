
*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${website_url}    http://127.0.0.1:5000
#${title}    Lazada.sg: Online Shopping Singapore - Electronics, Home Appliances, Mobiles, Tablets & more            
${login_username}    Admin      
${login_password}    password
${new_username}      
${new_password}

*** Test Cases ***
Launching website
    
    # Go to website and check went to correct website (pre-requisite)
    [Setup]    Open Browser    ${website_url}  chrome
    Title Should Be    Home
    #Click Element    

Entering Login Details
    Input Text    #css:input.search-box__input--O34g    ${login_username}
    Input Text    #css:input.search-box__input--O34g    ${login_password}
    Click Element    #css:button.search-box__button--1oH7
    #Add Keyword If    "${TEST_STATUS}" == "PASS"
    Element Should Be Visible  #css:h1.JrAyI
    Sleep    2s

Creating New Account
    Click Element    #css:button.search-box__button--1oH7
    Wait Until Page Contains    
    Input Text    #css:input.search-box__input--O34g    ${new_username}
    Input Text    #css:input.search-box__input--O34g    ${new_password}
    Click Element    #css:button.search-box__button--1oH7
    Element Should Be Visible  #Element from next page

User View - Create Entry
    Click Element    #Create Button
    Input Text    #name    ${}
    Input Text    #capstonetitle ${}
    Click Element    #Radio Button Role of Contact
    Input Text    #No of students    ${}
    Input Text    #Name if company    ${}
    Input Text    #Academic Year    ${}
    Input Text    #Company point of contact    ${}
    Input Text    #Breif Description    ${}
    Click Element    #Save Button

Admin View - Create Entry
    Click Element    #Create Button
    
# Close Browser
    [Teardown]    Close Browser

   