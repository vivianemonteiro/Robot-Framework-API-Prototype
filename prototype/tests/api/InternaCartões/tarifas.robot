
*** Settings ***
Resource    ../../../resources/services.robot

Test Setup    Create Session    hook    ${base_url}    verify=${True}


*** Test Cases ***

#Retorna o extrato do cartão informando número do cartão e o período válido
Consultar Extrato Válido
   
    ${user_id}=    Get User Token    username    password    

    ${resp}=    Consultar Tarifas     ${user_id}    
   
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.text}        {"isSucesso":true,"resultado":[{"idTarifa":11,"nomeTarifa":"Cartão - Emissão (1ª via)","tipoCobranca":"Sujeito às condições definidas pelo Embarcador / Transportador"},{"idTarifa":12,"nomeTarifa":"Cartão - Reemissão (2ª via)","tipoCobranca":"Sujeito às condições definidas pelo Embarcador / Transportador"},{"idTarifa":13,"nomeTarifa":"Cartão - Emissão de Adicional","valorTarifa":0.00,"tipoCobranca":"Evento"},{"idTarifa":21,"nomeTarifa":"Recarga Pagbem","valorTarifa":0.00,"tipoCobranca":"Evento"},{"idTarifa":31,"nomeTarifa":"Saque na Rede","valorTarifa":1.99,"tipoCobranca":"Sujeito a regra ANTT"},{"idTarifa":32,"nomeTarifa":"Outros serviços na Rede Credenciada","valorTarifa":0.00,"tipoCobranca":"Evento"},{"idTarifa":41,"nomeTarifa":"Saque na Tecban (Banco 24H)","valorTarifa":7.90,"tipoCobranca":"Evento"},{"idTarifa":52,"nomeTarifa":"Transferência Visa","valorTarifa":7.90,"tipoCobranca":"Evento"},{"idTarifa":53,"nomeTarifa":"Transferência Conta Corrente","valorTarifa":7.90,"tipoCobranca":"A cada R$ 1.500,00 - Sujeito a regra ANTT"},{"idTarifa":101,"nomeTarifa":"Manutenção do Cartão","valorTarifa":0.00,"tipoCobranca":"Mensal"}]}

#Retorna erro ao não informar o usuário
Consultar Extrato para um Usuário Inválido
   
    ${user_id}=    Get User Token    ${EMPTY}    password    

    ${resp}=    Consultar Tarifas                     ${user_id}  

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}

#Retorna erro ao não informar a senha de login
Consultar Extrato Sem Informar a Senha do Usuário
    
    ${user_id}=    Get User Token    username    ${EMPTY}    

    ${resp}=    Consultar Tarifas                     ${user_id}  

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}

#Retorna erro ao não informar os campos de login
Consultar Extrato Sem Informar um Login
   
    ${user_id}=    Get User Token    ${EMPTY}    ${EMPTY}

    ${resp}=    Consultar Tarifas                     ${user_id}   

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}
