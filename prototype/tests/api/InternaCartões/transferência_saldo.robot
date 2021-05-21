*** Settings ***
Resource    ../../../resources/services.robot

Test Setup    Create Session    hook    ${base_url}    verify=${True}

*** Test Cases ***

#Realizar uma transfrência saldo para Visa do próprio usuário
Transferência para Visa
    
    [Template]  Realizar Transferências Múltiplas

    {"tipoSaldoOrigem": ", "valorTotalSacado": 10,"destinos": [{"tipoDestino": "SaldoPrePago", "valorTransferencia": 10, "valorTarifa": 0, "numeroCartaoDestino": "982806069885"}]}    True  

#Realizar uma transferência saldo para conta corrente do próprio usuário
Transferência para Conta Corrente
   
    [Template]  Realizar Transferências Múltiplas

#Realizar uma transferência saldo para Visa e conta corrente do próprio usuário
Transferência para Visa e Conta Corrente
    
    [Template]  Realizar Transferências Múltiplas

#Realizar uma transferência saldo Visa para do próprio usuário
Transferência Visa para    
    [Template]  Realizar Transferências Múltiplas

#Realizar uma transferência saldo Visa para e  conta corrente do próprio usuário
Transferência Visa para e Conta Corrente
   
    [Template]  Realizar Transferências Múltiplas

#Realizar uma transferência saldo Visa para conta corrente do próprio usuário
Transferência Visa para Conta Corrente
    
    [Template]  Realizar Transferências Múltiplas

#Realizar uma transferência saldo para saldo de outra pessoa
Transferência para de Terceiro
    
    [Template]  Realizar Transferências Múltiplas

    {"tipoSaldoOrigem": ", "valorTotalSacado": 10, "destinos": [{"tipoDestino": "Saldo, "valorTransferencia": 10, "valorTarifa": 0, "numeroCartaoDestino": "card_number"}]}   True

#Realizar uma transferência saldo para saldo Pre Pago de outra pessoa
Transferência para Visa de Terceiro
    
    [Template]  Realizar Transferências Múltiplas
   
    {"tipoSaldoOrigem": ", "valorTotalSacado": 10, "destinos": [{"tipoDestino": "SaldoPrePago", "valorTransferencia": 10, "valorTarifa": 0, "numeroCartaoDestino": "card_number"}]}   True

#Realizar uma transferência saldo para conta corrente de outra pessoa
Transferência para Conta Corrente de Terceiro
    
    [Template]  Realizar Transferências Múltiplas

    {"tipoSaldoOrigem": ", "valorTotalSacado": 10, "destinos": [{"tipoDestino": "Saldo, "valorTransferencia": 10, "valorTarifa": 0, "numeroCartaoDestino": "card_number"}]}   True

#Realizar uma transferência saldo para saldo e conta corrente de outra pessoa
Transferência para e Conta Corrente de Terceiro
    
    [Template]  Realizar Transferências Múltiplas

    {"tipoSaldoOrigem": ", "valorTotalSacado": 10, "destinos": [{"tipoDestino": "Saldo, "valorTransferencia": 10, "valorTarifa": 0, "numeroCartaoDestino": "card_number"}]}   True

#Realizar uma transferência saldo para saldo Visa e conta corrente de outra pessoa
Transferência para Visa e Corrente Corrente de Terceiro
    
    [Template]  Realizar Transferências Múltiplas

    {"tipoSaldoOrigem": ", "valorTotalSacado": 10, "destinos": [{"tipoDestino": "Saldo, "valorTransferencia": 10, "valorTarifa": 0, "numeroCartaoDestino": "card_number"}]}   True

#Realizar uma transferência saldo Visa para saldo de outra pessoa
Transferência Visa para de Terceiro
    
    [Template]  Realizar Transferências Múltiplas

    {"tipoSaldoOrigem": ", "valorTotalSacado": 10, "destinos": [{"tipoDestino": "Saldo, "valorTransferencia": 10, "valorTarifa": 0, "numeroCartaoDestino": "card_number"}]}   True

#Realizar uma transferência saldo Visa para saldo Visa de outra pessoa
Transferência Visa para Visa de Terceiro
    
    [Template]  Realizar Transferências Múltiplas

    {"tipoSaldoOrigem": ", "valorTotalSacado": 10, "destinos": [{"tipoDestino": "Saldo, "valorTransferencia": 10, "valorTarifa": 0, "numeroCartaoDestino": "card_number"}]}   True

#Realizar uma transferência saldo Visa para saldo Visa e conta corrente de outra pessoa
Transferência Visa para Visa e Conta Corrente de Terceiro
    
    [Template]  Realizar Transferências Múltiplas

    {"tipoSaldoOrigem": ", "valorTotalSacado": 10, "destinos": [{"tipoDestino": "Saldo, "valorTransferencia": 10, "valorTarifa": 0, "numeroCartaoDestino": "card_number"}]}   True

#Realizar uma transferência saldo Visa para saldo e conta corrente de outra pessoa
Transferência Visa para e Conta Corrente de Terceiro
  
    [Template]  Realizar Transferências Múltiplas

    {"tipoSaldoOrigem": ", "valorTotalSacado": 10, "destinos": [{"tipoDestino": "Saldo, "valorTransferencia": 10, "valorTarifa": 0, "numeroCartaoDestino": "card_number"}]}   True

#Realizar uma transferência saldo Visa para conta corrente de outra pessoa
Transferência Visa para Conta Corrente de Terceiro

    [Template]  Realizar Transferências Múltiplas

    {"tipoSaldoOrigem": ", "valorTotalSacado": 10, "destinos": [{"tipoDestino": "Saldo, "valorTransferencia": 10, "valorTarifa": 0, "numeroCartaoDestino": "card_number"}]}   True

#Realizar uma transferência saldo para saldo de outra pessoa e conta corrente do usuário
Transferência para de Terceiro e Conta Corrente do Usuário
   
    [Template]  Realizar Transferências Múltiplas

    {"tipoSaldoOrigem": ", "valorTotalSacado": 10, "destinos": [{"tipoDestino": "Saldo, "valorTransferencia": 10, "valorTarifa": 0, "numeroCartaoDestino": "card_number"}]}   True

#Realizar uma transferência saldo para saldo e de outra pessoa
Transferência para de Terceiro
    [Template]  Realizar Transferências Múltiplas

    {"tipoSaldoOrigem": ", "valorTotalSacado": 10, "destinos": [{"tipoDestino": "Saldo, "valorTransferencia": 10, "valorTarifa": 0, "numeroCartaoDestino": "card_number"}]}   True
