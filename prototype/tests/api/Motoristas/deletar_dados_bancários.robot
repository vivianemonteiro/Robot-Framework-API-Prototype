*** Settings ***
Resource    ../../../resources/services.robot

Test Setup    Create Session    hook    ${base_url}    verify=${True}


*** Test Cases ***

#Deleta os dados bancários do motorista logado
Deletar Dados Bancários Motorista
   
    ${user_id}=    Get User Token    username    password    

    ${resp}=    Deletar Dados Bancários do Motorista    ${user_id}    /username/deletaDadosBancarios 

    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.text}           {"isSucesso":true}

#Retorna erro ao informar o CPF de outro motorista
Deletar Dados Bancários de Outro Motorista
   
    ${user_id}=    Get User Token    username    password    

    ${resp}=    Deletar Dados Bancários do Motorista    ${user_id}    /username/deletaDadosBancarios    

    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.text}           {"isSucesso":false,"erros":[{"codigo":1,"mensagem":"A pessoa para a qual se deseja excluir os dados bancários não foi encontrada ou o usuário logado não possui acesso à mesma."}]}

#Retorna erro ao informar um CPF inválido
Deletar Dados Bancários Informando CPF Inválido
   
    ${user_id}=    Get User Token    username    password    

    ${resp}=    Deletar Dados Bancários do Motorista    ${user_id}    /invaliduser/deletaDadosBancarios    

    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.text}           {"isSucesso":false,"erros":[{"codigo":1,"mensagem":"A pessoa para a qual se deseja excluir os dados bancários não foi encontrada ou o usuário logado não possui acesso à mesma."}]}

#Retorna erro ao não informar um CPF
Deletar Dados Bancários Sem Informar um CPF
   
    ${user_id}=    Get User Token    username    password    

    ${resp}=    Deletar Dados Bancários do Motorista    ${user_id}    //deletaDadosBancarios    

    Should Be Equal As Strings    ${resp.status_code}    405
    Should Be Equal As Strings    ${resp.text}          {"message":"The requested resource does not support http method 'DELETE'."}

#Retorna erro ao não informar o usuário
Deletar Dados Bancários de um Usuário Inválido
   
    ${user_id}=    Get User Token    ${EMPTY}    password    

    ${resp}=    Deletar Dados Bancários do Motorista    ${user_id}    /username/deletaDadosBancarios    

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}

#Retorna erro ao não informar a senha de login
Deletar Dados Bancários Sem Informar a Senha do Usuário
   
    ${user_id}=    Get User Token    username    ${EMPTY}    

    ${resp}=    Deletar Dados Bancários do Motorista    ${user_id}    /username/deletaDadosBancarios    

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}

#Retorna erro ao não informar os campos de login
Deletar Dados Bancários Sem Informa um CPF
   
    ${user_id}=    Get User Token    ${EMPTY}    ${EMPTY}

    ${resp}=    Deletar Dados Bancários do Motorista    ${user_id}    /username/deletaDadosBancarios    

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}
