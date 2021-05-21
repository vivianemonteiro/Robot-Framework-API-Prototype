*** Settings ***
Resource    ../../../resources/services.robot

Test Setup    Create Session    hook    ${base_url}    verify=${True}


*** Test Cases ***

#Retorna lista de todos os motivos (positivos e negativos)
Listar Todos os Motivos cadastrados
   
    ${user_id}=    Get User Token    username    password    

    ${resp}=    Listar Todos os Motivos de Elogios e Reclamações    ${user_id}    

    Should Be Equal As Strings    ${resp.status_code}   200
    Should Be Equal As Strings    ${resp.text}    {"isSucesso":true,"resultado":[{"idMotivoAvaliacaoETF":1,"descricao":"Preço bom","motivoAvaliacaoPositiva":true,"motivoAvaliacaoNegativa":false},{"idMotivoAvaliacaoETF":2,"descricao":"Atendimento excelente","motivoAvaliacaoPositiva":true,"motivoAvaliacaoNegativa":false},{"idMotivoAvaliacaoETF":3,"descricao":"Banheiro limpo","motivoAvaliacaoPositiva":true,"motivoAvaliacaoNegativa":false},{"idMotivoAvaliacaoETF":4,"descricao":"Restaurante bom","motivoAvaliacaoPositiva":true,"motivoAvaliacaoNegativa":false},{"idMotivoAvaliacaoETF":10,"descricao":"Preço abusivo","motivoAvaliacaoPositiva":false,"motivoAvaliacaoNegativa":true},{"idMotivoAvaliacaoETF":11,"descricao":"Diesel adulterado","motivoAvaliacaoPositiva":false,"motivoAvaliacaoNegativa":true},{"idMotivoAvaliacaoETF":12,"descricao":"Roubo no estacionamento","motivoAvaliacaoPositiva":false,"motivoAvaliacaoNegativa":true},{"idMotivoAvaliacaoETF":9,"descricao":"Outros","motivoAvaliacaoPositiva":true,"motivoAvaliacaoNegativa":true}]}
    
#Retorna lista de motivos de elogios
Listar Apenas Motivos de Elogio

    ${user_id}=    Get User Token    username    password    

    ${resp}=    Listar os Motivos por tipo    ${user_id}    =true    =false

    Should Be Equal As Strings    ${resp.status_code}   200
    Should Be Equal As Strings    ${resp.text}    {"isSucesso":true,"resultado":[{"idMotivoAvaliacaoETF":1,"descricao":"Preço bom","motivoAvaliacaoPositiva":true,"motivoAvaliacaoNegativa":false},{"idMotivoAvaliacaoETF":2,"descricao":"Atendimento excelente","motivoAvaliacaoPositiva":true,"motivoAvaliacaoNegativa":false},{"idMotivoAvaliacaoETF":3,"descricao":"Banheiro limpo","motivoAvaliacaoPositiva":true,"motivoAvaliacaoNegativa":false},{"idMotivoAvaliacaoETF":4,"descricao":"Restaurante bom","motivoAvaliacaoPositiva":true,"motivoAvaliacaoNegativa":false},{"idMotivoAvaliacaoETF":9,"descricao":"Outros","motivoAvaliacaoPositiva":true,"motivoAvaliacaoNegativa":true}]}

#Retorna lista de motivos de reclamação
Listar Apenas Motivos de Reclamação
    
    ${user_id}=    Get User Token    username    password    

    ${resp}=    Listar os Motivos por tipo    ${user_id}    =false    =true

    Should Be Equal As Strings    ${resp.status_code}   200
    Should Be Equal As Strings    ${resp.text}    {"isSucesso":true,"resultado":[{"idMotivoAvaliacaoETF":10,"descricao":"Preço abusivo","motivoAvaliacaoPositiva":false,"motivoAvaliacaoNegativa":true},{"idMotivoAvaliacaoETF":11,"descricao":"Diesel adulterado","motivoAvaliacaoPositiva":false,"motivoAvaliacaoNegativa":true},{"idMotivoAvaliacaoETF":12,"descricao":"Roubo no estacionamento","motivoAvaliacaoPositiva":false,"motivoAvaliacaoNegativa":true},{"idMotivoAvaliacaoETF":9,"descricao":"Outros","motivoAvaliacaoPositiva":true,"motivoAvaliacaoNegativa":true}]}

#Retorna erro por não poder trazer motivos positivos e negativos
Listar Todos Informando os Parâmetros
    
    ${user_id}=    Get User Token    username    password    

    ${resp}=    Listar os Motivos por tipo    ${user_id}    =true    =true

    Should Be Equal As Strings    ${resp.status_code}   200
    Should Be Equal As Strings    ${resp.text}    {"isSucesso":false,"erros":[{"codigo":1,"mensagem":"Não é possível consultar simultaneamente motivos positivos e motivos negativos."}]}

#Retorna erro por não passar nenhum parâmetro
Listar Nenhum Motivo Informando os Parâmetros

    ${user_id}=    Get User Token    username    password    

    ${resp}=    Listar os Motivos por tipo    ${user_id}    =false    =false

    Should Be Equal As Strings    ${resp.status_code}   200
    Should Be Equal As Strings    ${resp.text}    {"isSucesso":true,"resultado":[{"idMotivoAvaliacaoETF":1,"descricao":"Preço bom","motivoAvaliacaoPositiva":true,"motivoAvaliacaoNegativa":false},{"idMotivoAvaliacaoETF":2,"descricao":"Atendimento excelente","motivoAvaliacaoPositiva":true,"motivoAvaliacaoNegativa":false},{"idMotivoAvaliacaoETF":3,"descricao":"Banheiro limpo","motivoAvaliacaoPositiva":true,"motivoAvaliacaoNegativa":false},{"idMotivoAvaliacaoETF":4,"descricao":"Restaurante bom","motivoAvaliacaoPositiva":true,"motivoAvaliacaoNegativa":false},{"idMotivoAvaliacaoETF":10,"descricao":"Preço abusivo","motivoAvaliacaoPositiva":false,"motivoAvaliacaoNegativa":true},{"idMotivoAvaliacaoETF":11,"descricao":"Diesel adulterado","motivoAvaliacaoPositiva":false,"motivoAvaliacaoNegativa":true},{"idMotivoAvaliacaoETF":12,"descricao":"Roubo no estacionamento","motivoAvaliacaoPositiva":false,"motivoAvaliacaoNegativa":true},{"idMotivoAvaliacaoETF":9,"descricao":"Outros","motivoAvaliacaoPositiva":true,"motivoAvaliacaoNegativa":true}]}

#Retorna erro, uma vez que o usuário não foi informado
Listar Motivos para um Usuário Inválido

    ${user_id}=    Get User Token    ${EMPTY}    password    

    ${resp}=    Listar os Motivos por tipo    ${user_id}    =false    =false

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}

#Retorna erro, uma vez que a senha não foi informada
Listar Motivos para um Usuário com Senha Inválida

    ${user_id}=    Get User Token    username    ${EMPTY}    

    ${resp}=    Listar os Motivos por tipo   ${user_id}    =false    =false

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}

#Retorna erro, uma vez que o login não foi realizado com sucesso
Listar Motivos para um Usuário com Login Inválido

    ${user_id}=    Get User Token    ${EMPTY}    ${EMPTY}    

    ${resp}=    Listar os Motivos por tipo    ${user_id}    =false    =false

    Should Be Equal As Strings    ${resp.status_code}    401
    Should Be Equal As Strings    ${resp.text}           {"message":"Authorization has been denied for this request."}
    