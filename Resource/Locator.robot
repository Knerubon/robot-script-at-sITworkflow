*** Variables ***
# Menu
${TabInvolvedTasks}   //a[@role='tab'][contains(.,'Involved Tasks')]
${CSTasks}   //a[@routerlinkactive='router-link-active-sub'][contains(.,'CS Tasks')]
${MyTasks}   //a[@routerlinkactive='router-link-active-sub'][contains(.,'My Tasks')]

# Input
${EmailLogin}   //input[contains(@type,'email')]
${__PwdLogin}   //input[contains(@name,'passwd')]

# Input Request Detail
${SelectdepartmentSelector}   //ng-select[contains(@name,'departmentSelector')]
${EnterpriseSystemsDepartment}   //div[@class='ng-option ng-star-inserted'][contains(.,'Enterprise Systems Department')]
${selectserviceSelector}   //ng-select[contains(@name,'serviceSelector')]
${Chatbot}   //div[@class='ng-option ng-star-inserted'][contains(.,'Chatbot')]
${inputTaskName}   //input[contains(@formcontrolname,'taskName')]
${objectTypeSelector}   //ng-select[contains(@name,'objectTypeSelector')]
${Management Report}   //div[@class='ng-option ng-star-inserted'][contains(.,'Management Report')]
${inputScopeOfWork}   //textarea[contains(@name,'scopeOfWork')]
${inputBenefitDescription}   //textarea[contains(@formcontrolname,'benefitDescription')]
${inputBusinessValue}   //input[contains(@formcontrolname,'businessValue')]
${BusinessUnitHead}   (//input[contains(@aria-autocomplete,'list')])[6]
${BusinessDepHead}   (//input[contains(@aria-autocomplete,'list')])[7]
${SelectInput}   //div[contains(@class,'border px-2 ng-star-inserted')]
${comment}   //textarea[contains(@formcontrolname,'comment')]
${btnSubmit}   //button[@type='button'][contains(.,'Submit')]

${itHead}  //ng-select[@formcontrolname='itHead']
${nextActionSelector}  (//input[contains(@aria-autocomplete,'list')])[9]
${selectAction}  //span[contains(@class,'ng-option-label ng-star-inserted')]




# Button
${ClickNextLogin}    //input[contains(@value,'Next')]
${ClickSignin}   //input[contains(@value,'Sign in')]
${CreateTask}   //button[@type='button'][contains(.,'Create Task')]
${SelectTaskCategory}   //div[contains(@class,'ng-select-container')]
${TaskCategoryQR}   //div[@class='ng-option ng-option-marked ng-star-inserted'][contains(.,'(QR) Quotation Request')]

# Search Filters
${SearchFilters}   //a[@aria-controls='collapseExample'][contains(.,'Search Filters')]
${Inputkeyword}   //input[contains(@formcontrolname,'keyword')]