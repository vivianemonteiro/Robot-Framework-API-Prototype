
*** Settings ***
Resource    ../../../resources/services.robot

Test Setup    Create Session    hook    ${base_url}    verify=${True}


*** Test Cases ***

#Retorna os dados para pagamento de um boleto 
Consultar Linha Digitável Válida

    ${user_id}=    Get User Token    username    password    

    ${resp}=    Consultar Linha Digitável    ${user_id}    /23793390199100027687228004020005582350000066493

    Should Be Equal As Strings    ${resp.status_code}    200
    Log     ${resp.text}

#Retorna erro ao informar o uma linha digitável ao invés de um código de barras
Consultar um Código de Barras no Lugar de uma Linha Digitável
   
    ${user_id}=    Get User Token    username    password    

    ${resp}=    Consultar Linha Digitável   ${user_id}    /34195824700000749641090267127274522026428000

    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.text}         {"isSucesso":false,"erros":[{"codigo":1,"mensagem":"Erro na conversao de Codigo de Barras para Linha Digitavel"}]}

#Retorna erro ao informar o uma linha digitável ao invés de um código de barras
Consultar uma Linha Digitável Inválida

    ${user_id}=    Get User Token    username    password    

    ${resp}=    Consultar Linha Digitável   ${user_id}    /abcdef

    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.text}         {"isSucesso":false,"erros":[{"codigo":1,"mensagem":"Erro na conversao de Codigo de Barras para Linha Digitavel"}]}

#Retorna erro ao consultar um boleto já pago
Consultar uma Linha Digitável Já Quitada

    ${user_id}=    Get User Token    username    password    

    ${resp}=    Consultar Linha Digitável   ${user_id}    /23793381286002532510510000063304482380000002190

    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.text}         {"isSucesso":false,"erros":[{"codigo":1,"mensagem":"Pagamento ja efetuado."}]}

#Retorna erro ao não informar o usuário
Consultar Linha Digitável para um Usuário Inválido

    ${user_id}=    Get User Token    ${EMPTY}    password    

    ${resp}=    Consultar Linha Digitável    ${user_id}    /23793390199100027687228004020005582350000066493    

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}

#Retorna erro ao não informar a senha de login
Consultar Linha Digitável Sem Informar a Senha do Usuário

    ${user_id}=    Get User Token    username    ${EMPTY}    

    ${resp}=    Consultar Linha Digitável    ${user_id}    /23793390199100027687228004020005582350000066493

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}

#Retorna erro ao não informar os campos de login
Consultar Linha Digitável Sem Informar um Login

    ${user_id}=    Get User Token    ${EMPTY}    ${EMPTY}

    ${resp}=   Consultar Linha Digitável   ${user_id}    /23793390199100027687228004020005582350000066493

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}
