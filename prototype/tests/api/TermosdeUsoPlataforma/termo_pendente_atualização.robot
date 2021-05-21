
*** Settings ***
Resource    ../../../resources/services.robot

Test Setup    Create Session    hook    ${base_url}    verify=${True}


*** Test Cases ***

#Retorna os termos Pendentes Atualizados pelo usuário logado
Consultar Termos Pendentes Atualizados do Usuário Logado
    
    ${user_id}=    Get User Token    username    password    

    ${resp}=    Consultar Termos Pendentes Atualizados    ${user_id}   

    Should Be Equal As Strings    ${resp.status_code}    200
    Log To Console                ${resp.text}        
    
#Retorna erro ao não informar o usuário
Consultar Termos Pendentes Atualizados para um Usuário Inválido
  
    ${user_id}=    Get User Token    ${EMPTY}    password    

    ${resp}=    Consultar Termos Pendentes Atualizados    ${user_id}    

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}

#Retorna erro ao não informar a senha de login
Consultar Termos Pendentes Atualizados Sem Informar a Senha do Usuário
    
    ${user_id}=    Get User Token    username    ${EMPTY}    

    ${resp}=    Consultar Termos Pendentes Atualizados    ${user_id}    

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}

#Retorna erro ao não informar os campos de login
Consultar Termos Pendentes Atualizados Sem Informar um Login
   
    ${user_id}=    Get User Token    ${EMPTY}    ${EMPTY}

    ${resp}=    Consultar Termos Pendentes Atualizados    ${user_id}    

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}
