*** Settings ***
Resource    ../../../resources/services.robot

Test Setup    Create Session    hook    ${base_url}    verify=${True}


*** Test Cases ***

#Realizar a reclamação de um posto com motivo "outros" e comentário e com motivo sem ser "outros" e sem comentário
Reclamação e Elogio Válidos
    [Template]                                                                                                                                                                     Inserir Reclamação ou Elogio Válido
   
    {"idPosto": 2903,"idsMotivoAvaliacaoETF": [9],"comentarios": "Péssimo atendimento, atendente mal educado! Demora para realizar o atendimento","tipoFeedback": "Reclamacao"}    True                                   
    {"idPosto": 2903,"idsMotivoAvaliacaoETF": [12],"tipoFeedback": "Reclamacao"}                                                                                                   True                                   
    {"idPosto": 2903,"idsMotivoAvaliacaoETF": [9],"comentarios": "Sempre que posso, paro aqui, ótimo atendimento e preço muito bom!","tipoFeedback": "Elogio"}                     True                                   
    {"idPosto": 2903,"idsMotivoAvaliacaoETF": [4],"tipoFeedback": "Elogio"}                                                                                                        True                                   

#Realizar a reclamação de um posto informando Id Inválido
Reclamação e Elogio de um Posto Inexistente
    [Template]                                                                                                                                                                   Inserir Reclamação ou Elogio Inválido
   
    {"idPosto": 55,"idsMotivoAvaliacaoETF": [9],"comentarios": "Péssimo atendimento, atendente mal educado! Demora para realizar o atendimento","tipoFeedback": "Reclamacao"}    False                                    codigo: 0, mensagem:ETF 55 não cadastrado na base           ${EMPTY}    
    {"idPosto": 55,"idsMotivoAvaliacaoETF": [9],"comentarios": "Muito limpo e bem iluminado, atendimento muito bom e preço justo","tipoFeedback": "Elogio"}                      False                                    codigo: 0, mensagem:ETF 55 não cadastrado na base           ${EMPTY}    

#Realizar a reclamação de um posto sem informar o motivo
Reclamação e Elogio Sem Motivo
    [Template]                                                                                                                                                                    Inserir Reclamação ou Elogio Inválido
   
    {"idPosto": 2903,"idsMotivoAvaliacaoETF": [],"comentarios": "Péssimo atendimento, atendente mal educado! Demora para realizar o atendimento","tipoFeedback": "Reclamacao"}    False                                    codigo: 1, mensagem: É obrigatório selecionar ao menos um motivo.    ${EMPTY}    
    {"idPosto": 2903,"idsMotivoAvaliacaoETF": [],"comentarios": "Atendimento muito bom, a limpeza deixa um pouco a desejar.","tipoFeedback": "Elogio"}                            False                                    codigo: 1, mensagem: É obrigatório selecionar ao menos um motivo.    ${EMPTY}    

#Realizar a reclamação de um posto informando um motivo inexistente
Reclamação e Elogio com Motivo inexistente
    [Template]                                                                                                                                                                       Inserir Reclamação ou Elogio Inválido
  
    {"idPosto": 2903,"idsMotivoAvaliacaoETF": [300],"comentarios": "Péssimo atendimento, atendente mal educado! Demora para realizar o atendimento","tipoFeedback": "Reclamacao"}    False                                    codigo: 1, mensagem: Motivo(s) inválido(s).    ${EMPTY}    
    {"idPosto": 2903,"idsMotivoAvaliacaoETF": [300],"comentarios": "Gosto muito, preço justo!","tipoFeedback": "Elogio"}                                                             False                                    codigo: 1, mensagem: Motivo(s) inválido(s).    ${EMPTY}    

#Realizar a reclamação de um posto informando um motivo "Outros" sem comentário
Reclamação e Elogio com Motivo Outros sem Comentários
    [Template]                                                                     Inserir Reclamação ou Elogio Inválido
  
    {"idPosto": 2903,"idsMotivoAvaliacaoETF": [9],"tipoFeedback": "Reclamacao"}    False                                    codigo: 1, mensagem: Ao selecionar o motivo \"Outros\", é obrigatório preencher o campo de comentários.    ${EMPTY}    
    {"idPosto": 2903,"idsMotivoAvaliacaoETF": [9],"tipoFeedback": "Elogio"}        False                                    codigo: 1, mensagem: Ao selecionar o motivo \"Outros\", é obrigatório preencher o campo de comentários.    ${EMPTY}    

#Realizar reclamação sem enviar o id do Posto
Reclamação e Elogio sem Informar o Id do Posto
    [Template]                                                                                                                                                      Inserir Reclamação ou Elogio Inválido
  
    {"idsMotivoAvaliacaoETF": [12],"comentarios": "Péssimo atendimento, atendente mal educado! Demora para realizar o atendimento","tipoFeedback": "Reclamacao"}    False                                    codigo: 0, mensagem: ETF 0 não cadastrado na base        codigo: 0, mensagem: Campo IdPosto deve ser entre 1 e 2147483647
    {"idsMotivoAvaliacaoETF": [1],"comentarios": "Ótimo atendimento, sempre que posso paro nesse posto!","tipoFeedback": "Elogio"}                                  False                                    codigo: 0, mensagem: ETF 0 não cadastrado na base        codigo: 0, mensagem: Campo IdPosto deve ser entre 1 e 2147483647

#Enviar reclamação com motivo positivo e elogio com motivo negativo
Reclamação com Motivo Positivo e Elogio com Motivo Negativo
    [Template]    Inserir Reclamação ou Elogio Válido
  
    {"idPosto": 2904, "idsMotivoAvaliacaoETF": [1],"comentarios": "Péssimo atendimento, atendente mal educado! Demora para realizar o atendimento","tipoFeedback": "Reclamacao"}    True    
    {"idPosto": 2904, "idsMotivoAvaliacaoETF": [12],"comentarios": "Sempre paro aqui, ótima localização","tipoFeedback": "Elogio"}                                                  True    