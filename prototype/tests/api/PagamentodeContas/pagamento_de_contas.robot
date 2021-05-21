*** Settings ***
Resource    ../../../resources/services.robot

Test Setup    Create Session    hook    ${base_url}    verify=${True}

*** Test Cases ***

#Realizar um pagamento válido
Pagamento Válido
    [Template]  Realizar Pagamento de Conta 

    {"idTransacao": 1877,"numeroCartao": "xxxxxxxxxxxxx","valor": 10,"valorBruto": 0,"valorDescontos": 0,"valorAcrescimos": 0,"tipoOrigemPagamento": "Cartão"}     True  

#Realizar um pagamento com valor inválido
Pagamento com Valor Inválido
    [Template]  Realizar Pagamento de Conta

    {"idTransacao": 1852,"numeroCartao": "xxxxxxxxxxxxx","valor": 0.00,"valorBruto": 0,"valorDescontos": 0,"valorAcrescimos": 0,"tipoOrigemPagamento": "Cartão"}     False  

#Realizar um pagamento com cartão sem saldo
Pagamento com Cartão Sem Saldo
    [Template]  Realizar Pagamento de Conta

    {"idTransacao": 1852,"numeroCartao": "xxxxxxxxxxxxx","valor": 664.93,"valorBruto": 0,"valorDescontos": 0,"valorAcrescimos": 0,"tipoOrigemPagamento": "PrePago"}     False  

#Realizar pagamento informando cartão de outro usuário
Pagamento com Cartão de Terceiro
    [Template]  Realizar Pagamento de Conta

    {"idTransacao": 1852,"numeroCartao": "zzzzzzzzzzzzzzzzzz","valor": 664.93,"valorBruto": 0,"valorDescontos": 0,"valorAcrescimos": 0,"tipoOrigemPagamento": "Cartão"}     False

#Realizar pagamento de um boleto já pago
Pagamento de um Boleto já quitado
    [Template]  Realizar Pagamento de Conta

    {"idTransacao": 1541,"numeroCartao": "xxxxxxxxxxxxx","valor": 48.00,"valorBruto": 0,"valorDescontos": 0,"valorAcrescimos": 0,"tipoOrigemPagamento": "Cartão"}   False