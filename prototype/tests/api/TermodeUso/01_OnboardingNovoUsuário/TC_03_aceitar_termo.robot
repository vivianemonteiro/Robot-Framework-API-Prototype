*** Settings ***
Resource     ../../../../resources/services.robot

Test Setup    Create Session    hook    ${base_url}    verify=${True}

*** Test Cases ***

#Aceitar um termo que não está mais vigente
Aceitar Termo Obsoleto

    ${user_id}=    Get User Token    username    password    

    ${payload}=    Convert To Json    {"idsTermosUso": [1],"idDispositivo": "123456","enderecoIP": "82.82.1.90","latitude": "-17.72330280","longitude": "-48.62605490","versaoApp": "1.26.16"}

    ${resp}=    Aceite de Termos e Política    ${user_id}    ${payload}

    Should Be Equal As Strings    ${resp.status_code}                200
    Should Be Equal As Strings    ${resp.json().get("isSucesso")}    False 
    Should Be Equal As Strings    ${resp.text}  {"isSucesso":false,"erros":[{"codigo":1,"mensagem":"O Termo de Uso foi atualizado. Por favor tente novamente."}]}

#Aceitar uma Política que não está mais vigente
Aceitar Política Obsoleta

    ${user_id}=    Get User Token    username    password    

    ${payload}=    Convert To Json    {"idsTermosUso": [2],"idDispositivo": "123456","enderecoIP": "82.82.1.90","latitude": "-17.72330280","longitude": "-48.62605490","versaoApp": "1.26.16"}

    ${resp}=    Aceite de Termos e Política    ${user_id}    ${payload}
   
    Should Be Equal As Strings    ${resp.status_code}                200
    Should Be Equal As Strings    ${resp.json().get("isSucesso")}    False
    Should Be Equal As Strings    ${resp.text}      {"isSucesso":false,"erros":[{"codigo":1,"mensagem":"Política de Privacidade foi atualizada. Por favor tente novamente."}]}

#Aceitar um termo de uso
Aceitar Termo de Uso

    ${user_id}=    Get User Token    username    password    

    ${payload}=    Convert To Json    {"idsTermosUso": [4],"idDispositivo": "123456","enderecoIP": "82.82.1.90","latitude": "-17.72330280","longitude": "-48.62605490","versaoApp": "1.26.16"}

    ${resp}=    Aceite de Termos e Política    ${user_id}    ${payload}

    Should Be Equal As Strings    ${resp.status_code}                200
    Should Be Equal As Strings    ${resp.json().get("isSucesso")}    True 
    Should Be Equal As Strings    ${resp.text}      {"isSucesso":true}

#Aceitar uma politica de privacidade
Aceitar Política de Privacidade

    ${user_id}=    Get User Token    username    password    

    ${payload}=    Convert To Json    {"idsTermosUso": [3],"idDispositivo": "123456","enderecoIP": "82.82.1.90","latitude":"-17.72330280","longitude": "-48.62605490","versaoApp": "1.16.26"}    

    ${resp}=    Aceite de Termos e Política    ${user_id}    ${payload}

    Should Be Equal As Strings    ${resp.status_code}                200
    Should Be Equal As Strings    ${resp.json().get("isSucesso")}    True 
    Should Be Equal As Strings    ${resp.text}      {"isSucesso":true}

#Aceitar um Termo sem informar a latitude
Aceitar Termo de Uso sem Informar a Latitude

    ${user_id}=    Get User Token    username    password    

    ${payload}=    Convert To Json    {"idsTermosUso": [4],"idDispositivo": "123456","enderecoIP": "82.82.1.90","longitude": "-48.62605490","versaoApp": "1.16.26"}    

    ${resp}=    Aceite de Termos e Política    ${user_id}    ${payload}

    Should Be Equal As Strings    ${resp.status_code}                200
    Should Be Equal As Strings    ${resp.json().get("isSucesso")}    True 
    Should Be Equal As Strings    ${resp.text}      {"isSucesso":true}

#Aceitar uma política de privacidade sem informar a latitude
Aceitar Politica de Privacidade sem Informar a Latitude

    ${user_id}=    Get User Token    username    password    

    ${payload}=    Convert To Json    {"idsTermosUso": [3],"idDispositivo": "123456","enderecoIP": "82.82.6.90","longitude": "-48.62605490","versaoApp": "1.16.26"}    

    ${resp}=    Aceite de Termos e Política    ${user_id}    ${payload}

    Should Be Equal As Strings    ${resp.status_code}                200
    Should Be Equal As Strings    ${resp.json().get("isSucesso")}    True 
    Should Be Equal As Strings    ${resp.text}      {"isSucesso":true}

