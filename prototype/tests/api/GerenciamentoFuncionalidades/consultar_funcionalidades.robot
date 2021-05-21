
*** Settings ***
Resource    ../../../resources/services.robot

Test Setup    Create Session    hook    ${base_url}    verify=${True}


*** Test Cases ***

#Retorna os dados do usuário logado
Consultar Funcionalidades do Usuário Logado

    ${user_id}=    Get User Token    username     password    

    ${resp}=   Consultar Funcionalidades Disponíveis    ${user_id}    

    Should Be Equal As Strings    ${resp.status_code}    200
    Log To Console  ${resp.text}       

#Retorna erro ao não informar o usuário
Consultar Funcionalidades de um Usuário Inválido
   
    ${user_id}=    Get User Token    ${EMPTY}       password    

    ${resp}=  Consultar Funcionalidades Disponíveis    ${user_id}   

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}

#Retorna erro ao não informar a senha de login
Consultar Funcionalidades de um Usuário sem Senha 
   
    ${user_id}=    Get User Token    username    ${EMPTY}    

    ${resp}=   Consultar Funcionalidades Disponíveis   ${user_id}   

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}

#Retorna erro ao não informar os campos de login
Consultar Funcionalidades de um Usuário Sem Login
   
    ${user_id}=    Get User Token    ${EMPTY}    ${EMPTY}

    ${resp}=  Consultar Funcionalidades Disponíveis   ${user_id}   
  
    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}
