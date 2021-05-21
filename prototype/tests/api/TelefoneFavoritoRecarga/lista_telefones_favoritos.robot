*** Settings ***
Resource    ../../../resources/services.robot

Test Setup    Create Session    hook    ${base_url}    verify=${True}

*** Test Cases ***

#Retorna lista de telefones favoritos de um usuário que possui serviço de recarga (portador de cartão e usuário do app)
Lista de Telefones Favoritos Usuário Válido

    ${user_id}=    Get User Token    username    password    

    ${resp}=    Lista de Telefones Favoritos    ${user_id}

    Should Be Equal As Strings    ${resp.status_code}    200
    Log    ${resp.text}

#Tenta retornar lista de telefones favoritos para usuário que não possui serviço de recarga (portador de cartão e usuário do app)
Lista de Telefones Favoritos Usuário Sem Acesso

    ${user_id}=    Get User Token    username    password    

    ${resp}=    Lista de Telefones Favoritos Sem Permissão    ${user_id}

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}      {"message":"Authorization has been denied for this request."}

#Tenta retornar lista de telefones favoritos passando usuário em branco
Lista de Telefones Favoritos Usuário Inexistente

    ${user_id}=    Get User Token    ${EMPTY}      ${EMPTY}

    ${resp}=    Lista de Telefones Favoritos Sem Permissão    ${user_id}

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}      {"message":"Authorization has been denied for this request."}
