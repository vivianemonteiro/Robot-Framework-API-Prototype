
*** Settings ***
Resource    ../../../resources/services.robot

Test Setup    Create Session    hook    ${base_url}    verify=${True}


*** Test Cases ***

#Retorna o Saldo do cartão Visa do usuário logado
Consultar Saldo Válido

    ${user_id}=    Get User Token    username    password    

    ${resp}=    Saldo Cartão    ${user_id}    

    Should Be Equal As Strings    ${resp.status_code}    200
    Log To Console                ${resp.text}           


Consultar Saldo para um Usuário Inválido

    ${user_id}=    Get User Token    ${EMPTY}    password    

    ${resp}=    Saldo Cartão    ${user_id}    

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}

#Retorna erro ao não informar a senha de login
Consultar Saldo Sem Informar a Senha do Usuário

    ${user_id}=    Get User Token    username    ${EMPTY}    

    ${resp}=    Saldo Cartão    ${user_id}    

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}

#Retorna erro ao não informar os campos de login
Consultar Saldo Sem Informar um Login

    ${user_id}=    Get User Token    ${EMPTY}    ${EMPTY}

    ${resp}=    Saldo Cartão    ${user_id}    

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}
