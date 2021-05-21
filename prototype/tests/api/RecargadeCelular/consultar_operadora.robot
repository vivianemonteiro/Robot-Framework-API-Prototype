*** Settings ***
Resource    ../../../resources/services.robot

Test Setup    Create Session    hook    ${base_url}    verify=${True}

*** Test Cases ***

#Retorna lista de valores por operadora usando ddd e telefone válidos
Consulta Operadora DDD e Telefone Válidos
  
    ${user_id}=    Get User Token    username    password    

    ${resp}=    Consulta Operadora    ${user_id}    ddd    telefone

    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.text}           {"isSucesso":true,"resultado":{"nomeOperadora":"Vivo","idOperadora":2088,"codigoErro":"000","mensagem":"SUCESSO","situacao":"0"}}

#Retorna erro, pois o ddd está inválido
Consulta Operadora DDD Inválido e Telefone Válidos

    ${user_id}=    Get User Token    username    password    

    ${resp}=    Consulta Operadora    ${user_id}    ddd    telefone

    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.text}           {"isSucesso":false,"erros":[{"codigo":0,"mensagem":"Por favor, insira um ddd válido"}]}
   
#Retorna erro pois o telefone está com 8 dígitos
Consulta Operadora DDD Válido e Telefone com 8 Dígitos

    ${user_id}=    Get User Token    username    password    

    ${resp}=    Consulta Operadora    ${user_id}    ddd    telefoneinvalido

    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.text}           {"isSucesso":false,"erros":[{"codigo":1,"mensagem":"O número deve conter 9 dígitos"}]}

#Retorna erro pois o telefone não existe
Consulta Operadora DDD Válido e Telefone inexistente

    ${user_id}=    Get User Token    username    password    

    ${resp}=    Consulta Operadora    ${user_id}    ddd    telefoneinexistente

    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.text}           {"isSucesso":false,"erros":[{"codigo":1,"mensagem":"OPERADORA NAO LOCALIZADA"}]}
 
#Retorna pois o ddd e o telefone informados não existe
Consulta Operadora DDD e Telefone Inválidos

    ${user_id}=    Get User Token    username    password    

    ${resp}=    Consulta Operadora    ${user_id}    ddd    telefoneinvalido

    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.text}           {"isSucesso":false,"erros":[{"codigo":0,"mensagem":"Por favor, insira um ddd válido"}]}

#Retorna erro, uma vez que o usuário não foi informado
Consulta Operadora com Usuário Inválido

    ${user_id}=    Get User Token    ${EMPTY}    password    

    ${resp}=    Consulta Operadora    ${user_id}    ddd    telefone

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}

#Retorna erro, uma vez que a senha não foi informada
Consulta Operadora para um Usuário com Senha Inválida

    ${user_id}=    Get User Token    username    ${EMPTY}    

    ${resp}=    Consulta Operadora    ${user_id}    ddd    telefone

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}

#Retorna erro, uma vez que o login não foi realizado com sucesso
Consulta Operadora para um Usuário com Login Inválido

    ${user_id}=    Get User Token    ${EMPTY}    ${EMPTY}    

    ${resp}=    Consulta Operadora    ${user_id}    ddd    telefone

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}