#Aceitar um Termo sem informar a longitude
Aceitar Termo de Uso sem Informar a Longitude

    ${user_id}=    Get User Token    username    password    

    ${payload}=    Convert To Json    {"idsTermosUso": [4],"idDispositivo": "123456","enderecoIP": "82.82.90","latitude":"-17.72330280","versaoApp": "1.26.16"}    

    ${resp}=    Aceite de Termos e Política    ${user_id}    ${payload}

    Should Be Equal As Strings    ${resp.status_code}                200
    Should Be Equal As Strings    ${resp.json().get("isSucesso")}    True 
    Should Be Equal As Strings    ${resp.text}      {"isSucesso":true}

#Aceitar uma política de privacidade sem informar a longitude
Aceitar Política de Privacidade sem Informar a Longitude
    
    ${user_id}=    Get User Token    username    password    

    ${payload}=    Convert To Json    {"idsTermosUso": [3],"idDispositivo": "123456","enderecoIP": "82.82.90","latitude":"-17.72330280","versaoApp": "1.26.16"}

    ${resp}=    Aceite de Termos e Política    ${user_id}    ${payload}

    Should Be Equal As Strings    ${resp.status_code}                200
    Should Be Equal As Strings    ${resp.json().get("isSucesso")}    True 
    Should Be Equal As Strings    ${resp.text}      {"isSucesso":true}

#Aceitar Termo de Uso sem informar o id do termo
Aceitar Termo ou Política Informar sem o Id
    
    ${user_id}=    Get User Token    username    password    

    ${payload}=    Convert To Json    {"idsTermosUso": [],"idDispositivo": "123456","enderecoIP": "82.82.1.90","latitude": "-17.72330280","longitude": "-48.62605490","versaoApp": "1.26.16"} 

    ${resp}=    Aceite de Termos e Política    ${user_id}    ${payload}

    Should Be Equal As Strings    ${resp.status_code}                200
    Should Be Equal As Strings    ${resp.json().get("isSucesso")}    False 
    Should Be Equal As Strings    ${resp.text}                       {"isSucesso":false,"erros":[{"codigo":1,"mensagem":"É necessário informar ao menos um termo de uso ou política de privacidade válido."}]}

#Aceitar um Termo de Uso sem informar o Id do dispositivo
Aceitar Termo de Uso sem Informar o Id do Dispositivo
    
    ${user_id}=    Get User Token    username    password    

    ${payload}=    Convert To Json    {"idsTermosUso": [4],"enderecoIP": "82.82.1.90","latitude": "-17.72330280","longitude": "-48.62605490","versaoApp": "1.26.16"}    

    ${resp}=    Aceite de Termos e Política    ${user_id}    ${payload}

    Should Be Equal As Strings    ${resp.status_code}                200
    Should Be Equal As Strings    ${resp.json().get("isSucesso")}    False
    Should Be Equal As Strings    ${resp.text}                       {"isSucesso":false,"erros":[{"codigo":0,"mensagem":"Campo IdDispositivo é obrigatório"}]}

#Aceitar uma Política de Uso sem informar o Id do dispositivo
Aceitar Política de Privacidade sem Informar o Id do Dispositivo

    ${user_id}=    Get User Token    username    password    

    ${payload}=    Convert To Json    {"idsTermosUso": [3],"enderecoIP": "82.82.1.90","latitude": "-17.72330280","longitude": "-48.62605490","versaoApp": "1.26.16"}    

    ${resp}=    Aceite de Termos e Política    ${user_id}    ${payload}

    Should Be Equal As Strings    ${resp.status_code}                200
    Should Be Equal As Strings    ${resp.json().get("isSucesso")}    False 
    Should Be Equal As Strings    ${resp.text}                       {"isSucesso":false,"erros":[{"codigo":0,"mensagem":"Campo IdDispositivo é obrigatório"}]}

