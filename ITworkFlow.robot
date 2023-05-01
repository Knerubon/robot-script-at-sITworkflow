*** Settings ***
Resource                  Resource/Keywords.robot
Resource                  Resource/Variables.robot
Resource                  Resource/Locator.robot
Resource                  Resource/actionEvent.robot


*** Test Cases ***

CreateTask     # Create Task
    [Documentation]
        ...   Create Task  ${\n}
    [Tags]    Create Task
    Keywords.Open web set it workflow    ${user}    ${password}
    # input value From Excel
    Open Excel Document     ${ExcelName}        ${excelPath}
        
    ## ----> Start QR workflow
    Create Task QR
    


