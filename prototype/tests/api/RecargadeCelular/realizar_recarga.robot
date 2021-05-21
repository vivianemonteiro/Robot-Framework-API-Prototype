*** Settings ***
Resource    ../../../resources/services.robot

Test Setup    Create Session    hook    ${base_url}    verify=${True}

*** Test Cases ***

#Realizar uma recarga válida
Recarga Válida
    [Template]  Realizar Recarga

    {"valor": 10,"idOperadora": 2098,"DDD": 11,"numero": "123456789","numeroCartao": "982806069885","tipoOrigemPagamento": "Cartão"}     True  

#Realizar uma recarga com valor inválido
Recarga com Valor Inválido
    [Template]  Realizar Recarga

    {"valor": 1000,"idOperadora": 2098,"DDD": 11,"numero": "123456789","numeroCartao": "982806069885","tipoOrigemPagamento": "Cartão"}     True  

#Realizar uma recarga com operadora inválida
Recarga com Operadora Inválido
    [Template]  Realizar Recarga

    {"valor": 10,"idOperadora": 1000,"DDD": 11,"numero": "012345678","numeroCartao": "982806069885","tipoOrigemPagamento": "Cartão"}     True 

#Realizar uma recarga com telefone inválido
Recarga de um Telefone Inválido
    [Template]  Realizar Recarga

    {"valor": 10,"idOperadora": 2098,"DDD": 11,"numero": "012345678","numeroCartao": "982806069885","tipoOrigemPagamento": "Cartão"}     True  

#Realizar uma recarga com ddd inválida
Recarga com DDD Inválido
    [Template]  Realizar Recarga

    {"valor": 10,"idOperadora": 1000,"DDD": 110,"numero": "012345678","numeroCartao": "982806069885","tipoOrigemPagamento": "Cartão"}     False

#Realizar uma recarga com cartão inválido
Recarga com Cartão Inválido
    [Template]  Realizar Recarga

    {"valor": 10,"idOperadora": 1000,"DDD": 11,"numero": "012345678","numeroCartao": "988703321246","tipoOrigemPagamento": "Cartão"}     False

#Realizar uma recarga sem saldo
Recarga com Cartão Sem Saldo
    [Template]  Realizar Recarga

    {"valor": 10,"idOperadora": 1000,"DDD": 11,"numero": "012345678","numeroCartao": "982806069885","tipoOrigemPagamento": "PrePago"}     False     