#Aceitar um Termo sem informar o endereço de IP
Aceitar Termo de Uso sem Informar o Endereço de IP

    ${user_id}=    Get User Token    username    password    

    ${payload}=    Convert To Json    {"idsTermosUso": [4],"idDispositivo": "123456","latitude":"-17.72330280","longitude": "-48.62605490","versaoApp": "1.16.26"}    

    ${resp}=    Aceite de Termos e Política    ${user_id}    ${payload}
   
    Should Be Equal As Strings    ${resp.status_code}                200
    Should Be Equal As Strings    ${resp.json().get("isSucesso")}    False 
    Should Be Equal As Strings    ${resp.text}                       {"isSucesso":false,"erros":[{"codigo":0,"mensagem":"Campo EnderecoIP é obrigatório"}]}

#Aceitar uma Política de Privacidade sem informar o endereço de IP
Aceitar Política de Privacidade sem Informar o Endereço de IP

    ${user_id}=    Get User Token    username    password    

    ${payload}=    Convert To Json    {"idsTermosUso": [3],"idDispositivo": "123456","latitude":"-17.72330280","longitude": "-48.62605490","versaoApp": "1.16.26"}    

    ${resp}=    Aceite de Termos e Política    ${user_id}    ${payload}
    
    Should Be Equal As Strings    ${resp.status_code}                200
    Should Be Equal As Strings    ${resp.json().get("isSucesso")}    False 
    Should Be Equal As Strings    ${resp.text}                       {"isSucesso":false,"erros":[{"codigo":0,"mensagem":"Campo EnderecoIP é obrigatório"}]}

#Aceitar um Termo de Uso com Id inválido
Aceitar Termo de Uso Informando um Id Inválido

    ${user_id}=    Get User Token    username    password    

    ${payload}=    Convert To Json    {"idsTermosUso": ["abc"],"idDispositivo": "123456","enderecoIP": "82.82.90","latitude":"-17.72330280","longitude": "-48.62605490","versaoApp": "1.16.26"}    

    ${resp}=    Aceite de Termos e Política    ${user_id}    ${payload}

    Should Be Equal As Strings    ${resp.status_code}                200
    Should Be Equal As Strings    ${resp.json().get("isSucesso")}    False
    Should Be Equal As Strings    ${resp.text}                       {"isSucesso":false,"erros":[{"codigo":0,"mensagem":"Erro no campo termosAceitos.idsTermosUso[0]. Verifique o valor informado"}]}

#Aceitar um Termo de Uso com Id inexistente
Aceitar Termo de Uso Informando um Id Inexistente

    ${user_id}=    Get User Token    username    password    

    ${payload}=    Convert To Json    {"idsTermosUso": [1000],"idDispositivo": "123456","enderecoIP": "82.82.90","latitude":"-17.72330280","longitude": "-48.62605490","versaoApp": "1.16.26"}    

    ${resp}=    Aceite de Termos e Política    ${user_id}    ${payload}

    Should Be Equal As Strings    ${resp.status_code}                200
    Should Be Equal As Strings    ${resp.json().get("isSucesso")}    False
    Should Be Equal As Strings    ${resp.text}                       {"isSucesso":false,"erros":[{"codigo":1,"mensagem":"É necessário informar ao menos um termo de uso ou política de privacidade válido."}]}

#Aceitar um Termo de uso Sem informar a versão do app
Aceitar Termo de Uso sem Informar a Versão do App

    ${user_id}=    Get User Token    username    password    

    ${payload}=    Convert To Json    {"idsTermosUso": [4],"idDispositivo": "123456","enderecoIP": "82.82.90","latitude":"-17.72330280","longitude": 0}    

    ${resp}=    Aceite de Termos e Política    ${user_id}    ${payload}

    Should Be Equal As Strings    ${resp.status_code}                200
    Should Be Equal As Strings    ${resp.json().get("isSucesso")}    False 
    Should Be Equal As Strings    ${resp.text}                       {"isSucesso":false,"erros":[{"codigo":0,"mensagem":"Campo VersaoApp é obrigatório"}]}

#Aceitar uma Política de Privacidade sem informar a versão do app
Aceitar Política de Privacidade sem Informar a Versão do App

    ${user_id}=    Get User Token    username    password    

    ${payload}=    Convert To Json    {"idsTermosUso": [3],"idDispositivo": "123456","enderecoIP": "82.82.90","latitude":"-17.72330280","longitude": 0} 

    ${resp}=    Aceite de Termos e Política    ${user_id}    ${payload}

    Should Be Equal As Strings    ${resp.status_code}                200
    Should Be Equal As Strings    ${resp.json().get("isSucesso")}    False 
    Should Be Equal As Strings    ${resp.text}                       {"isSucesso":false,"erros":[{"codigo":0,"mensagem":"Campo VersaoApp é obrigatório"}]}

