*** Settings ***
Resource    ../../../resources/services.robot

Test Setup    Create Session    hook    ${base_url}    verify=${True}

*** Test Cases ***

#Deleta um telefone usando o id de um telefone existente - sempre alterar o id do telefone para não dar erro!
Id de Telefone Válido

    ${user_id}=    Get User Token    username    password    

    ${resp}=    Deletar Telefone Favorito Válido    ${user_id}    133

    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.text}           {"isSucesso":true,"resultado":false}

#Deleta um telefone usando um id de telefone inexistente
Id de Telefone Inválido

    ${user_id}=    Get User Token    username    password    

    ${resp}=    Deletar Telefone Favorito Inválido    ${user_id}    117

    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.text}           {"isSucesso":false,"erros":[{"codigo":1,"mensagem":"Telefone não encontrado."}]}

#Deleta um telefone usando o id em branco
Id de Telefone em Branco

    ${user_id}=    Get User Token    username    password    

    ${resp}=    Deletar Telefone Favorito Válido    ${user_id}    ${EMPTY}

    Should Be Equal As Strings    ${resp.status_code}    405
    Should Be Equal As Strings    ${resp.text}           {"message":"The requested resource does not support http method 'DELETE'."}

#Deleta um telefone usando o id de outro usuário
Id de Telefone de outro usuário

    ${user_id}=    Get User Token    username    password    

    ${resp}=    Deletar Telefone Favorito Inválido    ${user_id}    119


    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.text}           {"isSucesso":false,"erros":[{"codigo":1,"mensagem":"Telefone não encontrado."}]}

#Retorna erro, uma vez que o usuário não foi informado
Deletar o Telefone de um Usuário Inválido

    ${user_id}=    Get User Token    ${EMPTY}    password    

    ${resp}=    Deletar Telefone Favorito Válido    ${user_id}    121

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}

#Retorna erro, uma vez que a senha não foi informada
Deletar o Telefone de um Usuário com Senha Inválida

    ${user_id}=    Get User Token    username    ${EMPTY}    

    ${resp}=    Deletar Telefone Favorito Válido    ${user_id}    121

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}

#Retorna erro, uma vez que o login não foi realizado com sucesso
Deletar o Telefone de um Usuário com Login Inválido

    ${user_id}=    Get User Token    ${EMPTY}    ${EMPTY}    

    ${resp}=    Deletar Telefone Favorito Válido    ${user_id}    121

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}

