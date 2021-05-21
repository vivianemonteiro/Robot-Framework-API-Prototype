***Settings***
Library         SeleniumLibrary



***Test Cases***
Usuário consegue logar
    Open Browser                    https://youraddresshere       chrome
    Set Selenium Implicit Wait      5

    Input Text          id:Usuario      usernameorid
    Input Text          id:Password     password    
    Click Element       xpath://button[contains(text(),'Login')]
  
    Page Should Contain Element     class:ng-scope
    Close Browser
