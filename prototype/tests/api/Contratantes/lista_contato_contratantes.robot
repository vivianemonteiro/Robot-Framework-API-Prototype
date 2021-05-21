*** Settings ***
Resource    ../../../resources/services.robot

Test Setup    Create Session    hook    ${base_url}    verify=${True}


*** Test Cases ***

#Retorna lista com o contato de todos os contratantes
Listar Contato Contratantes

    ${user_id}=    Get User Token    username    password    

    ${resp}=    Lista Contato Contratantes    ${user_id}    

    Should Be Equal As Strings    ${resp.status_code}                200
    Should Be Equal As Strings    ${resp.json().get("isSucesso")}    True
    Log    ${resp.text}

#Retorna erro, uma vez que o usuário não foi informado
Listar Contato Contratantes Usuário Inválido

    ${user_id}=    Get User Token    ${EMPTY}    password    

    ${resp}=    Lista Contato Contratantes    ${user_id}    

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}  {"message":"Authorization has been denied for this request."}
   
#Retorna erro, uma vez que a senha não foi informada
Listar Contato Contratantes Senha Inválida

    ${user_id}=    Get User Token    username    ${EMPTY}    

    ${resp}=    Lista Contato Contratantes    ${user_id}    

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}  {"message":"Authorization has been denied for this request."}
 
#Retorna erro, uma vez que o login não foi realizado com sucesso
Listar Contato Contratantes Login Inválido

    ${user_id}=    Get User Token    ${EMPTY}    ${EMPTY}    

    ${resp}=    Lista Contato Contratantes    ${user_id}    

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}  {"message":"Authorization has been denied for this request."}
