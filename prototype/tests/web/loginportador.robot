***Settings***
Resource        ../resources/steps_kw.robot

Suite Setup      Start Session
Suite Teardown   Close Browser

Test Teardown    End Test


***Test Cases***
Usuário consegue logar
    Dado que estou na página de login
    Quando eu submeto minha credencial de login "24028457084"
    E a senha "789654"
    Então a área logada deve ser exibida
    E devo sair da área logada
    
Usuário não loga com id incorreto       
    [Template]      Tentar logar
    xxxxxxxxxxx     password      Erro na autenticação, verificar usuário e senha

Id deve ser obrigatório
    [Template]      Tentar logar
    ${EMPTY}    ${EMPTY}        Por favor, informar o usuário!


*** Keywords ***
Tentar logar
    [Arguments]     ${cpf}      ${senha}        ${expect_mesage} 
    Dado que estou na página de login
    Quando eu submeto minha credencial de login "${cpf}"
    E a senha "${senha}"
    Então devo ver a mensagem de alerta "${expect_mesage}"
    E devo dar OK na mensagem de erro

    


