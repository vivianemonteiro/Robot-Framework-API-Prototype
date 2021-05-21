
*** Settings ***
Resource    ../../../resources/services.robot

Test Setup    Create Session    hook    ${base_url}    verify=${True}


*** Test Cases ***

#Retorna os termos pendentes do usuário logado
Consultar Termos Pendentes do Usuário Logado
   
    ${user_id}=    Get User Token    username    password    

    ${resp}=  Consultar Termos Pendentes de Aceite   ${user_id}    =username

    Should Be Equal As Strings    ${resp.status_code}    200
    Log To Console                ${resp.text}   

#Retorna erro ao consultar termos de uso pendentes de aceite de outro usuário
Consultar Termos Pendentes de Aceite de Outro Usuário
   
    ${resp}=    Consultar Termos Pendentes de Aceite   ${EMPTY}   =username

    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.text}         {"isSucesso":true,"resultado":[{"id":3,"tipoTermo":"PoliticaPrivacidade","nomeTermo":"Política de Privacidade"},{"id":4,"tipoTermo":"TermoUso","nomeTermo":"Termo de Uso"}]}

#Retorna erro ao consultar termos de uso pendentes de aceite de um usuário inválido
Consultar Termos Pendentes de Aceite de um Usuário Inválido

    ${user_id}=    Get User Token    username    password    

    ${resp}=    Consultar Termos Pendentes de Aceite   ${user_id}    =abcdef

    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.text}         {"isSucesso":false,"erros":[{"codigo":0,"mensagem":"Campo cpf deve ter um CNPJ ou CPF válido"}]}

#Retorna erro ao consultar termos de uso pendentes de aceite de usuário inexistente no sistema
Consultar Termos Pendentes de Aceite Usuário Inexistente

    ${user_id}=    Get User Token    username    password    

    ${resp}=    Consultar Termos Pendentes de Aceite   ${user_id}    =username

    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.text}         {"isSucesso":false,"erros":[{"codigo":1,"mensagem":"Por favor, verifique o CPF informado."}]}

#Retorna erro ao não informar um cpf
Consultar Termos Pendentes sem Informar o CPF

    ${user_id}=    Get User Token    username    password    

    ${resp}=   Consultar Termos Pendentes de Aceite   ${user_id}    =

    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.text}         {"isSucesso":false,"erros":[{"codigo":0,"mensagem":"A value is required but was not present in the request."}]}

#Retorna erro ao não informar o usuário
Consultar Termo para um Usuário Inválido

    ${user_id}=    Get User Token    ${EMPTY}    password    

    ${resp}=   Consultar Termos Pendentes de Aceite   ${user_id}    =username

    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.text}         {"isSucesso":true,"resultado":[{"id":3,"tipoTermo":"PoliticaPrivacidade","nomeTermo":"Política de Privacidade"},{"id":4,"tipoTermo":"TermoUso","nomeTermo":"Termo de Uso"}]}

#Retorna erro ao não informar a senha de login
Consultar Termo Sem Informar a Senha do Usuário

    ${user_id}=    Get User Token    username    ${EMPTY}    

    ${resp}=    Consultar Termos Pendentes de Aceite   ${user_id}    =username

    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.text}         {"isSucesso":true,"resultado":[{"id":3,"tipoTermo":"PoliticaPrivacidade","nomeTermo":"Política de Privacidade"},{"id":4,"tipoTermo":"TermoUso","nomeTermo":"Termo de Uso"}]}

#Retorna erro ao não informar os campos de login
Consultar Termo Sem Informar um Login

    ${user_id}=    Get User Token    ${EMPTY}    ${EMPTY}

    ${resp}=   Consultar Termos Pendentes de Aceite   ${user_id}    =username

    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.text}        {"isSucesso":true,"resultado":[{"id":3,"tipoTermo":"PoliticaPrivacidade","nomeTermo":"Política de Privacidade"},{"id":4,"tipoTermo":"TermoUso","nomeTermo":"Termo de Uso"}]}