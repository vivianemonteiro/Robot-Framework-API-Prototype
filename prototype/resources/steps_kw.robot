*** Settings ***
Resource        base.robot

*** Keywords ***
Dado que estou no swagger
    Go To        ${swagger}

Dado que estou na página de login
    Go To        ${base_url}


Quando eu submeto minha credencial de login "${cpf}"
    Input Text      id:Usuario      ${cpf}

E a senha "${senha}"
    Input Text      id:Password     ${senha}
    Click Element   xpath://button[contains(text(),'Login')]

Então a área logada deve ser exibida
    Page Should Contain Element     class:ng-scope

E devo sair da área logada
    Click Element               xpath://*[contains(@class,'fa fa-sign-out')] 

Então devo ver a mensagem de alerta "${expect_mesage}"
    Element Should Contain      class:sweet-alert      ${expect_mesage}

E devo dar OK na mensagem de erro
    Click Element               xpath://button[contains(text(),'OK')]

