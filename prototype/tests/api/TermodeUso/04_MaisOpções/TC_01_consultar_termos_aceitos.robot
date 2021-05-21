
*** Settings ***
Resource    ../../../../resources/services.robot

Test Setup    Create Session    hook    ${base_url}    verify=${True}


*** Test Cases ***

#Retorna os termos de uso aceito pelo usuário logado
Consultar Termos Aceitos Pelo Usuário Logado
   
    ${user_id}=    Get User Token    username    password    

    ${resp}=    Consultar Termos Aceitos    ${user_id}      /TermoUso 

    Should Be Equal As Strings    ${resp.status_code}    200
    Log To Console    ${resp.text}        

#Retorna a politica de privacidade aceita pelo usuário logado
Consultar Política de Privacidade Aceito Pelo Usuário Logado
   
    ${user_id}=    Get User Token    username    password    

    ${resp}=    Consultar Termos Aceitos    ${user_id}      /PoliticaPrivacidade 

    Should Be Equal As Strings    ${resp.status_code}    200
    Log To Console    ${resp.text}    

#Retorna erro ao não informar o tipo de termo ou de privacidade aceita pelo usuário logado
Consultar Termos Aceitos Informando um Tipo Inválido
   
    ${user_id}=    Get User Token    username    password    

    ${resp}=    Consultar Termos Aceitos    ${user_id}      /QualquerUm

    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.text}      {"isSucesso":false,"erros":[{"codigo":0,"mensagem":"O valor informado no campo 'tipoTermo' não é válido"}]}


#Retorna erro ao não informar o usuário
Consultar Termo para um Usuário Inválido
   
    ${user_id}=    Get User Token    ${EMPTY}    password    

    ${resp}=    Consultar Termos Aceitos    ${user_id}    /TermoUso

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}

#Retorna erro ao não informar a senha de login
Consultar Termo Sem Informar a Senha do Usuário
    
    ${user_id}=    Get User Token    username    ${EMPTY}    

    ${resp}=    Consultar Termos Aceitos    ${user_id}    /TermoUso

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}

#Retorna erro ao não informar os campos de login
Consultar Termo Sem Informar um Login
   
    ${user_id}=    Get User Token    ${EMPTY}    ${EMPTY}

    ${resp}=    Consultar Termos Aceitos    ${user_id}    /TermoUso

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}


#Retorna erro ao não informar o usuário
Consultar Política para um Usuário Inválido
   
    ${user_id}=    Get User Token    ${EMPTY}    password    

    ${resp}=    Consultar Termos Aceitos    ${user_id}    /PoliticaPrivacidade

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}

#Retorna erro ao não informar a senha de login
Consultar Política Sem Informar a Senha do Usuário
    
    ${user_id}=    Get User Token    username    ${EMPTY}    

    ${resp}=    Consultar Termos Aceitos    ${user_id}    /PoliticaPrivacidade

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}

#Retorna erro ao não informar os campos de login
Consultar Política Sem Informar um Login
   
    ${user_id}=    Get User Token    ${EMPTY}    ${EMPTY}

    ${resp}=    Consultar Termos Aceitos    ${user_id}    /PoliticaPrivacidade

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}
