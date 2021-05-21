*** Settings ***
Resource    ../../../resources/services.robot

Test Setup    Create Session    hook    ${base_url}    verify=${True}

*** Test Cases ***

#Retorna lista de valores por operadora usando ddd e id válidos
Lista de Valores por Operadora com DDD e Id Válidos
   
    ${user_id}=    Get User Token    username    password    

    ${resp}=    Listar Valor por Operadora     ${user_id}     11  2087

    Should Be Equal As Strings    ${resp.status_code}    200
    Log    ${resp.text}

#Retorna lista vazia por informar um id de operadora inválido
Lista de Valores por Operadora com Id Inválido

    ${user_id}=    Get User Token    username    password    

    ${resp}=    Listar Valor por Operadora     ${user_id}     11  4500

    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.text}  {"isSucesso":true,"resultado":{"valores":[]}}

#Retorna erro por informar um ddd inválido 
Lista de Valores por Operadora com DDD Inválido

    ${user_id}=    Get User Token    username    password    

    ${resp}=    Listar Valor por Operadora     ${user_id}     110  2087

    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.text}  {"isSucesso":false,"erros":[{"codigo":0,"mensagem":"Por favor, insira um ddd válido"}]}
 
#Retorna erro por informar um id inválido
Lista de Valores por Operadora com DDD e Id Inválidos

    ${user_id}=    Get User Token    username    password    

    ${resp}=    Listar Valor por Operadora     ${user_id}     110  4500

    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.text}  {"isSucesso":false,"erros":[{"codigo":0,"mensagem":"Por favor, insira um ddd válido"}]}

#Retorna erro, uma vez que o usuário não foi informado
Lista de Valores para um Usuário Inválido

    ${user_id}=    Get User Token    ${EMPTY}    password    

    ${resp}=    Listar Valor por Operadora    ${user_id}    11  2087

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}

#Retorna erro, uma vez que a senha não foi informada
Lista de Valores par um Usuário com Senha Inválida

    ${user_id}=    Get User Token    username    ${EMPTY}    

    ${resp}=    Listar Valor por Operadora    ${user_id}    11  2087

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}

#Retorna erro, uma vez que o login não foi realizado com sucesso
Lista de Valores para Usuário com Login Inválido

    ${user_id}=    Get User Token    ${EMPTY}    ${EMPTY}    

    ${resp}=   Listar Valor por Operadora    ${user_id}    11  2087

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}

