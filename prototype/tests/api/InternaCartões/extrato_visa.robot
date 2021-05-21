
*** Settings ***
Resource    ../../../resources/services.robot

Test Setup    Create Session    hook    ${base_url}    verify=${True}


*** Test Cases ***

#Retorna o extrato do cartão  informando número do cartão e o período válido
Consultar Extrato Válido

    ${user_id}=    Get User Token    username    password    

    ${resp}=    Extrato Cartão     ${user_id}    =card_number    =username    =2020-02-01    =2020-03-01

    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.text}           {"isSucesso":true,"resultado":{"numeroCartao":"card_number","produtoCartao":"2.0","dataInicial":"2020-02-01T00:00:00","dataFinal":"2020-03-01T00:00:00","detalhes":[]}}

#Retorna erro informando número do cartão de outro usuário
Consultar Extrato Informando o Cartão de Outro Usuário

    ${user_id}=    Get User Token    username    password    

    ${resp}=    Extrato Cartão     ${user_id}    =card_number    =username    =2020-02-01    =2020-03-01

    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.text}           {"isSucesso":false,"erros":[{"codigo":1,"mensagem":"Cartão card_number não cadastrado na base }]}    

#Retorna erro informando número do cartão de inválido
Consultar Extrato Informando o Cartão de Inválido

    ${user_id}=    Get User Token    username    password    

    ${resp}=    Extrato Cartão     ${user_id}    =123456789012    =username    =2020-02-01    =2020-03-01

    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.text}           {"isSucesso":false,"erros":[{"codigo":0,"mensagem":"Cartão 123456789012 não é um cartão válido"}]}    

#Retorna erro informando número do CPF inválido
Consultar Extrato Informando um CPF Inválido

    ${user_id}=    Get User Token    username    password    

    ${resp}=    Extrato Cartão     ${user_id}    =card_number    =12345678900    =2020-02-01    =2020-03-01

    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.text}           {"isSucesso":false,"erros":[{"codigo":0,"mensagem":"Campo CPFCNPJ deve ter um CNPJ ou CPF válido"}]}    


#Retorna erro informando número do cartão de outro usuário
Consultar Extrato Informando o CPF de Outro Usuário

    ${user_id}=    Get User Token    username    password    

    ${resp}=    Extrato Cartão     ${user_id}    =card_number    =user_id    =2020-02-01    =2020-03-01

    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.text}           {"isSucesso":false,"erros":[{"codigo":1,"mensagem":"Cartão não pertence ao CPF/CNPJ informado"}]}    

#Retorna erro informando número do cartão e cpf de outro usuário
Consultar Extrato Informando CPF e Cartão de Outro Usuário

    ${user_id}=    Get User Token    username    password    

    ${resp}=    Extrato Cartão     ${user_id}    =card_number    =user_id    =2020-02-01    =2020-03-01

    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.text}           {"isSucesso":false,"erros":[{"codigo":1,"mensagem":"Cartão card_number não cadastrado na base }]}    

#Retorna erro informando data de inicio inválida
Consultar Extrato com Data Inicial Inválida

    ${user_id}=    Get User Token    username    password    

    ${resp}=    Extrato Cartão     ${user_id}    =card_number    =username    =2020-01-32    =2020-03-01

    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.text}           {"isSucesso":false,"erros":[{"codigo":0,"mensagem":"O valor informado no campo 'DataInicial' não é válido"}]}    

#Retorna erro informando data final inválida
Consultar Extrato com Data Final Inválida

    ${user_id}=    Get User Token    username    password    

    ${resp}=    Extrato Cartão     ${user_id}    =card_number    =username    =2020-02-01    =2020-03-32

    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.text}           {"isSucesso":false,"erros":[{"codigo":0,"mensagem":"O valor informado no campo 'DataFinal' não é válido"}]} 

#Retorna erro informando data de inicio e final inválida
Consultar Extrato com Data Inicial e Final Inválida

    ${user_id}=    Get User Token    username    password    

    ${resp}=    Extrato Cartão     ${user_id}    =card_number    =username    =2020-01-32    =2020-03-32

    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.text}           {"isSucesso":false,"erros":[{"codigo":0,"mensagem":"O valor informado no campo 'DataInicial' não é válido"},{"codigo":0,"mensagem":"O valor informado no campo 'DataFinal' não é válido"}]} 

#Retorna erro ao não informar o número do cartão
Consultar Extrato sem Informar Número do Cartão

    ${user_id}=    Get User Token    username    password    

    ${resp}=    Extrato Cartão     ${user_id}    =${EMPTY}    =username    =2020-02-01    =2020-03-01

    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.text}           {"isSucesso":false,"erros":[{"codigo":0,"mensagem":"A value is required but was not present in the request."}]}

#Retorna erro ao não informar o número do CPF
Consultar Extrato sem Informar Número do CPF

    ${user_id}=    Get User Token    username    password    

    ${resp}=    Extrato Cartão     ${user_id}    =card_number    =${EMPTY}    =2020-02-01    =2020-03-01

    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.text}           {"isSucesso":false,"erros":[{"codigo":0,"mensagem":"A value is required but was not present in the request."}]}

#Retorna erro ao não informar data inicial
Consultar Extrato sem Informar Data Inicial

    ${user_id}=    Get User Token    username    password    

    ${resp}=    Extrato Cartão     ${user_id}    =card_number    =username    =${EMPTY}    =2020-03-01

    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.text}           {"isSucesso":false,"erros":[{"codigo":0,"mensagem":"A value is required but was not present in the request."}]}

#Retorna erro ao não informar data final
Consultar Extrato sem Informar Data Final

    ${user_id}=    Get User Token    username    password    

    ${resp}=    Extrato Cartão     ${user_id}    =card_number    =username    =2020-02-01    =${EMPTY}

    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.text}           {"isSucesso":false,"erros":[{"codigo":0,"mensagem":"A value is required but was not present in the request."}]}

#Retorna erro ao não informar os dados obrigatórios
Consultar Extrato sem Informar Dados Obrigatórios

    ${user_id}=    Get User Token    username    password    

    ${resp}=    Extrato Cartão     ${user_id}    =${EMPTY}    =${EMPTY}    =${EMPTY}    =${EMPTY}

    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.text}           {"isSucesso":false,"erros":[{"codigo":0,"mensagem":"A value is required but was not present in the request."}]}

#Retorna erro ao não informar o usuário
Consultar Extrato para um Usuário Inválido

    ${user_id}=    Get User Token    ${EMPTY}    password    

    ${resp}=    Extrato Cartão     ${user_id}    =card_number    =username    =2020-02-01    =2020-03-01

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}

#Retorna erro ao não informar a senha de login
Consultar Extrato Sem Informar a Senha do Usuário

    ${user_id}=    Get User Token    username    ${EMPTY}    

    ${resp}=    Extrato Cartão     ${user_id}    =card_number    =username    =2020-02-01    =2020-03-01

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}

#Retorna erro ao não informar os campos de login
Consultar Extrato Sem Informar um Login

    ${user_id}=    Get User Token    ${EMPTY}    ${EMPTY}

    ${resp}=    Extrato Cartão     ${user_id}    =card_number    =username    =2020-02-01    =2020-03-01

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}
