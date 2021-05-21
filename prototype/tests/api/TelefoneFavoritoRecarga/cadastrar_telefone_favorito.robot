*** Settings ***
Resource    ../../../resources/services.robot

Test Setup    Create Session    hook    ${base_url}    verify=${True}


*** Test Cases ***

#Informar um telefone e ddd válidos
Telefone e DDD Válidos
    [Template]    Telefone Favorito

    {"numero": "994522287","DDD": "11"}    True     ${EMPTY}    ${EMPTY}
    {"numero": "994879889","DDD": "11"}    True     ${EMPTY}    ${EMPTY}
    
#Informar um telefone inválido e ddd válido
Telefone Inválido e DDD Válido
    [Template]    Telefone Favorito 

    {"numero": "91234567","DDD": "11"}    False    codigo: 0, mensagem: Campo Número do telefone deve ter 9 dígitos sem zeros à esquerda    ${EMPTY}

#Informar um telefone válido e ddd inválido
Telefone Válido e DDD Inválido
    [Template]    Telefone Favorito Inválido

    {"numero": "994522287","DDD": "101"}    False    codigo: 1, mensagem: Por favor, insira um DDD válido    ${EMPTY}

#Informar um telefone inválido e ddd inválido
Telefone e DDD Inválidos
    [Template]    Telefone Favorito 

    {"numero": "94561234","DDD": "300"}    False    codigo: 0, mensagem: Campo Número do telefone deve ter 9 dígitos sem zeros à esquerda    ${EMPTY}

#Informar um telefone iniciando com 0 e ddd válido
Telefone Iniciado com 0 e DDD Válido
    [Template]    Telefone Favorito

    {"numero": "045611234","DDD": "11"}    False    codigo: 0, mensagem: Campo Número do telefone não é um número de telefone válido    codigo: 0, mensagem: Campo Número do telefone deve ter 9 dígitos sem zeros à esquerda

#Informar um telefone iniciando com 0 e ddd inválido
Telefone Iniciando com 0 e DDD Inválido
    [Template]    Telefone Favorito 

    {"numero": "056121234","DDD": "300"}    False    codigo: 0, mensagem: Campo Número do telefone não é um número de telefone válido    codigo: 0, mensagem: Campo Número do telefone deve ter 9 dígitos sem zeros à esquerda