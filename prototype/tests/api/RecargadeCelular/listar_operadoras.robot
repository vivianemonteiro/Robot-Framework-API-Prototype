*** Settings ***
Resource    ../../../resources/services.robot

Test Setup    Create Session    hook    ${base_url}    verify=${True}

*** Test Cases ***

#Retorna lista de Operadas existentes para o ddd informado
Listar Operadoras de DDD Válido
   
    ${user_id}=    Get User Token    username    password    

    ${resp}=    Listar Operadoras por DDD    ${user_id}    11

    Should Be Equal As Strings    ${resp.status_code}    200
    Log    ${resp.text}

#Retorna erro, uma vez que o ddd informado não existe
Listar Operadoras de DDD um Inválido
   
    ${user_id}=    Get User Token    username    password    

    ${resp}=    Listar Operadoras por DDD    ${user_id}    100

    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.text}           {"isSucesso":false,"erros":[{"codigo":0,"mensagem":"Por favor, insira um ddd válido"}]} 

#Retorna erro, uma vez que o usuário não foi informado
Listar Operadoras para um Usuário Inválido

    ${user_id}=    Get User Token    ${EMPTY}    password    

    ${resp}=    Listar Operadoras por DDD    ${user_id}    11

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}

#Retorna erro, uma vez que a senha não foi informada
Listar Operadoras para um Usuário com Senha Inválida

    ${user_id}=    Get User Token    username    ${EMPTY}    

    ${resp}=    Listar Operadoras por DDD    ${user_id}    11

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}

#Retorna erro, uma vez que o login não foi realizado com sucesso
Listar Contratantes para um Usuário com Login Inválido

    ${user_id}=    Get User Token    ${EMPTY}    ${EMPTY}    

    ${resp}=    Listar Operadoras por DDD    ${user_id}    11

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}
