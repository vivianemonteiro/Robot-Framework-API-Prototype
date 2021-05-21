
*** Settings ***
Resource    ../../../resources/services.robot

Test Setup    Create Session    hook    ${base_url}    verify=${True}


*** Test Cases ***

#Retorna os dados do saldo de uma viagem válida
Consultar Documentos Exigidos de uma Viagem Válida
   
    ${user_id}=    Get User Token    username    password    

    ${resp}=    Consultar Documentos Exigidos    ${user_id}    /381083/documentosExigidos

    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.text}           {"isSucesso":true,"resultado":[{"documento":"Tiquete de balança","identificacao":""},{"documento":"Canhoto da nota fiscal","identificacao":"Nº 1599511 Série 159951"},{"documento":"Canhoto da nota fiscal","identificacao":"Nº 1597533 Série 159753"},{"documento":"Cópia do documento de transporte","identificacao":"Nº 1599511 Série 159951"},{"documento":"Cópia do documento de transporte","identificacao":"Nº 1597533 Série 159753"}]}

#Retorna erro ao informar o um id de viagem inexistente
Consultar Documentos Exigidos de uma Viagem Inexistente
   
    ${user_id}=    Get User Token    username    password    

    ${resp}=    Consultar Documentos Exigidos    ${user_id}    /9390376/documentosExigidos 

    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.text}           {"isSucesso":false,"erros":[{"codigo":0,"mensagem":"Viagem 9390376 não carregada na base "}]}

#Retorna erro por informar um id viagem inválido
Consultar Documentos Exigidos de uma Viagem Inválida
    
    ${user_id}=    Get User Token    username    password    

    ${resp}=    Consultar Documentos Exigidos    ${user_id}    /abcde/documentosExigidos 

    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.text}           {"isSucesso":false,"erros":[{"codigo":0,"mensagem":"O valor informado no campo 'idViagem' não é válido"}]}

#Retorna erro ao não informar um id de viagem
Consultar Documentos Exigidos sem Informar o Id Viagem
 
    ${user_id}=    Get User Token    username    password    

    ${resp}=    Consultar Documentos Exigidos    ${user_id}    //documentosExigidos    

    Should Be Equal As Strings    ${resp.status_code}    404
    Should Be Equal As Strings    ${resp.text}           {"message":"No HTTP resource was found that matches the request URI 'http://hook.com.br/api'."}

#Retorna erro ao não informar o usuário
Consultar Documentos Exigidos Informando um Usuário Inválido
 
    ${user_id}=    Get User Token    ${EMPTY}    password    

    ${resp}=    Consultar Documentos Exigidos    ${user_id}    /381083/documentosExigidos    

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}

#Retorna erro ao não informar a senha de login
Consultar Documentos Exigidos Sem Informar a Senha do Usuário
 
    ${user_id}=    Get User Token    username    ${EMPTY}    

    ${resp}=    Consultar Documentos Exigidos    ${user_id}    /381083/documentosExigidos    

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}

#Retorna erro ao não informar os campos de login
Consultar Documentos Exigidos Sem Informar um Login
 
    ${user_id}=    Get User Token    ${EMPTY}    ${EMPTY}

    ${resp}=    Consultar Documentos Exigidos    ${user_id}    /381083/documentosExigidos    

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}
