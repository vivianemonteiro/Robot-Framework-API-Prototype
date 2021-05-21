*** Settings ***
Resource    ../../../resources/services.robot

Test Setup    Create Session    hook    ${base_url}    verify=${True}


*** Test Cases ***

#Retorna os dados bancários do motorista logado
Listar Dados Bancários Motorista
   
    ${user_id}=    Get User Token    username    password    

    ${resp}=    Dados Bancários do Motorista    ${user_id}    /username/BuscaDadosBancarios    

    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.text}           {"isSucesso":true,"resultado":{"codigoBanco":"033","agencia":"2332","agenciaDV":"4","conta":"12365","contaDV":"8","tipoConta":"Corrente"}}

#Retorna erro ao informar o CPF de outro motorista
Listar Dados Bancários de Outro Motorista
   
    ${user_id}=    Get User Token    username    password    

    ${resp}=    Dados Bancários do Motorista    ${user_id}    /username/BuscaDadosBancarios    

    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.text}           {"isSucesso":false,"erros":[{"codigo":1,"mensagem":"A pessoa para a qual se deseja exibir os dados bancários não foi encontrada ou o usuário logado não possui acesso à mesma."}]}

#Retorna erro ao informar um CPF inválido
Listar Dados Bancários Informando CPF Inválido
   
    ${user_id}=    Get User Token    username    password    

    ${resp}=    Dados Bancários do Motorista    ${user_id}    /invaliduser/BuscaDadosBancarios    

    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.text}           {"isSucesso":false,"erros":[{"codigo":1,"mensagem":"A pessoa para a qual se deseja exibir os dados bancários não foi encontrada ou o usuário logado não possui acesso à mesma."}]}

#Retorna erro ao não informar um CPF
Listar Dados Bancários Sem Informar um CPF
   
    ${user_id}=    Get User Token    username    password    

    ${resp}=    Dados Bancários do Motorista    ${user_id}    //BuscaDadosBancarios    

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}

#Retorna erro ao não informar o usuário
Listar Dados Bancários de um Usuário Inválido
  
    ${user_id}=    Get User Token    ${EMPTY}    password    

    ${resp}=    Dados Bancários do Motorista    ${user_id}    /username/BuscaDadosBancarios    

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}

#Retorna erro ao não informar a senha de login
Listar Dados Bancários Sem Informar a Senha do Usuário
  
    ${user_id}=    Get User Token    username    ${EMPTY}    

    ${resp}=    Dados Bancários do Motorista    ${user_id}    /username/BuscaDadosBancarios    

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}

#Retorna erro ao não informar os campos de login
Listar Dados Bancários Sem Informa um CPF
  
    ${user_id}=    Get User Token    ${EMPTY}    ${EMPTY}

    ${resp}=    Dados Bancários do Motorista    ${user_id}    /username/BuscaDadosBancarios    

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}