#Informar uma latitude inválida
Aceitar Termo de Uso Informando uma Latitude Inválida

    ${user_id}=    Get User Token    username    password    

    ${payload}=    Convert To Json    {"idsTermosUso": [4],"idDispositivo": "123456", "enderecoIP": "82.82.1.90","latitude": "-23526468", "longitude": "-48.62605490","versaoApp": "1.26.16"}

    ${resp}=    Aceite de Termos e Política    ${user_id}    ${payload}

    Should Be Equal As Strings    ${resp.status_code}                200
    Should Be Equal As Strings    ${resp.json().get("isSucesso")}    False 
    Should Be Equal As Strings    ${resp.text}                       {"isSucesso":false,"erros":[{"codigo":0,"mensagem":"Campo Latitude deve ser entre -99,99999999 e 99,99999999"}]}

#Informar uma latitude inválida
Aceitar Política de Privacidade Informando uma Latitude Inválida

    ${user_id}=    Get User Token    username    password    

    ${payload}=    Convert To Json    {"idsTermosUso": [3],"idDispositivo": "123456", "enderecoIP": "82.82.1.90","latitude": "-23526468", "longitude": "-48.62605490","versaoApp": "1.26.16"}

    ${resp}=    Aceite de Termos e Política    ${user_id}    ${payload}

    Should Be Equal As Strings    ${resp.status_code}                200
    Should Be Equal As Strings    ${resp.json().get("isSucesso")}    False 
    Should Be Equal As Strings    ${resp.text}                       {"isSucesso":false,"erros":[{"codigo":0,"mensagem":"Campo Latitude deve ser entre -99,99999999 e 99,99999999"}]}

#Informar uma Longitude inválida
Aceitar Termo de Uso Informando uma Logitude Inválida

    ${user_id}=    Get User Token    username    password    

    ${payload}=    Convert To Json    {"idsTermosUso": [4],"idDispositivo": "123456", "enderecoIP": "82.82.1.90","latitude": "-17.72330280", "longitude": "-46811296,6785","versaoApp": "1.26.16"}

    ${resp}=    Aceite de Termos e Política    ${user_id}    ${payload}

    Should Be Equal As Strings    ${resp.status_code}                200
    Should Be Equal As Strings    ${resp.json().get("isSucesso")}    False 
    Should Be Equal As Strings    ${resp.text}                       {"isSucesso":false,"erros":[{"codigo":0,"mensagem":"Campo Longitude deve ser entre -99,99999999 e 99,99999999"}]}

#Informar uma Longitude inválida
Aceitar Política de Privacidade Informando uma Logitude Inválida

    ${user_id}=    Get User Token    username    password    

    ${payload}=    Convert To Json    {"idsTermosUso": [3],"idDispositivo": "123456", "enderecoIP": "82.82.1.90","latitude": "-17.72330280", "longitude": "-46811296,6785","versaoApp": "1.26.16"}

    ${resp}=    Aceite de Termos e Política    ${user_id}    ${payload}

    Should Be Equal As Strings    ${resp.status_code}                200
    Should Be Equal As Strings    ${resp.json().get("isSucesso")}    False 
    Should Be Equal As Strings    ${resp.text}                       {"isSucesso":false,"erros":[{"codigo":0,"mensagem":"Campo Longitude deve ser entre -99,99999999 e 99,99999999"}]}

#Enviar uma requisição vazia
Aceitar Termos sem Enviar as Informações

    ${user_id}=    Get User Token    username    password    

    ${payload}=    Convert To Json    {}    

    ${resp}=    Aceite de Termos e Política    ${user_id}    ${payload}

    Should Be Equal As Strings    ${resp.status_code}                200
    Should Be Equal As Strings    ${resp.json().get("isSucesso")}    False 
    Should Be Equal As Strings    ${resp.text}                       {"isSucesso":false,"erros":[{"codigo":0,"mensagem":"Campo IdsTermosUso é obrigatório"},{"codigo":0,"mensagem":"Campo IdDispositivo é obrigatório"},{"codigo":0,"mensagem":"Campo EnderecoIP é obrigatório"},{"codigo":0,"mensagem":"Campo VersaoApp é obrigatório"}]}

