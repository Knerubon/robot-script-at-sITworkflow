*** Settings ***
Library            Selenium2Library
Library            BuiltIn
Library            String
Library            ExcelLibrary
Library            Collections
Library            OperatingSystem
Library            DateTime
Library            ${CURDIR}/sortcell.py
Resource           Keywords.robot

*** Keywords ***

Create Tasks
    ${list}   Get all data excel  QR  8  6
    Keywords.Wait Loading screen Not Visible
    # Wait Until Element Is Enabled   (//tr[contains(@class,'cdk-header-row table-header ng-star-inserted')])[2]
    Keywords.Click Button And Wait Loading screen   ${CreateTask}
    Keywords.Click Select From List And Wait Loading screen  ${SelectTaskCategory}  ${TaskCategoryQR}
    Gen Current Date
    ## Input Request Detail
    Keywords.Click Select From List And Wait Loading screen  ${SelectdepartmentSelector}  ${EnterpriseSystemsDepartment}
    Keywords.Click Select From List  ${selectserviceSelector}  ${Chatbot}
    Input Text   ${inputTaskName}   ${list[${2}]}${genDataDate}
    Keywords.Click Select From List  ${objectTypeSelector}  ${Management Report}
    Click Element  //label[@for='inlineRadio1'][contains(.,'Yes')]
    Input Text   ${inputScopeOfWork}   ${list[${6}]}
    Input Text   ${inputBenefitDescription}   ${list[${7}]}
    Input Text   ${inputBusinessValue}   ${list[${9}]}
    Keywords.Input Text And Click Select From List Wait Loading screen  ${BusinessUnitHead}  ${list[${12}]}  ${SelectInput}
    Keywords.Input Text And Click Select From List Wait Loading screen  ${BusinessDepHead}  ${list[${13}]}  ${SelectInput}
    Input Text   ${comment}    ${list[${15}]}
    Keywords.Click Button And Wait Loading screen   ${btnSubmit}
    Wait Until Page Contains Element   //h5[contains(.,'My Tasks')]
    ## TabInvolvedTasks
    Keywords.Click Button And Wait Loading screen   ${TabInvolvedTasks}
    # Sleep  2s
    Wait Until Element Is Visible   (//td[@role='gridcell'][contains(.,'Waiting for CS Review')])[1]
    ${getTaskID}   Get Text   (//td[contains(@role,'gridcell')])[1]
    ${TaskName}   Get Text   (//td[contains(@role,'gridcell')])[3]
    # ${TaskID}     Get Substring  ${getTaskID}    4
    ${TaskID}   Convert To Integer  ${getTaskID}
    Set Test Variable   ${TaskID}
    Set Test Variable   ${TaskName}

CSReview Add To My Tasks
    Keywords.Click Button And Wait Loading screen  ${CSTasks}
    Click Element   //input[contains(@id,'${TaskID}-checkbox')]
    Click Element   //button[@class='btn btn-sm btn-primary mx-2'][contains(.,'Add Task')]
    Keywords.Click Button And Wait Loading screen   //button[@type='button'][contains(.,'CONFIRM')]
    Keywords.Click Button And Wait Loading screen   //button[@type='button'][contains(.,'OK')]
    Keywords.Click Button And Wait Loading screen   ${MyTasks}

Raise to IT Head
    [Arguments]     ${TaskName}
    Reload Page
    Keywords.Wait Loading screen Not Visible
    # Keywords.Click Button And Wait Loading screen   ${MyTasks}
    # Keywords.Click Button And Wait Loading screen   ${TabInvolvedTasks}
    Keywords.Search Filters By Task ID / Task Name  ${TaskName}
    Keywords.Click Button And Wait Loading screen  //a[contains(.,'${TaskName}')]
    # Get Location by Next Step
    # ${handle} =	Select Window	NEW
    Keywords.Wait Loading screen Not Visible
    # Check Workflow Status  CS Task
    Wait Until Page Contains Element   //input[contains(@formcontrolname,'csEffort')]
    Input Text   //input[contains(@formcontrolname,'csEffort')]   100
    scrollHeight
    Wait Until Element Is Enabled   (//div[@class='ng-value-container'][contains(.,'×Nerubon Kuerkid')])[1]
    Keywords.Input Text And Click Select From List Wait Loading screen  (//input[contains(@aria-autocomplete,'list')])[8]  Nerubon Kuerkid  ${SelectInput}
    Wait Until Element Is Visible   ${comment}
    Input Text   ${comment}    Raise to IT Head
    Keywords.Input Text And Click Select From List  (//input[contains(@aria-autocomplete,'list')])[9]  Raise to IT Head  ${selectAction}
    Keywords.Click Button And Wait Loading screen   ${btnSubmit}
    
Raise to SOLA Review
    [Arguments]    ${TaskName}
    Reload Page
    Keywords.Wait Loading screen Not Visible
    # Wait Until Element Is Enabled   (//tr[contains(@class,'cdk-header-row table-header ng-star-inserted')])[2]
    Keywords.Search Filters By Task ID / Task Name  ${TaskName}
    Keywords.Click Button And Wait Loading screen  //a[contains(.,'${TaskName}')]
    Keywords.Wait Loading screen Not Visible
    # Input SOLA
    Keywords.scrollHeight
    Keywords.Input Text And Click Select From List  (//input[contains(@aria-autocomplete,'list')])[9]  Nerubon Kuerkid  ${SelectInput}
    Input Text   ${comment}    Raise to SOLA Review
    Keywords.Input Text And Click Select From List  (//input[contains(@aria-autocomplete,'list')])[10]  Raise to SOLA  ${selectAction}
    Keywords.Click Button And Wait Loading screen   ${btnSubmit}

SOLA Assigned to IT Security
    [Arguments]   ${TaskName}
    Keywords.Wait Loading screen Not Visible
    # Wait Until Element Is Enabled   (//tr[contains(@class,'cdk-header-row table-header ng-star-inserted')])[2]
    Keywords.Search Filters By Task ID / Task Name  ${TaskName}
    Keywords.Click Button And Wait Loading screen  //a[contains(.,'${TaskName}')]
    # Input Impact Analysis
    Keywords.Input Text And Click Select From List  (//input[contains(@aria-autocomplete,'list')])[4]   Medium   
    ...  //span[contains(@class,'ng-option-label ng-star-inserted')]
    Input Text   //textarea[contains(@name,'changeImpactAnalysis')]   xxx
    Click Element   //label[@class='form-check-label'][contains(.,'New Application')]
    Click Element   //label[@class='form-check-label'][contains(.,'Change Platform')]
    Click Element   //label[@class='form-check-label'][contains(.,'No Impact')]
    Click Element   //label[@for='securityConcern1'][contains(.,'Require')]
    Click Element   //label[@for='impactToCapacity1'][contains(.,'Yes')]
    # Input Man-Day Estimation
    Input Text   //input[contains(@formcontrolname,'solaEffort')]   14
    Input Text   //input[contains(@formcontrolname,'developerEstimation')]   7
    Input Text   //input[contains(@formcontrolname,'qcEstimation')]   7
    Input Text   //input[contains(@formcontrolname,'itOperationEstimation')]   7
    Input Text   //input[contains(@formcontrolname,'uatMandays')]   7
    Keywords.Input Text And Click Select From List  (//input[contains(@aria-autocomplete,'list')])[10]  Assigned to IT Security  ${selectAction}
    Keywords.Click Button And Wait Loading screen   ${btnSubmit}

Security Inform to SOLA
    [Arguments]   ${TaskName}
    Keywords.Wait Loading screen Not Visible
    Wait Until Element Is Enabled   (//tr[contains(@class,'cdk-header-row table-header ng-star-inserted')])[2]
    Keywords.Search Filters By Task ID / Task Name  ${TaskName}
    Keywords.Click Button And Wait Loading screen  //a[contains(.,'${TaskName}')]
    Input Text   //textarea[contains(@name,'changeImpactAnalysis')]   xxx
    Keywords.Input Text And Click Select From List  (//input[contains(@aria-autocomplete,'list')])[10]  Inform to SOLA  ${selectAction}
    Keywords.Click Button And Wait Loading screen   ${btnSubmit}

SOLA Assigned to Assign to Developer
    [Arguments]   ${TaskName}
    Keywords.Wait Loading screen Not Visible
    # Wait Until Element Is Enabled   (//tr[contains(@class,'cdk-header-row table-header ng-star-inserted')])[2]
    Keywords.Search Filters By Task ID / Task Name  ${TaskName}
    Keywords.Click Button And Wait Loading screen  //a[contains(.,'${TaskName}')]
    # Input Impact Analysis
    Keywords.Input Text And Click Select From List  (//input[contains(@aria-autocomplete,'list')])[4]   Medium   
    ...  //span[contains(@class,'ng-option-label ng-star-inserted')]
    Input Text   //textarea[contains(@name,'changeImpactAnalysis')]   xxx
    Click Element   //label[@class='form-check-label'][contains(.,'New Application')]
    Click Element   //label[@class='form-check-label'][contains(.,'Change Platform')]
    Click Element   //label[@class='form-check-label'][contains(.,'No Impact')]
    Click Element   //label[@for='securityConcern2'][contains(.,'Not Require')]
    Click Element   //label[@for='impactToCapacity1'][contains(.,'Yes')]
    # Input Man-Day Estimation
    Input Text   //input[contains(@formcontrolname,'solaEffort')]   14
    Input Text   //input[contains(@formcontrolname,'developerEstimation')]   7
    Input Text   //input[contains(@formcontrolname,'qcEstimation')]   7
    Input Text   //input[contains(@formcontrolname,'itOperationEstimation')]   7
    Input Text   //textarea[contains(@name,'mandayDescription')]    Test Manday Description 
    # scrollHeight
    # Next Step
    Keywords.Input Text And Click Select From List  (//input[contains(@aria-autocomplete,'list')])[10]   Assign to Developer   ${selectAction}
    
    # Test Search
    # Keywords.Search Filters By Task ID / Task Name  ${TaskNameDev}
    # Assign Developers
    Wait Until Element Is Visible   //button[@type='button'][contains(.,'Add Developer')]
    Click Element   //button[@type='button'][contains(.,'Add Developer')]
    Wait Until Element Is Visible   (//input[contains(@aria-autocomplete,'list')])[11]
    Keywords.Input Text And Click Select From List  (//input[contains(@aria-autocomplete,'list')])[11]  Nerubon Kuerkid  ${SelectInput}
    ${TaskNameDev}   Set Variable  ${TaskName}-Dev1
    Set Test Variable   ${TaskNameDev}
    Input Text   //textarea[contains(@name,'taskName')]   ${TaskNameDev}
    # Submit
    Keywords.Click Button And Wait Loading screen   ${btnSubmit}

Developer Estimate Manday
    [Arguments]   ${TaskNameDev}
    Keywords.Wait Loading screen Not Visible
    # Wait Until Element Is Enabled   (//tr[contains(@class,'cdk-header-row table-header ng-star-inserted')])[2]
    Keywords.Search Filters By Task ID / Task Name  ${TaskNameDev}
    Keywords.Click Button And Wait Loading screen  //a[contains(.,'${TaskNameDev}')]
    # Developer Estimation
    Input Text   //input[contains(@formcontrolname,'developerEstimation')]   7
    Input Text   //textarea[contains(@name,'mandayDescription')]    Test Manday Description 
    # Next Step : Inform m/d to SOLA
    Keywords.Input Text And Click Select From List  (//input[contains(@aria-autocomplete,'list')])[10]   Inform man-day to SOLA   ${selectAction}
    Keywords.Click Button And Wait Loading screen   ${btnSubmit}

Return : Inform m/d to IT Head
    [Arguments]   ${TaskName}
    Keywords.Wait Loading screen Not Visible
    # Wait Until Element Is Enabled   (//tr[contains(@class,'cdk-header-row table-header ng-star-inserted')])[2]
    Keywords.Search Filters By Task ID / Task Name  ${TaskName}
    Keywords.Click Button And Wait Loading screen  //a[contains(.,'${TaskName}')]
    # Next Step : Inform m/d to SOLA
    Keywords.Input Text And Click Select From List  (//input[contains(@aria-autocomplete,'list')])[10]   Inform man-day to IT Head   ${selectAction}
    Keywords.Click Button And Wait Loading screen   ${btnSubmit}

Return : Inform m/d to CS Tasks
    [Arguments]   ${TaskName}
    Keywords.Wait Loading screen Not Visible
    # Wait Until Element Is Enabled   (//tr[contains(@class,'cdk-header-row table-header ng-star-inserted')])[2]
    Keywords.Search Filters By Task ID / Task Name  ${TaskName}
    Keywords.Click Button And Wait Loading screen  //a[contains(.,'${TaskName}')]
    # Next Step : Inform m/d to CS Tasks
    Keywords.Input Text And Click Select From List  (//input[contains(@aria-autocomplete,'list')])[10]   Inform man-day   ${selectAction}
    Keywords.Click Button And Wait Loading screen   ${btnSubmit}

CS Tasks Inform m/d to Acknowledged
    [Arguments]   ${TaskName}
    Keywords.Wait Loading screen Not Visible
    # Wait Until Element Is Enabled   (//tr[contains(@class,'cdk-header-row table-header ng-star-inserted')])[2]
    Keywords.Search Filters By Task ID / Task Name  ${TaskName}
    Keywords.Click Button And Wait Loading screen  //a[contains(.,'${TaskName}')]
    # Next Step : Inform m/d to Acknowledged
    Keywords.Input Text And Click Select From List  (//input[contains(@aria-autocomplete,'list')])[9]   Inform man-day   ${selectAction}
    Keywords.Click Button And Wait Loading screen   ${btnSubmit}

Business Approve and Convert to CR
    [Arguments]   ${TaskName}
    Keywords.Wait Loading screen Not Visible
    # Wait Until Element Is Enabled   (//tr[contains(@class,'cdk-header-row table-header ng-star-inserted')])[2]
    Keywords.Search Filters By Task ID / Task Name  ${TaskName}
    Keywords.Click Button And Wait Loading screen  //a[contains(.,'${TaskName}')]
    # Next Step : Inform m/d to SOLA
    Keywords.Input Text And Click Select From List  (//input[contains(@aria-autocomplete,'list')])[10]   Approve and Convert to CR   ${selectAction}
    Keywords.Click Button And Wait Loading screen   ${btnSubmit}

Create Task QR
    Create Tasks
    CSReview Add To My Tasks
    Raise to IT Head  ${TaskName}
    Raise to SOLA Review  ${TaskName}
    ## ----> SOLA Assigned to IT Security
    # SOLA Assigned to IT Security  ${TaskName}
    # Security Inform to SOLA  ${TaskName}
    ## ----> SOLA Assigned to Assign to Developer
    SOLA Assigned to Assign to Developer  ${TaskName}
    Developer Estimate Manday  ${TaskNameDev}
    ## ----> Return
    Return : Inform m/d to IT Head  ${TaskName}
    Return : Inform m/d to CS Tasks  ${TaskName}
    CS Tasks Inform m/d to Acknowledged  ${TaskName}
    Business Approve and Convert to CR  ${TaskName}


Create QR Flow to CR
    [Arguments]   ${TaskName}

    Raise to IT Head  ${TaskName}
    Raise to SOLA Review  ${TaskName}

    ## ----> SOLA Assigned to IT Security
    # SOLA Assigned to IT Security  ${TaskName}
    # Security Inform to SOLA  ${TaskName}

    ## ----> SOLA Assigned to Assign to Developer
    SOLA Assigned to Assign to Developer  ${TaskName}
    Developer Estimate Manday  ${TaskNameDev}

    ## ----> Return
    Return : Inform m/d to IT Head  ${TaskName}
    Return : Inform m/d to CS Tasks  ${TaskName}

    CS Tasks Inform m/d to Acknowledged  ${TaskName}
    Business Approve and Convert to CR  ${TaskName}
