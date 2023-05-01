*** Settings ***
Library            Selenium2Library
Library            BuiltIn
Library            String
Library            ExcelLibrary
Library            Collections
Library            OperatingSystem
Library            DateTime
Library            ${CURDIR}/sortcell.py

*** Keywords ***

Open web set it workflow 
    [Arguments]   ${user}    ${password}
    ${chrome_options}    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${chrome_options}    add_argument    --ignore-certificate-errors       #Run normal
    # Call Method    ${chrome_options}    add_argument    --headless                          #Run headless
    Create Webdriver    Chrome    chrome    chrome_options=${chrome_options}    
    # set env
    Run Keyword If   '${url}' == 'Dev'   Go To    ${urlDev}
    Run Keyword If   '${url}' == 'Uat'   Go To    ${urlUat}
    Maximize Browser Window
    # Click login to set MS Office 365
    # Wait Until Element Is Visible    //input[contains(@type,'email')]
    # Click Element    //button[contains(.,'LOGIN to SET MS Office 365')]
    # input mail and pwd
    Wait Until Element Is Visible    ${EmailLogin}   30s     
    Input text      ${EmailLogin}     ${user}
    Click Element   ${ClickNextLogin}
    Wait Until Element Is Visible    ${__PwdLogin}   30s    
    Input text      ${__PwdLogin}     ${password}
    Click Element   ${ClickSignin}
    # Stay signed in?
    Wait Until Element Is Visible    //input[contains(@value,'Yes')]   30s  
    Run Keywords
    ...   Click Element   //input[contains(@value,'Yes')]
    ...   AND   Wait Loading screen Is Visible
    # ...   AND   Wait Loading screen Not Visible
    Wait Loading screen Not Visible
    # Capture Page Screenshot   ${pathCapture}/screenshot-{index}.png  

Wait Loading screen Not Visible
    Wait Until Element Is Not Visible      //ngx-spinner[contains(@type,'ball-triangle-path')]   45s   #//p[contains(.,'Loading...')]     30s

Wait Loading screen Is Visible
    Wait Until Element Is Visible     //ngx-spinner[contains(@type,'ball-triangle-path')]  #//p[contains(.,'Loading...')]     

Get Data Excel
    [Arguments]    ${sheetExcel}   ${rowStart}   ${colStart}
    ${value}    Read Excel Cell     ${rowStart}     ${colStart}      ${sheetExcel}
    Set Test Variable    ${value}


Get all data excel
    [Arguments]    ${sheetExcel}   ${rowStart}   ${colStart}
    @{list}     Create List
    ${rowStart}      Set Variable    ${rowStart}    
    FOR    ${i}    IN RANGE    999999   
        ${value}    Read Excel Cell     ${rowStart}     ${colStart}      ${sheetExcel}    
        ${isNone}   Check None Value     ${value}    
        Exit For Loop If    ${isNone}  
        ${rowStart}  Evaluate      ${rowStart} + 1
        Append To List   ${list}    ${value}
    END
    [Return]        ${list}
    log  ${list}

Gen Current Date
    ${getdate} =  Get Current Date
    ${genDataDate} =  Convert Date	${getdate}	result_format=%d%m%H%M%S      #result_format=%Y%m%d%H%M%S
    ${gen_Date} =  Convert Date	${getdate}	result_format=%d
    ${gen_Month} =  Convert Date	${getdate}	result_format=%b
    ${genDateResult} =  Convert Date	${getdate}	result_format=%Y%m%d
    # Set Test Variable    ${gen_Time}
    Set Test Variable    ${gen_Month}
    Set Test Variable    ${genDataDate}

Click Execute Javascript :
    [Arguments]   ${xPath}
    ${ele}    Get WebElement   ${xPath}
    Execute Javascript    arguments[0].click();     ARGUMENTS    ${ele} 
    # execute javascript  document.getElementById('EXTERNAL').click()

Click Button And Wait Loading screen
    [Arguments]    ${Locator}
    Wait Until Element Is Enabled   ${Locator}
    Run Keywords
    ...   Click Element   ${Locator}
    ...   AND   Wait Loading screen Is Visible
    # ...   AND   Wait Loading screen Not Visible
    Wait Loading screen Not Visible

Click Select From List And Wait Loading screen
    [Arguments]   ${locatorBoxList}   ${localtorList}
    Wait Until Element Is Enabled   ${locatorBoxList}
    Click Element   ${locatorBoxList}
    #select list
    Wait Until Element Is Enabled   ${localtorList}
    Click Button And Wait Loading screen   ${localtorList}

Click Select From List
    [Arguments]   ${locatorBoxList}   ${localtorList}
    Wait Until Page Contains Element   ${locatorBoxList}
    Click Element   ${locatorBoxList}
    #select list
    Wait Until Page Contains Element   ${localtorList}
    Click Element  ${localtorList}

Input Text And Click Select From List
    [Arguments]    ${localtorInputText}   ${inputData}   ${localtorList}
    Wait Until Page Contains Element    ${localtorInputText}
    Input Text   ${localtorInputText}   ${inputData}
    #select list
    Wait Until Page Contains Element   ${localtorList}
    Click Element  ${localtorList}

Input Text And Click Select From List Wait Loading screen
    [Arguments]    ${localtorInputText}   ${inputData}   ${localtorList}
    # Wait Until Page Contains Element    ${localtorInputText}
    Wait Until Element Is Enabled   ${localtorInputText}
    Input Text   ${localtorInputText}   ${inputData}
    #select list
    Wait Until Page Contains Element   ${localtorList}
    Click Button And Wait Loading screen  ${localtorList}

# Get Task ID
#     ${TaskID}   Get Value   (//td[contains(@role,'gridcell')])[1]

Click Execute Javascript
    [Arguments]   ${xPath}
    ${ele}    Get WebElement   ${xPath}
    Execute Javascript    arguments[0].click();     ARGUMENTS    ${ele} 

scrollHeight
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)

Search Filters By Task ID / Task Name
    [Arguments]    ${keyword}
    Wait Until Element Is Visible   ${SearchFilters}
    Click Element   ${SearchFilters}
    # Task ID / Task Name
    Wait Until Element Is Visible   ${Inputkeyword}
    Input Text   ${Inputkeyword}   ${keyword}

Get Location by Next Step
    ${getUrl}   Get Location
    ${splitUrl}   Split String   ${getUrl}    ?isReadonly=true
    Execute Javascript   window.open('${splitUrl[${0}]}');

Check Workflow Status
    [Arguments]   ${WorkflowStatus}
    ${getStatus}  Get Text   //p[contains(@class,'font-weight-bold')]
    Should Be True  '${getStatus}' == '${WorkflowStatus}'


# Select Require Quotation
# [Arguments]   

# //label[@for='inlineRadio2'][contains(.,'No')]
# //label[@for='inlineRadio1'][contains(.,'Yes')]