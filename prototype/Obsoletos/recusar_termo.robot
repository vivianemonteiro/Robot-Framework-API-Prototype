*** Settings ***
Resource    ../../../resources/services.robot

Test Setup    Create Session    hook    ${base_url}    verify=${True}

*** Test Cases ***
#Recusar um termo de uso
Recusar Termo de Uso
    ${user_id}=    Get User Token    username    password    

    ${payload}=    Convert To Json    [{"idTermoUso": 1,"tipoTermo": "TermoUso"}]

    ${resp}=    Recusar de Termos e Política    ${user_id}    ${payload}

    Should Be Equal As Strings    ${resp.status_code}                200
    Should Be Equal As Strings    ${resp.json().get("isSucesso")}    True 

#Recusar uma politica de privacidade
Recusar Política de Privacidade
    ${user_id}=    Get User Token    username    password    

    ${payload}=    Convert To Json    [{"idTermoUso": 2,"tipoTermo": "PoliticaPrivacidade"}]

    ${resp}=    Recusar de Termos e Política    ${user_id}    ${payload}

    Should Be Equal As Strings    ${resp.status_code}                200
    Should Be Equal As Strings    ${resp.json().get("isSucesso")}    True 

#Recusar um Termo com Id de Politica e vice-versa
Recusar Termo de Uso com ID de Política de Privacidade
    ${user_id}=    Get User Token    username    password    

    ${payload}=    Convert To Json    [{"idTermoUso": 2,"tipoTermo": "TermoUso"}]    

    ${resp}=    Recusar de Termos e Política    ${user_id}    ${payload}

    Should Be Equal As Strings    ${resp.status_code}                200
    Should Be Equal As Strings    ${resp.json().get("isSucesso")}    False 

#Recusar um Termo com Id de Politica e vice-versa
Recusar Política de Privacidade com ID de Termo de Uso
    ${user_id}=    Get User Token    username    password    

    ${payload}=    Convert To Json    [{"idTermoUso": 1,"tipoTermo": "PoliticaPrivacidade"}]    

    ${resp}=    Recusar de Termos e Política    ${user_id}    ${payload}

    Should Be Equal As Strings    ${resp.status_code}                200
    Should Be Equal As Strings    ${resp.json().get("isSucesso")}    False 

#Recusar Termo de Uso sem informar o id do termo
Recusar Termo de Uso sem Informar o Id
    ${user_id}=    Get User Token    username    password    

    ${payload}=    Convert To Json    [{"tipoTermo": "TermoUso"}] 

    ${resp}=    Recusar de Termos e Política    ${user_id}    ${payload}

    Should Be Equal As Strings    ${resp.status_code}                200
    Should Be Equal As Strings    ${resp.json().get("isSucesso")}    False 

#Recusar Política de Privacidade sem informar o id do termo
Recusar Política de Privacidade sem Informar o Id
    ${user_id}=    Get User Token    username    password    

    ${payload}=    Convert To Json    [{"tipoTermo": "PoliticaPrivacidade"}]    

    ${resp}=    Recusar de Termos e Política    ${user_id}    ${payload}

    Should Be Equal As Strings    ${resp.status_code}                200
    Should Be Equal As Strings    ${resp.json().get("isSucesso")}    False 

#Recusar Termo de Uso sem informar o tipo do termo
Recusar Termo de Uso sem Informar o Tipo
    ${user_id}=    Get User Token    username    password    

    ${payload}=    Convert To Json    [{"idTermoUso": 1}]    

    ${resp}=    Recusar de Termos e Política    ${user_id}    ${payload}

    Should Be Equal As Strings    ${resp.status_code}                200
    Should Be Equal As Strings    ${resp.json().get("isSucesso")}    False 

#Recusar Política de Privacidade sem informar o tipo do termo
Recusar Política de Privacidade sem Informar o Tipo
    ${user_id}=    Get User Token    username    password    

    ${payload}=    Convert To Json    [{"idTermoUso": 2}]    

    ${resp}=    Recusar de Termos e Política    ${user_id}    ${payload}

    Should Be Equal As Strings    ${resp.status_code}                200
    Should Be Equal As Strings    ${resp.json().get("isSucesso")}    False 



#Recusar um Termo de Uso com Id inválido
Recusar Termo de Uso Informando um Id Inválido
    ${user_id}=    Get User Token    username    password    

    ${payload}=    Convert To Json    [{"idTermoUso": "abc","tipoTermo": "TermoUso"}]    

    ${resp}=    Recusar de Termos e Política    ${user_id}    ${payload}

    Should Be Equal As Strings    ${resp.status_code}                200
    Should Be Equal As Strings    ${resp.json().get("isSucesso")}    False 

#Recusar uma Política de Privacidade com Id inválido
Recusar uma Política de Privacidade Informando um Id Inválido
    ${user_id}=    Get User Token    username    password    

    ${payload}=    Convert To Json    [{"idTermoUso": "def","tipoTermo": "PoliticaPrivacidade"}]    

    ${resp}=    Recusar de Termos e Política    ${user_id}    ${payload}

    Should Be Equal As Strings    ${resp.status_code}                200
    Should Be Equal As Strings    ${resp.json().get("isSucesso")}    False 


#Enviar uma requisição vazia
Recusar Termos sem Enviar as Informações
    ${user_id}=    Get User Token    username    password    

    ${payload}=    Convert To Json    [{ }]    

    ${resp}=    Recusar de Termos e Política    ${user_id}    ${payload}

    Should Be Equal As Strings    ${resp.status_code}                200
    Should Be Equal As Strings    ${resp.json().get("isSucesso")}    False 


#retorna erro, uma vez que o usuário não foi informado
Recusar Termos para um Usuário Inválido

    ${user_id}=    Get User Token    ${EMPTY}    password    
 
    ${payload}=    Convert To Json    [{"idTermoUso": 1,"tipoTermo": "TermoUso"}]
    
    ${resp}=    Recusar de Termos e Política    ${user_id}    ${payload}

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}

    Log    ${resp.text}

#retorna erro, uma vez que a senha não foi informada
Recusar Termos para um Usuário com Senha Inválida

    ${user_id}=    Get User Token    username    ${EMPTY}    

    ${payload}=    Convert To Json    [{"idTermoUso": 1,"tipoTermo": "TermoUso"}]
    
    ${resp}=    Recusar de Termos e Política    ${user_id}    ${payload}


    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}

    Log    ${resp.text}


#retorna erro, uma vez que o login não foi realizado com sucesso
Recusar Termos para um Usuário com Login Inválido

    ${user_id}=    Get User Token    ${EMPTY}    ${EMPTY}    

    ${payload}=    Convert To Json    [{"idTermoUso": 1,"tipoTermo": "TermoUso"}]
    
    ${resp}=    Recusar de Termos e Política    ${user_id}    ${payload}


    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}

    Log    ${resp.text}


