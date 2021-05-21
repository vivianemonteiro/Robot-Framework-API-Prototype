
*** Settings ***
Resource    ../../../resources/services.robot

Test Setup    Create Session    hook    ${base_url}    verify=${True}


*** Test Cases ***

#Retorna os dados do usuário logado
Consultar Informações do Usuário Logado

    ${user_id}=    Get User Token    username     password    

    ${resp}=   Consultar Informações do Usuário Logado    ${user_id}    

    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.text}       {"isSucesso":true,"resultado":{"idUsuario":1776,"nomeUsuario":"Teste Motorista Vivi","cpf":"username"}}

#Retorna erro ao não informar o usuário
Consultar Informações de um Usuário Inválido
   
    ${user_id}=    Get User Token    ${EMPTY}       password    

    ${resp}=   Consultar Informações do Usuário Logado    ${user_id}   

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}

#Retorna erro ao não informar a senha de login
Consultar Informações de um Usuário sem Senha 
   
    ${user_id}=    Get User Token    username    ${EMPTY}    

    ${resp}=    Consultar Informações do Usuário Logado   ${user_id}   

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}

#Retorna erro ao não informar os campos de login
Consultar Informações de um Usuário Sem Login
   
    ${user_id}=    Get User Token    ${EMPTY}    ${EMPTY}

    ${resp}=   Consultar Informações do Usuário Logado   ${user_id}   
  
    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}
