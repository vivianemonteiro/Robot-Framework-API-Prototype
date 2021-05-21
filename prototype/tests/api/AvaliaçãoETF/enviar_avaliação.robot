*** Settings ***
Resource    ../../../resources/services.robot

Test Setup    Create Session    hook    ${base_url}    verify=${True}


*** Test Cases ***

#Realizar a avaliação de um posto com motivo "outros" e comentário e com motivo sem ser "outros" e sem comentário
Enviar Avaliação Válida
    [Template]      Inserir uma Avaliação
  
    {"idMovimentoAvaliacao": 268583,"idPosto": 2904,"nota": 5,"idsMotivoAvaliacaoETF": [2],"comentarios": "Bom atendimento, mas o lugar poderia estar mais bem conservato"}    True 

#Realizar a avaliação de um posto inexistente
Enviar Avaliação de Posto Inexistente
    [Template]      Inserir Avaliação 
  
    {"idMovimentoAvaliacao": 268408,"idPosto": 55,"nota": 1,"idsMotivoAvaliacaoETF": [9],"comentarios": "Lugar ruim e mal iluminado"}    False                         codigo: 1, mensagem: Estabelecimento não encontrado

#Realizar a avaliação de uma movimentação inexistente
Enviar Avaliação de uma Movimentação Inexistente
    [Template]      Inserir Avaliação Inválida
  
    {"idMovimentoAvaliacao": 6989,"idPosto": 2904,"nota": 5,"idsMotivoAvaliacaoETF": [9],"comentarios": "Lugar incrível!!"}     False                         codigo: 1, mensagem: Erro no campo avaliacao.idMovimentoAvaliacao. Verifique o valor informado

#Realizar a avaliação sem informar o id da movimentação
Enviar Avaliação sem Informar o Id da Movimentação
    [Template]      Inserir Avaliação Inválida
  
    {"idPosto": 2904,"nota": 5,"idsMotivoAvaliacaoETF": [9],"comentarios": "Lugar incrível!!"}     False                         codigo: 1, mensagem: Erro no campo avaliacao.idMovimentoAvaliacao. Verifique o valor informado

#Realizar a avaliação com uma nota inválida
Enviar Avaliação com uma Nota Inválida
    [Template]      Inserir Avaliação Inválida
 
    {"idMovimentoAvaliacao": 266989,"idPosto": 2904,"nota": 15,"idsMotivoAvaliacaoETF": [9],"comentarios": "Lugar incrível!!"}    False                         codigo: 0, mensagem: Campo Nota deve ser entre 1 e 5

#Realizar a avaliação com uma nota ruim e um motivo positivo
Enviar Avaliação com uma Nota Ruim e um Motivo Positivo
    [Template]      Inserir Avaliação Inválida
 
    {"idMovimentoAvaliacao": 268408,"idPosto": 2904,"nota": 1,"idsMotivoAvaliacaoETF": [1],"comentarios": "Posto sujo e atendimento horrível"}    False                         codigo: 1, mensagem: Não é permitido enviar um motivo de avaliação positivo para uma nota inferior a 4.

#Realizar a avaliação com uma nota boa e um motivo ruim
Enviar Avaliação com uma Nota Boa e um Motivo Ruim
    [Template]      Inserir Avaliação Inválida
 
    {"idMovimentoAvaliacao": 268408,"idPosto": 2904,"nota": 5,"idsMotivoAvaliacaoETF": [7],"comentarios": "Lugar incrível!!"}    False                         codigo: 0, mensagem: Não é permitido enviar um motivo de avaliação negativo para uma nota superior a 3.

#Realizar a avaliação com uma nota boa e um motivo ruim
Enviar Avaliação já Dispensada
    [Template]      Inserir Avaliação Inválida
 
    {"idMovimentoAvaliacao": 266684,"idPosto": 2904,"nota": 15,"idsMotivoAvaliacaoETF": [9],"comentarios": "Lugar incrível!!"}    False                         codigo: 0, mensagem: Avaliação já foi dispensada.