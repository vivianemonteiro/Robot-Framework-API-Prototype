
*** Settings ***
Resource    ../../../resources/services.robot

Test Setup    Create Session    hook    ${base_url}    verify=${True}


*** Test Cases ***

#Retorna os dados do saldo de uma viagem válida
Consultar Saldo Frete de uma Viagem Válida
    
    ${user_id}=    Get User Token    username    password    

    ${resp}=    Consultar Viagem Saldo Frete    ${user_id}    /381083/consultarSaldoFrete

    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.text}           {"isSucesso":true,"resultado":{"idViagem":381083,"valorAdiantamentoBloqueadoContratado":0.00,"valorAdiantamentoBloqueadoMotorista":0.00,"valorQuitacaoBloqueadoContratado":0.00,"valorQuitacaoBloqueadoMotorista":989.88,"valorAdiantamentoLiberadoContratado":0.0,"valorAdiantamentoLiberadoMotorista":989.88,"valorQuitacaoLiberadoContratado":0.0,"valorQuitacaoLiberadoMotorista":0.0,"valorAdiantamentoUtilizadoContratado":0.00,"valorAdiantamentoUtilizadoMotorista":0.00,"valorQuitacaoUtilizadoContratado":0.0,"valorQuitacaoUtilizadoMotorista":0.0,"valorLiquidoFrete":1979.76}}

#Retorna erro ao informar o um id de viagem inválido
Consultar Saldo Frete de uma Viagem Inválida

    ${user_id}=    Get User Token    username    password    

    ${resp}=    Consultar Viagem Saldo Frete    ${user_id}    /9390376/consultarSaldoFrete 

    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.text}           {"isSucesso":false,"erros":[{"codigo":0,"mensagem":"Viagem 9390376 não carregada na base"}]}

#Retorna erro ao não informar um id de viagem
Consultar Saldo Frete sem Informar o Id Viagem

    ${user_id}=    Get User Token    username    password    

    ${resp}=    Consultar Viagem Saldo Frete    ${user_id}    //consultarSaldoFrete    

    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.text}           {"isSucesso":false,"erros":[{"codigo":0,"mensagem":"O valor informado no campo 'IdViagem' não é válido"}]}

#Retorna erro ao não informar o usuário
Consultar Saldo Viagem de um Usuário Inválido

    ${user_id}=    Get User Token    ${EMPTY}    password    

    ${resp}=    Consultar Viagem Saldo Frete    ${user_id}    /381083/consultarSaldoFrete    

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}

#Retorna erro ao não informar a senha de login
Consultar Saldo Frete Sem Informar a Senha do Usuário

    ${user_id}=    Get User Token    username    ${EMPTY}    

    ${resp}=    Consultar Viagem Saldo Frete    ${user_id}    /381083/consultarSaldoFrete    

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}

#Retorna erro ao não informar os campos de login
Consultar Saldo Viagem Sem Informar um Login

    ${user_id}=    Get User Token    ${EMPTY}    ${EMPTY}

    ${resp}=    Consultar Viagem Saldo Frete    ${user_id}    /381083/consultarSaldoFrete    

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}
