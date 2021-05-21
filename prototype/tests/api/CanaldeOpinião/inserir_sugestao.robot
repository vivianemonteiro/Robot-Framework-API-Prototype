*** Settings ***
Resource    ../../../resources/services.robot

Test Setup    Create Session    hook    ${base_url}    verify=${True}


*** Test Cases ***

#Enviar uma sugestão para um posto
Inserir Sugestão Válida
    [Template]   Inserir Sugestão 
  
    {"idPosto": 2903,"comentarios": "Poderia melhorar a iluminação e o visual no geral, parece um posto abandonado."}  True     ${EMPTY}    ${EMPTY}
    
#Enviar uma sugestão inválida
Inserir Sugestão Inálida
    [Template]   Inserir Sugestão 
  
    {"comentarios": "Poderia melhorar a iluminação e o visual no geral, parece um posto abandonado."}  False    codigo: 0, mensagem: Campo IdPosto deve ser entre 1 e 2147483647  ${EMPTY}     
    {"idPosto": 2903}   False    codigo: 0, mensagem: Campo Comentarios é obrigatório   ${EMPTY}    
    {"idPosto": 4000,"comentarios": "Poderia melhorar a iluminação e o visual no geral, parece um posto abandonado."}  False     codigo: 1, mensagem: ETF não encontrado    ${EMPTY}    
    {}  False     codigo: 0, mensagem: Campo IdPosto deve ser entre 1 e 2147483647   codigo: 0, mensagem: Campo Comentarios é obrigatório
