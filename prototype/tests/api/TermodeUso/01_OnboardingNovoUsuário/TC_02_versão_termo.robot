
*** Settings ***
Resource    ../../../../resources/services.robot

Test Setup    Create Session    hook    ${base_url}    verify=${True}


*** Test Cases ***

#Retorna os dados do termo de uso vigente
Consultar Termo de Uso

    ${user_id}=    Get User Token    username    password    

    ${resp}=    Consultar Termos Vigentes    ${user_id}    /TermoUso

    Should Be Equal As Strings    ${resp.status_code}    200
    Log To Console                ${resp.text}           

#Retorna os dados da política de privacidade vigente
Consultar Política de Privacidade

    ${user_id}=    Get User Token    username    password    

    ${resp}=    Consultar Termos Vigentes    ${user_id}    /PoliticaPrivacidade

    Should Be Equal As Strings    ${resp.status_code}    200
    Log To Console                ${resp.text}           

#Retorna erro ao tentar consultar ambos os temos
Consultar Ambos os Termos

    ${user_id}=    Get User Token    username    password    

    ${resp}=    Consultar Termos Vigentes    ${user_id}    /${EMPTY} 

    Should Be Equal As Strings    ${resp.status_code}    404
    Should Be Equal As Strings    ${resp.text}           {"message":"No HTTP resource was found that matches the request URI 'http://termosUso/versaoAtual/'."}

#Retorna termos pois é uma API aberta
Consultar Termo para um Usuário Inválido

    ${user_id}=    Get User Token    ${EMPTY}    password    

    ${resp}=    Consultar Termos Vigentes    ${EMPTY}    /TermoUso

    Should Be Equal As Strings    ${resp.status_code}    200
    Log To Console                ${resp.text}

#Retorna termos pois é uma API aberta
Consultar Termo Sem Informar a Senha do Usuário

    ${user_id}=    Get User Token    username    ${EMPTY}    

    ${resp}=    Consultar Termos Vigentes    ${user_id}    /TermoUso

    Should Be Equal As Strings    ${resp.status_code}    200
    Log To Console                ${resp.text}

#Retorna termos pois é uma API aberta
Consultar Termo Sem Informar um Login

    ${user_id}=    Get User Token    ${EMPTY}    ${EMPTY}

    ${resp}=    Consultar Termos Vigentes    ${user_id}    /TermoUso

    Should Be Equal As Strings    ${resp.status_code}    200
    Log To Console                ${resp.text}

#Retorna termos pois é uma API aberta
Consultar Política para um Usuário Inválido

    ${user_id}=    Get User Token    ${EMPTY}    password    

    ${resp}=    Consultar Termos Vigentes    ${user_id}    /PoliticaPrivacidade

    Should Be Equal As Strings    ${resp.status_code}    200
    Log To Console                ${resp.text}

#Retorna termos pois é uma API aberta
Consultar Política Sem Informar a Senha do Usuário

    ${user_id}=    Get User Token    username    ${EMPTY}    

    ${resp}=    Consultar Termos Vigentes    ${user_id}    /PoliticaPrivacidade

    Should Be Equal As Strings    ${resp.status_code}    200
    Log To Console                ${resp.text}

#Retorna termos pois é uma API aberta
Consultar Política Sem Informar um Login

    ${user_id}=    Get User Token    ${EMPTY}    ${EMPTY}

    ${resp}=    Consultar Termos Vigentes    ${user_id}    /PoliticaPrivacidade

    Should Be Equal As Strings    ${resp.status_code}    200
    Log To Console    ${resp.text}     