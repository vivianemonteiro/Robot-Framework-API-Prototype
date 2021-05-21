
*** Settings ***
Resource    ../../../resources/services.robot

Test Setup    Create Session    hook    ${base_url}    verify=${True}


*** Test Cases ***

#Retorna os dados para pagamento de um boleto 
Consultar Código de Barras Válido
   
    ${user_id}=    Get User Token    username    password    

    ${resp}=    Consultar Código de Barras    ${user_id}    /34195824700000749641090267127274522026428000

    Should Be Equal As Strings    ${resp.status_code}    200
    Log     ${resp.text}

#Retorna erro ao informar o uma linha digitável ao invés de um código de barras
Consultar uma Linha Digitável no Lugar do Código de Barras
   
    ${user_id}=    Get User Token    username    password    

    ${resp}=    Consultar Código de Barras   ${user_id}    /23793390199100027687228004020005582350000066493

    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.text}          {"isSucesso":false,"erros":[{"codigo":1,"mensagem":"Código em barras inválido"}]}

#Retorna erro ao informar um código de barras inválido
Consultar um Código de Barras Inválido
   
    ${user_id}=    Get User Token    username    password    

    ${resp}=    Consultar Código de Barras   ${user_id}    /abcdef

    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.text}          {"isSucesso":false,"erros":[{"codigo":1,"mensagem":"Erro na conversao de Codigo de Barras para Linha Digitavel"}]}

#Retorna erro ao não informar o usuário
Consultar Código de Barras para um Usuário Inválido
   
    ${user_id}=    Get User Token    ${EMPTY}    password    

    ${resp}=    Consultar Código de Barras    ${user_id}    /34195824700000749641090267127274522026428000    

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}

#Retorna erro ao não informar a senha de login
Consultar Código de Barras Sem Informar a Senha do Usuário
   
    ${user_id}=    Get User Token    username    ${EMPTY}    

    ${resp}=    Consultar Código de Barras    ${user_id}    /34195824700000749641090267127274522026428000

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}

#Retorna erro ao não informar os campos de login
Consultar Código de Barras Sem Informar um Login
   
    ${user_id}=    Get User Token    ${EMPTY}    ${EMPTY}

    ${resp}=   Consultar Código de Barras   ${user_id}    /34195824700000749641090267127274522026428000
  
    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}
