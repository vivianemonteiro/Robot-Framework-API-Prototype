*** Settings ***
Resource    ../../../resources/services.robot

Test Setup    Create Session    hook    ${base_url}    verify=${True}


*** Test Cases ***

#Atualiza dados bancários informando dados válidos
Inserir Dados Bancários Válido

    ${user_token}=    Get User Token    username    password

    ${payload}=    Convert To Json    {"codigoBanco": "033","agencia": "2332","agenciaDV": "4","conta": "12365","contaDV": "8","tipoConta": "Corrente"}

    ${resp}=    Inserir Dados Bancários    ${payload}    ${user_token}    


    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.text}           {"isSucesso":true}

#Atualizar dados bancários sem informar o código do banco
Inserir Dados Bancários sem Informar o Banco

    ${user_token}=    Get User Token    username    password

    ${payload}=    Convert To Json    {"codigoBanco": "","agencia": "2332","agenciaDV": "4","conta": "12365","contaDV": "8","tipoConta": "Corrente"}

    ${resp}=    Inserir Dados Bancários    ${payload}    ${user_token}    

    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.text}           {"isSucesso":false,"erros":[{"codigo":0,"mensagem":"Campo CodigoBanco é obrigatório"}]}

#Atualizar dados bancários sem informar a agência
Inserir Dados Bancários sem Informar a Agência

    ${user_token}=    Get User Token    username    password

    ${payload}=    Convert To Json    {"codigoBanco": "033","agencia": "","agenciaDV": "","conta": "12365","contaDV": "8","tipoConta": "Corrente"}

    ${resp}=    Inserir Dados Bancários    ${payload}    ${user_token}    

    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.text}           {"isSucesso":false,"erros":[{"codigo":0,"mensagem":"Campo Agencia é obrigatório"}]}

#Atualizar dados bancários sem informar o dígito da conta
Inserir Dados Bancários sem Informar a Conta

    ${user_token}=    Get User Token    username    password

    ${payload}=    Convert To Json    {"codigoBanco": "033","agencia": "2332","agenciaDV": "4","conta": "","contaDV": "8","tipoConta": "Corrente"}

    ${resp}=    Inserir Dados Bancários    ${payload}    ${user_token}    

    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.text}           {"isSucesso":false,"erros":[{"codigo":0,"mensagem":"Campo Conta é obrigatório"}]}

#Atualizar dados bancários sem informar o dígito da conta
Inserir Dados Bancários sem Informar o Dígito Conta

    ${user_token}=    Get User Token    username    password

    ${payload}=    Convert To Json    {"codigoBanco": "033","agencia": "2332","agenciaDV": "4","conta": "12365","contaDV": "","tipoConta": "Corrente"}

    ${resp}=    Inserir Dados Bancários    ${payload}    ${user_token}    

    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.text}           {"isSucesso":false,"erros":[{"codigo":0,"mensagem":"Campo ContaDV é obrigatório"}]}

#Atualizar dados bancários sem informar o tipo de conta
Inserir Dados Bancários sem Informar o Tipo de Conta

    ${user_token}=    Get User Token    username    password

    ${payload}=    Convert To Json            {"codigoBanco":"033","agencia": "2332","agenciaDV": "4","conta": "12365","contaDV": "8","tipoConta": ""}    

    ${resp}=       Inserir Dados Bancários    ${payload}   ${user_token}    

    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.text}           {"isSucesso":false,"erros":[{"codigo":0,"mensagem":"Campo TipoConta é obrigatório"}]}

#Atualizar dados bancários sem enviar as informações da conta
Inserir Dados Bancários sem Enviar as Informações

    ${user_token}=    Get User Token    username    password

    ${payload}=    Convert To Json    {"codigoBanco": "","agencia": "","agenciaDV": "","conta": "","contaDV": "","tipoConta": ""}

    ${resp}=    Inserir Dados Bancários    ${payload}    ${user_token}    

    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.text}           {"isSucesso":false,"erros":[{"codigo":0,"mensagem":"Campo CodigoBanco é obrigatório"},{"codigo":0,"mensagem":"Campo Agencia é obrigatório"},{"codigo":0,"mensagem":"Campo Conta é obrigatório"},{"codigo":0,"mensagem":"Campo ContaDV é obrigatório"},{"codigo":0,"mensagem":"Campo TipoConta é obrigatório"}]}

#Atualizar dados bancários de outro usuário
Inserir Dados Bancários de Outro Usuário

    ${user_token}=    Get User Token    93903766020    password

    ${payload}=    Convert To Json    {"codigoBanco": "033","agencia": "2332","agenciaDV": "4","conta": "12365","contaDV": "8","tipoConta": "Corrente"}

    ${resp}=    Inserir Dados Bancários    ${payload}    ${user_token}    

    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.text}           {"isSucesso":false,"erros":[{"codigo":1,"mensagem":"A pessoa para a qual se deseja alterar os dados bancários não foi encontrada ou o usuário logado não possui acesso à mesma."}]}

#Retorna erro, uma vez que o usuário não foi informado
Atualizar Dados Bancários de um Usuário Inválido

    ${user_token}=    Get User Token    ${EMPTY}    password    

    ${payload}=    Convert To Json    {"codigoBanco": "033","agencia": "2332","agenciaDV": "4","conta": "12365","contaDV": "8","tipoConta": "Corrente"}

    ${resp}=    Inserir Dados Bancários    ${payload}    ${user_token}    

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}

#Retorna erro, uma vez que a senha não foi informada
Atualizar Dados Bancários um Usuário com Senha Inválida

    ${user_token}=    Get User Token    username    ${EMPTY}    

    ${payload}=    Convert To Json    {"codigoBanco": "033","agencia": "2332","agenciaDV": "4","conta": "12365","contaDV": "8","tipoConta": "Corrente"}

    ${resp}=    Inserir Dados Bancários    ${payload}    ${user_token}    

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}

#Retorna erro, uma vez que o login não foi realizado com sucesso
Atualizar Dados Bancários de um Usuário com Login Inválido

    ${user_token}=    Get User Token    ${EMPTY}    ${EMPTY}    

    ${payload}=    Convert To Json    {"codigoBanco": "033","agencia": "2332","agenciaDV": "4","conta": "12365","contaDV": "8","tipoConta": "Corrente"}

    ${resp}=    Inserir Dados Bancários    ${payload}    ${user_token}    

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}
