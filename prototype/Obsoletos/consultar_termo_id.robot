
*** Settings ***
Resource    ../../../resources/services.robot

Test Setup    Create Session    hook    ${base_url}    verify=${True}


*** Test Cases ***

#Retorna os dados de um termo informando um id válido
Consultar Termo com Id Válido
  
    ${user_id}=    Get User Token    username    password    

    ${resp}=   Consultar Termo por Id    ${user_id}    /1

    Should Be Equal As Strings    ${resp.status_code}    200
    Log To Console  ${resp.text}   

#Retorna erro ao informar o um id inválido
Consultar um Termo com Id Inválido
    
    ${user_id}=    Get User Token    username    password    

    ${resp}=    Consultar Termo por Id   ${user_id}    /abcdef

    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.text}         {"isSucesso":false,"erros":[{"codigo":0,"mensagem":"O valor informado no campo 'id' não é válido"}]}

#Retorna erro ao não informar um id
Consultar Termo sem Informar o Id
  
    ${user_id}=    Get User Token    username    password    

    ${resp}=   Consultar Termo por Id   ${user_id}    / 

    Should Be Equal As Strings    ${resp.status_code}    404
    Should Be Equal As Strings    ${resp.text}         {"message":"No HTTP resource was found that matches the request URI 'http://bunge.sit.integracao.pagbem.com.br/api/termosUso/consulta/'."}

#Retorna erro ao não informar o usuário
Consultar Termo para um Usuário Inválido
   
    ${user_id}=    Get User Token    ${EMPTY}    password    

    ${resp}=   Consultar Termo por Id    ${user_id}    /1

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}

#Retorna erro ao não informar a senha de login
Consultar Termo Sem Informar a Senha do Usuário
   
    ${user_id}=    Get User Token    username    ${EMPTY}    

    ${resp}=    Consultar Termo por Id   ${user_id}    /1

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}

#Retorna erro ao não informar os campos de login
Consultar Termo Sem Informar um Login
   
    ${user_id}=    Get User Token    ${EMPTY}    ${EMPTY}

    ${resp}=   Consultar Termo por Id   ${user_id}    /1
  
    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}