#Retorna erro, uma vez que o usuário não foi informado
Aceitar Termos para um Usuário Inválido

    ${user_id}=    Get User Token    ${EMPTY}    password    

    ${payload}=    Convert To Json    {"idsTermosUso": [4],"idDispositivo": "string","enderecoIP": "string","latitude":"-17.72330280","longitude": "-48.62605490","versaoApp": "1.16.26"}

    ${resp}=    Aceite de Termos e Política    ${user_id}    ${payload}

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}

#Retorna erro, uma vez que a senha não foi informada
Aceitar Termos para um Usuário com Senha Inválida

    ${user_id}=    Get User Token    username    ${EMPTY}    

    ${payload}=    Convert To Json    {"idsTermosUso": [4],"idDispositivo": "string","enderecoIP": "string","latitude":"-17.72330280","longitude": "-48.62605490","versaoApp": "1.16.26"}

    ${resp}=    Aceite de Termos e Política    ${user_id}    ${payload}

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}

#Retorna erro, uma vez que o login não foi realizado com sucesso
Aceitar Termos para um Usuário com Login Inválido

    ${user_id}=    Get User Token    ${EMPTY}    ${EMPTY}    

    ${payload}=    Convert To Json    {"idsTermosUso": [4],"idDispositivo": "string","enderecoIP": "string","latitude":"-17.72330280","longitude": "-48.62605490","versaoApp": "1.16.26"}

    ${resp}=    Aceite de Termos e Política    ${user_id}    ${payload}

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}

#Retorna erro, uma vez que o usuário não foi informado
Aceitar Política para um Usuário Inválido

    ${user_id}=    Get User Token    ${EMPTY}    password    

    ${payload}=    Convert To Json    {"idsTermosUso": [3],"idDispositivo": "string","enderecoIP": "string","latitude":"-17.72330280","longitude": "-48.62605490","versaoApp": "1.16.26"}

    ${resp}=    Aceite de Termos e Política    ${user_id}    ${payload}

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}

#Retorna erro, uma vez que a senha não foi informada
Aceitar Política para um Usuário com Senha Inválida

    ${user_id}=    Get User Token    username    ${EMPTY}    

    ${payload}=    Convert To Json    {"idsTermosUso": [3],"idDispositivo": "string","enderecoIP": "string","latitude":"-17.72330280","longitude": "-48.62605490","versaoApp": "1.16.26"}

    ${resp}=    Aceite de Termos e Política    ${user_id}    ${payload}

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}

#Retorna erro, uma vez que o login não foi realizado com sucesso
Aceitar Política para um Usuário com Login Inválido

    ${user_id}=    Get User Token    ${EMPTY}    ${EMPTY}    

    ${payload}=    Convert To Json    {"idsTermosUso": [3],"idDispositivo": "string","enderecoIP": "string","latitude":"-17.72330280","longitude": "-48.62605490","versaoApp": "1.16.26"}

    ${resp}=    Aceite de Termos e Política    ${user_id}    ${payload}

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}

# #Informar uma versão do App abaixo da mínima permitida
# Aceitar Termo de Uso em uma Versão de App abaixo da Mínima
#    ${user_id}=    Get User Token    username    password    

#    ${payload}=    Convert To Json    {"idsTermosUso": [4],"idDispositivo": "123456","enderecoIP": "8282.90","latitude":"-17.72330280","longitude": "-48.62605490","versaoApp": "1.26.16"}

#    ${resp}=    Aceite de Termos e Política    ${user_id}    ${payload}

#    Log                           ${resp.text}
#    Should Be Equal As Strings    ${resp.status_code}                200
#    Should Be Equal As Strings    ${resp.json().get("isSucesso")}    False 

# #Informar uma versão do App abaixo da mínima permitida
# Aceitar Política de Privacidade em uma Versão de App abaixo da Mínima
#    ${user_id}=    Get User Token    username    password    

#    ${payload}=    Convert To Json    {"idsTermosUso": [3],"idDispositivo": "123456","enderecoIP": "82.82.90","latitude":"-17.72330280","longitude": "-48.62605490","versaoApp": "1.16.26"}

#    ${resp}=    Aceite de Termos e Política    ${user_id}    ${payload}

#    Log                           ${resp.text}
#    Should Be Equal As Strings    ${resp.status_code}                200
#    Should Be Equal As Strings    ${resp.json().get("isSucesso")}    False 

