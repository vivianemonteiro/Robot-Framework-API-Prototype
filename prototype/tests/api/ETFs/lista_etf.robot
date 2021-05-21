*** Settings ***
Resource    ../../../resources/services.robot

Test Setup    Create Session    hook    ${base_url}    verify=${True}


*** Test Cases ***

#Retorna lista sem especificar uma data
Listar ETFs sem Informar data
   
    ${user_id}=    Get User Token    username    password

    ${resp}=    Listar ETFs    ${user_id}    ${EMPTY}   ${EMPTY}

    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json().get("isSucesso")}    True
    Log     ${resp.text}

#Retorna lista com uma data especifica
Listar ETFs Informando uma Data Específica

    ${user_id}=    Get User Token    username    password

    ${resp}=    Listar ETFs    ${user_id}       ?dataLista      =2020-05-05

    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json().get("isSucesso")}    True
    Log         ${resp.text}

#Retorna lista com uma data incompleta
Listar ETFs Informando uma Data Incompleta

    ${user_id}=    Get User Token    username    password

    ${resp}=    Listar ETFs    ${user_id}       ?dataLista      =2020

    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.text}   {"isSucesso":false,"erros":[{"codigo":0,"mensagem":"O valor informado no campo 'dataLista' não é válido"}]}

#Retorna lista com uma data inválida
Listar ETFs Informando uma Data Inválida

    ${user_id}=    Get User Token    username    password

    ${resp}=    Listar ETFs    ${user_id}       ?dataLista      =abcdefg

    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.text}   {"isSucesso":false,"erros":[{"codigo":0,"mensagem":"O valor informado no campo 'dataLista' não é válido"}]}

#Retorna lista com uma data inexistente
Listar ETFs Informando uma Data Inexistente

    ${user_id}=    Get User Token    username    password

    ${resp}=    Listar ETFs    ${user_id}       ?dataLista      =2019-12-32

    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.text}   {"isSucesso":false,"erros":[{"codigo":0,"mensagem":"O valor informado no campo 'dataLista' não é válido"}]}

#Retorna erro, uma vez que o usuário não foi informado
Listar ETFs para um Usuário Inválido

    ${user_id}=    Get User Token    ${EMPTY}    password

    ${resp}=    Listar ETFs    ${user_id}    ${EMPTY}   ${EMPTY}

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}
   
#Retorna erro, uma vez que a senha não foi informada
Listar ETFs para um Usuário com Senha Inválida

    ${user_id}=    Get User Token    username    ${EMPTY}    

    ${resp}=    Listar ETFs   ${user_id}    ${EMPTY}   ${EMPTY}

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}

#Retorna erro, uma vez que o login não foi realizado com sucesso
Listar ETFs para Usuário com Login Inválido

    ${user_id}=    Get User Token    ${EMPTY}    ${EMPTY}    

    ${resp}=    Listar ETFs    ${user_id}    ${EMPTY}   ${EMPTY}

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}
   