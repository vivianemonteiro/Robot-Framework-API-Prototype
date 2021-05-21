
*** Settings ***
Resource    ../../../resources/services.robot

Test Setup    Create Session    hook    ${base_url}    verify=${True}


*** Test Cases ***

#Retorna os valores para transfêrencia do saldo Cartão
Consultar Valores de Transferência Saldo Cartão

    ${user_id}=    Get User Token    username    password    

    ${resp}=    Consultar Valores de Transferência    ${user_id}    /Cartão

    Should Be Equal As Strings    ${resp.status_code}    200                                                                                                                                                       
    Should Be Equal As Strings    ${resp.text}           {"isSucesso":true,"resultado":{"tarifaOutroCartao":3.00,"tarifaPrePago":7.90,"tarifaContaCorrente":7.90,"valorReferenciaTarifaContaCorrente":1500.00}}

#Retorna os valores para transferência do saldo Pré Pago
Consultar Valores de Transferência Saldo Pré Pago

    ${user_id}=    Get User Token    username    password    

    ${resp}=    Consultar Valores de Transferência    ${user_id}    /PrePago 

    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.text}           {"isSucesso":true,"resultado":{"tarifaOutroCartao":0.0,"tarifaPrePago":7.90,"tarifaContaCorrente":7.90,"valorReferenciaTarifaContaCorrente":1500.00}}    

#Retorna os valores para transferência do saldo Viagem
Consultar Valores de Transferência Saldo Viagem

    ${user_id}=    Get User Token    username    password    

    ${resp}=    Consultar Valores de Transferência    ${user_id}    /Viagem

    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.text}           {"isSucesso":true,"resultado":{"tarifaOutroCartao":0.0,"tarifaPrePago":7.90,"tarifaContaCorrente":7.90,"valorReferenciaTarifaContaCorrente":1500.00}}


#Retorna os valores para transferência do saldo Combustível
Consultar Valores de Transferência Saldo Combustível

    ${user_id}=    Get User Token    username    password    

    ${resp}=    Consultar Valores de Transferência    ${user_id}    /Combustivel

    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.text}           {"isSucesso":true,"resultado":{"tarifaOutroCartao":0.0,"tarifaPrePago":7.90,"tarifaContaCorrente":7.90,"valorReferenciaTarifaContaCorrente":1500.00}}


#Retorna erro ao não informar o usuário
Consultar Valor Cartão para um Usuário Inválido

    ${user_id}=    Get User Token    ${EMPTY}    password    

    ${resp}=    Consultar Valores de Transferência    ${user_id}    /Cartão

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}

#Retorna erro ao não informar a senha de login
Consultar Valor Cartão Sem Informar a Senha do Usuário

    ${user_id}=    Get User Token    username    ${EMPTY}    

    ${resp}=    Consultar Valores de Transferência    ${user_id}    /Cartão

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}

#Retorna erro ao não informar os campos de login
Consultar Valor Cartão Sem Informar um Login

    ${user_id}=    Get User Token    ${EMPTY}    ${EMPTY}

    ${resp}=    Consultar Valores de Transferência    ${user_id}    /Cartão

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}

#Retorna erro ao não informar o usuário
Consultar Valor Pré Pago para um Usuário Inválido

    ${user_id}=    Get User Token    ${EMPTY}    password    

    ${resp}=    Consultar Valores de Transferência    ${user_id}    /PrePago

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}

#Retorna erro ao não informar a senha de login
Consultar Valor Pré Pago Sem Informar a Senha do Usuário

    ${user_id}=    Get User Token    username    ${EMPTY}    

    ${resp}=    Consultar Valores de Transferência    ${user_id}    /PrePago

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}

#Retorna erro ao não informar os campos de login
Consultar Valor Pré Pago Sem Informar um Login

    ${user_id}=    Get User Token    ${EMPTY}    ${EMPTY}

    ${resp}=    Consultar Valores de Transferência    ${user_id}    /PrePago

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}

#Retorna erro ao não informar o usuário
Consultar Valor Viagem para um Usuário Inválido

    ${user_id}=    Get User Token    ${EMPTY}    password    

    ${resp}=    Consultar Valores de Transferência    ${user_id}    /Viagem

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}

#Retorna erro ao não informar a senha de login
Consultar Valor Viagem Sem Informar a Senha do Usuário

    ${user_id}=    Get User Token    username    ${EMPTY}    

    ${resp}=    Consultar Valores de Transferência    ${user_id}    /Viagem

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}

#Retorna erro ao não informar os campos de login
Consultar Valor Viagem Sem Informar um Login

    ${user_id}=    Get User Token    ${EMPTY}    ${EMPTY}

    ${resp}=    Consultar Valores de Transferência    ${user_id}    /Viagem

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}

#Retorna erro ao não informar o usuário
Consultar Valor Combustível para um Usuário Inválido

    ${user_id}=    Get User Token    ${EMPTY}    password    

    ${resp}=    Consultar Valores de Transferência    ${user_id}    /Combustivel

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}

#Retorna erro ao não informar a senha de login
Consultar Valor Combustível Sem Informar a Senha do Usuário

    ${user_id}=    Get User Token    username    ${EMPTY}    

    ${resp}=    Consultar Valores de Transferência    ${user_id}    /Combustivel

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}

#Retorna erro ao não informar os campos de login
Consultar Valor Combustível Sem Informar um Login

    ${user_id}=    Get User Token    ${EMPTY}    ${EMPTY}

    ${resp}=    Consultar Valores de Transferência    ${user_id}    /Combustivel

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}
