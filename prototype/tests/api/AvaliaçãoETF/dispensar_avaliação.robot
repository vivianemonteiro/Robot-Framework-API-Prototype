*** Settings ***
Resource    ../../../resources/services.robot

Test Setup    Create Session    hook    ${base_url}    verify=${True}


*** Test Cases ***

#Dispensar uma avalição
Dispensar Avaliação

    ${user_id}=    Get User Token    username    password    

    ${resp}=    Dispensar Avaliação    ${user_id}    id_transação

    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.text}           {"isSucesso":true}    
    Log    ${resp.text}

#Dispensar uma avalição já dispensada
Dispensar Avaliação Já Dispensada

    ${user_id}=    Get User Token    username    password    

    ${resp}=    Dispensar Avaliação    ${user_id}    id_transação

    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.text}           {"isSucesso":false,"erros":[{"codigo":1,"mensagem":"Não é possível dispensar uma avaliação que já tenha sido respondida ou dispensada."}]}    
    
#Dispensar uma avalição inexistente
Dispensar Avaliação Inexistente

    ${user_id}=    Get User Token    username    password    

    ${resp}=    Dispensar Avaliação    ${user_id}    id_transação

    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.text}           {"isSucesso":false,"erros":[{"codigo":1,"mensagem":"Avaliação não encontrada."}]}    
 
#Dispensar uma avalição inválida
Dispensar Avaliação Inválida

    ${user_id}=    Get User Token    username    password    

    ${resp}=    Dispensar Avaliação    ${user_id}    abcdefg

    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.text}           {"isSucesso":false,"erros":[{"codigo":0,"mensagem":"O valor informado no campo 'idMovimentoAvaliacao' não é válido"}]}    

#Dispensar uma avalição sem informar o id que é obrigatório
Dispensar Avaliação Sem Informar o Id

    ${user_id}=    Get User Token    username    password    

    ${resp}=    Dispensar Avaliação    ${user_id}    ${EMPTY}

    Should Be Equal As Strings    ${resp.status_code}    404
    Should Be Equal As Strings    ${resp.text}           {"message":"No HTTP resource was found that matches the request URI 'http://hook.com.br/'."}
   
#Retorna erro, uma vez que o usuário não foi informado
Dispensar Avaliação de Usuário Inválido

    ${user_id}=    Get User Token    ${EMPTY}    password    

    ${resp}=    Dispensar Avaliação    ${user_id}    id_transação

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}
    
#Retorna erro, uma vez que a senha não foi informada
Dispensar Avaliação de um Usuário com Senha Inválida

    ${user_id}=    Get User Token    username    ${EMPTY}    

    ${resp}=    Dispensar Avaliação    ${user_id}    id_transação

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}

#Retorna erro, uma vez que o login não foi realizado com sucesso
Dispensar Avaliação de um Usuário com Login Inválido

    ${user_id}=    Get User Token    ${EMPTY}    ${EMPTY}    

    ${resp}=    Dispensar Avaliação    ${user_id}    id_transação

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}
  