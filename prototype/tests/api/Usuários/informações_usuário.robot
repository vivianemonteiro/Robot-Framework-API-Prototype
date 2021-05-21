*** Settings ***
Resource    ../../../resources/services.robot

Test Setup    Create Session    hook    ${base_url}    verify=${True}


*** Test Cases ***

#Registra informações do usuário do app e seu dispositivo
Informações de Usuário Válidas
    [Template]    Informações do Usuário
   
    {"idDispositivo": "123456","enderecoIP": "82.82.90","latitude":"-23526468","versaoApp": "1.16.20"}          True 
    {"idDispositivo": "123456","enderecoIP": "82.82.90","longitude":"-46811296,6785","versaoApp": "1.16.20"}    True 

#Retorna erro ao não informar o id do dispositivo
Id do Dispositivo não Informado
    [Template]    Informações do Usuário Inválida

    {"enderecoIP": "82.82.90","latitude":"-23526468","longitude":"-46811296,6785","versaoApp": "1.16.20"}    False    codigo: 0, mensagem: Campo IdDispositivo é obrigatório    ${EMPTY}      ${EMPTY}

#Retorna erro ao não informar o endereço IP
Endereço IP não Informado
    [Template]    Informações do Usuário Inválida

    {"idDispositivo": "123456","latitude":"-23526468","longitude":"-46811296,6785","versaoApp": "1.16.20"}    False   codigo: 0, mensagem: Campo EnderecoIP é obrigatório   ${EMPTY}      ${EMPTY}

#Retorna erro ao não informar a versão do App
Versão do App não Informada
    [Template]    Informações do Usuário Inválida

    {"idDispositivo": "123456","enderecoIP": "82.82.90","latitude":"-23526468","longitude":"-46811296,6785"}    False    codigo: 0, mensagem: Campo VersaoApp é obrigatório    ${EMPTY}    ${EMPTY}

#Retorna erro ao enviar um json vazio
Enviar um Json Vazio
    [Template]    Informações do Usuário Inválida

    {}    False    codigo: 0, mensagem: Campo IdDispositivo é obrigatório    codigo: 0, mensagem: Campo EnderecoIP é obrigatório    codigo: 0, mensagem: Campo VersaoApp é obrigatório

#Informar apenas a latitude e a longitude
Informando Apena a Latitude e a Longitude
    [Template]    Informações do Usuário Inválida

    {"latitude":"-23526468","longitude":"-46811296,6785"}    False    codigo: 0, mensagem: Campo IdDispositivo é obrigatório    codigo: 0, mensagem: Campo EnderecoIP é obrigatório    codigo: 0, mensagem: Campo VersaoApp é obrigatório