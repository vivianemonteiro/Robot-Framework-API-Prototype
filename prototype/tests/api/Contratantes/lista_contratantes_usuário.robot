*** Settings ***
Resource    ../../../resources/services.robot

Test Setup    Create Session    hook    ${base_url}    verify=${True}


*** Test Cases ***

#Retorna lista de todos os contratantes vinculados ao usuário
Listar Contratantes

    ${user_id}=    Get User Token    username    password    

    ${resp}=    Lista Contratantes Usuário    ${user_id}    

    Should Be Equal As Strings    ${resp.status_code}                200
    Should Be Equal As Strings    ${resp.json().get("isSucesso")}    True
    Log    ${resp.text}

#Retorna erro, uma vez que o usuário não foi informado
Listar Contratantes Usuário Inválido

    ${user_id}=    Get User Token    ${EMPTY}    password    

    ${resp}=    Lista Contratantes Usuário    ${user_id}    

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}
 
#Retorna erro, uma vez que a senha não foi informada
Listar Contratantes Senha Inválida

    ${user_id}=    Get User Token    username    ${EMPTY}    

    ${resp}=    Lista Contratantes Usuário    ${user_id}    

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}

#Retorna erro, uma vez que o login não foi realizado com sucesso
Listar Contratantes Login Inválido

    ${user_id}=    Get User Token    ${EMPTY}    ${EMPTY}    

    ${resp}=    Lista Contratantes Usuário    ${user_id}    

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}
