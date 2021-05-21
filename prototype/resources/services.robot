*** Settings ***
Library    Collections
Library    RequestsLibrary
Library    OperatingSystem

Resource    helpers.robot

*** Variables ***
${base_url}    http://siteadresshere

*** Keywords ***

#Gera o token e inicia a sessão do usuário
Post Session
  
    [Arguments]    ${username}    ${password}    

    &{data}=       Create Dictionary    grant_type=password                               username=${username}    password=${password}
    &{headers}=    Create Dictionary    Content-Type=application/x-www-form-urlencoded
    ${resp}=       Post Request         hook                                            /token                  data=${data}            headers=${headers}

    [return]    ${resp}

#Salva o token
Get User Token
  
    [Arguments]    ${username}    ${password}    

    ${refPost}=    Post Session    ${username}                            ${password}
    ${token}=      evaluate        $refPost.json().get("access_token")

    ${Bearer}=     Set Variable    Bearer
    ${token}=      catenate        ${Bearer}    ${token}

    [return]    ${token}

#Chama a API que cadastra o telefone favorito e passa o token salvo no Get User Token
Telefone Favorito Recarga
  
    [Arguments]    ${token}    ${payload} 

    &{headers}=    Create Dictionary    Content-Type=application/json    Accept=application/json         Authorization=${token}
    ${resp}=       Post Request         hook                           /api/TelefoneFavoritoRecarga    data=${payload}           headers=${headers}    

    [return]    ${resp}

#Cadastro de telefone favorito válido utilizando a API TelefoneFavoritoRecarga
Telefone Favorito

    [Arguments]    ${json}    ${expect_message}     ${erro}    ${erro2}

    ${user_token}=    Get User Token               username    password
    ${payload}=       Convert To Json              ${json}
    ${resp}=          Telefone Favorito Recarga    ${user_token}    ${payload}

    ${retorno}=       Convert To String            ${resp.json().get("isSucesso")}

    Run Keyword If    '${retorno}' == 'False'      Telefone Favorito Inválido    ${json}    ${expect_message}    ${erro}    ${erro2}

      ...    ELSE    Log         '${retorno}'

    Should Be Equal As Strings    ${retorno}    ${expect_message}

    [return]    ${resp}

#Cadastro de telefone favorito inválido utilizando a API TelefoneFavoritoRecarga
Telefone Favorito Inválido

    [Arguments]    ${json}    ${expect_message}    ${erro}    ${erro2}

    ${user_token}=    Get User Token               username    password
    ${payload}=       Convert To Json              ${json}
    ${resp}=          Telefone Favorito Recarga    ${user_token}    ${payload}

    ${retorno}=       Convert To String            ${resp.json().get("isSucesso")}
    ${erros}=         Convert To String            ${resp.json().get("erros")}

    :FOR    ${item}    IN    @{resp.json().get("erros")}
    \    Log             ${item}
    \    ${codigo}=      Set variable             ${item['codigo']}
    \    ${mensagem}=    Set variable             ${item['mensagem']}
    \    Log             ${codigo},${mensagem}

    Log    ${retorno}    
    Log    ${erro}
    Log    ${erro2}
    Should Be Equal As Strings    ${retorno}    ${expect_message}    ${erro}    ${erro2}

    [return]    ${resp}

#Lista de telefones favoritos cadastrados
Lista de Telefones Favoritos
    
    [Arguments]    ${user_token}

    &{headers}=    Create Dictionary    Content-Type=application/json            Authorization=${user_token}
    ${resp}=       Get Request          hook    api/TelefoneFavoritoRecarga    headers=${headers}    

    ${retorno}=    Convert To String    ${resp.json().get("isSucesso")}
    ${erros}=      Convert To String    ${resp.json().get("resultado")}

    :FOR    ${item}    IN    @{resp.json().get("resultado")}
    \    Log           ${item}
    \    ${codigo}=    Set Variable                  ${item['id']}
    \    ${ddd}=       Set Variable                  ${item['DDD']}
    \    ${numero}=    Set Variable                  ${item['numero']}
    \    Log           ${codigo},${ddd},${numero}

    Log         ${resp}

    [return]    ${resp}

#Lista telefones favoritos de um usuário sem permissão
Lista de Telefones Favoritos Sem Permissão
  
    [Arguments]    ${user_token}

    &{headers}=    Create Dictionary    Content-Type=application/json            Authorization=${user_token}
    ${resp}=       Get Request          hook    api/TelefoneFavoritoRecarga    headers=${headers}    

    [return]    ${resp}

#Deleta um telefone favorito válido
Deletar Telefone Favorito Válido
  
    [Arguments]    ${user_token}    ${id_telefone} 

    &{headers}=    Create Dictionary    Content-Type=application/json                           Authorization=${user_token}
    ${resp}=       Delete Request       hook    api/TelefoneFavoritoRecarga/${id_telefone}    headers=${headers}    

    ${retorno}=    Convert To String    ${resp.json().get("isSucesso")}

    Log    ${retorno}

    [return]    ${resp}

#Deleta um telefone favorito ivnálido
Deletar Telefone Favorito Inválido
  
    [Arguments]    ${user_token}    ${id_telefone} 

    &{headers}=    Create Dictionary    Content-Type=application/json                           Authorization=${user_token}
    ${resp}=       Delete Request       hook    api/TelefoneFavoritoRecarga/${id_telefone}    headers=${headers}    

    ${retorno}=    Convert To String    ${resp.json().get("isSucesso")}
    ${erros}=      Convert To String    ${resp.json().get("erros")}

    :FOR    ${item}    IN    @{resp.json().get("erros")}
    \    Log             ${item}
    \    ${codigo}=      Set variable             ${item['codigo']}
    \    ${mensagem}=    Set variable             ${item['mensagem']}
    \    Log             ${codigo},${mensagem}

    Log         ${retorno}    
    Log         ${erros}

    [return]    ${resp}

#Listar operadoras de um ddd válido
Listar Operadoras por DDD
  
    [Arguments]    ${user_token}    ${ddd}

    &{headers}=    Create Dictionary    Content-Type=application/json                           Authorization=${user_token}
    ${resp}=       Get Request          hook    api/recargaCelular/listarOperadoras/${ddd}    headers=${headers}    

    ${retorno}=       Convert To String    ${resp.json().get("isSucesso")}
    ${operadoras}=    Convert To String    ${resp.json().get("resultado")}

    [return]    ${resp}

#Lista os valores de recarga diponíveis por operadora
Listar Valor por Operadora
  
    [Arguments]    ${user_token}    ${ddd}    ${id_operadora}

    &{headers}=    Create Dictionary    Content-Type=application/json                                               Authorization=${user_token}
    ${resp}=       Get Request          hook    api/recargaCelular/listarValoresRecarga/${ddd}/${id_operadora}    headers=${headers}    

    ${retorno}=       Convert To String    ${resp.json().get("isSucesso")}
    ${operadoras}=    Convert To String    ${resp.json().get("resultado")}

    [return]    ${resp}

#Consulta operadora pelo ddd e telefone
Consulta Operadora
  
    [Arguments]    ${user_token}    ${ddd}    ${telefone}

    &{headers}=    Create Dictionary    Content-Type=application/json                                         Authorization=${user_token}
    ${resp}=       Get Request          hook    api/recargaCelular/consultarOperadora/${ddd}/${telefone}    headers=${headers}    

    ${retorno}=       Convert To String    ${resp.json().get("isSucesso")}
    ${operadoras}=    Convert To String    ${resp.json().get("resultado")}

    [return]    ${resp}

#Realiza a recarga de acordo com os parâmetros passados
Realizar Recarga
  
    [Arguments]    ${json}    ${expect_message}    

    ${user_token}=    Get User Token       username    password
    ${payload}=       Convert To Json      ${json}
    &{headers}=       Create Dictionary    Content-Type=application/json    Accept=application/json               Authorization=${user_token}    
    ${resp}=          Post Request         hook                           api/recargaCelular/realizarRecarga    data=${payload}                headers=${headers}    

    ${ret_tel}=      Convert To String     ${resp.json().get("telefone")}
    ${sms_token}=    Convert To String     ${ret_tel.split("Token:")[-1].replace(")", "")}

    &{headers}=    Create Dictionary       Content-Type=application/json                    Accept=application/json    Authorization=${user_token}    SMS-Token=${sms_token}
    ${payload}=    Convert To Json         ${json}
    ${resp}=       Post Request            hook     api/recargaCelular/realizarRecarga    data=${payload}            headers=${headers}    

    ${retorno}=        Convert To String   ${resp.json().get("isSucesso")}
    ${comprovante}=    Convert To String   ${resp.json().get("resultado")}

    Log    ${retorno}
    Log    ${comprovante}
    Should Be Equal As Strings    ${retorno}    ${expect_message}

    [return]                      ${resp}

#Enviar um elogio ou recalmação válida
Inserir Reclamação ou Elogio Válido
  
    [Arguments]       ${json}           ${expect_message}    
  
    ${user_token}=    Get User Token       username          password
    &{headers}=       Create Dictionary    Content-Type=application/json                                Accept=application/json    Authorization=${user_token} 
    ${payload}=       Convert To Json      ${json}
    ${resp}=          Post Request         hook    /api/canalcomunicacaoetf/insereReclamacaoElogio    data=${payload}            headers=${headers}

    ${retorno}=    Convert To String       ${resp.json().get("isSucesso")}

    Log    ${retorno} 
    Should Be Equal As Strings    ${retorno}    ${expect_message}

    [return]    ${resp}

#Enviar um elegio ou reclamção inválido
Inserir Reclamação ou Elogio Inválido
  
    [Arguments]       ${json}           ${expect_message}    ${erro}    ${erro2}    
  
    ${user_token}=    Get User Token        username          password
    &{headers}=       Create Dictionary     Content-Type=application/json                                Accept=application/json    Authorization=${user_token} 
    ${payload}=       Convert To Json       ${json}
    ${resp}=          Post Request          hook    /api/canalcomunicacaoetf/insereReclamacaoElogio    data=${payload}            headers=${headers}

    ${retorno}=       Convert To String     ${resp.json().get("isSucesso")}
    ${erro}=          Convert To String     ${resp.json().get("erros")}

    :FOR    ${item}    IN    @{resp.json().get("erros")}
    \    Log             ${item}
    \    ${codigo}=      Set variable             ${item['codigo']}
    \    ${mensagem}=    Set variable             ${item['mensagem']}
    \    Log             ${codigo},${mensagem}

    Should Be Equal As Strings    ${retorno}    ${expect_message}    ${erro}    ${erro2}    
    Log                           ${retorno}    
    Log                           ${erro}

    [return]    ${resp}

#Enviar uma sugestão para um ETF
Inserir Sugestão
  
    [Arguments]       ${json}           ${expect_message}    ${erro}    ${erro2}    
  
    ${user_token}=    Get User Token       username          password
    &{headers}=       Create Dictionary    Content-Type=application/json                        Accept=application/json    Authorization=${user_token} 
    ${payload}=       Convert To Json      ${json}
    ${resp}=          Post Request         hook    /api/canalcomunicacaoetf/insereSugestao    data=${payload}            headers=${headers}

    ${retorno}=       Convert To String    ${resp.json().get("isSucesso")}
    ${erro}=          Convert To String    ${resp.json().get("erros")}

    Should Be Equal As Strings    ${retorno}    ${expect_message}    ${erro}    ${erro2}    
    Log    ${retorno}    
    Log    ${erro}

    [return]    ${resp}

#Retorna a lista de motivos disponíveis para elogios e reclamações
Listar Todos os Motivos de Elogios e Reclamações
  
    [Arguments]    ${user_token}        
  
    &{headers}=      Create Dictionary    Content-Type=application/json                       Authorization=${user_token}
    ${resp}=         Get Request          hook    api/canalcomunicacaoetf/motivos/listar    headers=${headers} 

    ${retorno}=      Convert To String    ${resp.json().get("isSucesso")}
    ${resultado}=    Convert To String    ${resp.json().get("resultado")}

    [return]    ${resp}

#Retorna a lista de motivos disponíveis para elogios e reclamações
Listar os Motivos por tipo
  
    [Arguments]    ${user_token}    ${positivo}    ${negativo}

    &{headers}=      Create Dictionary    Content-Type=application/json                                                                                             Authorization=${user_token}
    ${resp}=         Get Request          hook    api/canalcomunicacaoetf/motivos/listar?somenteMotivosPositivos${positivo}&somenteMotivosNegativos${negativo}    headers=${headers}    

    ${retorno}=      Convert To String    ${resp.json().get("isSucesso")}
    ${resultado}=    Convert To String    ${resp.json().get("resultado")}

    [return]    ${resp}

#Retorna a lista de ETFs
Listar ETFs

    [Arguments]    ${user_token}    ${status}    ${data}    

    &{headers}=      Create Dictionary    Content-Type=application/json                      Authorization=${user_token}
    ${resp}=         Get Request          hook    /api/ETFs/lista/todos${status}${data}    headers=${headers}    

    ${retorno}=      Convert To String    ${resp.json().get("isSucesso")}
    ${resultado}=    Convert To String    ${resp.json().get("resultado")}

    Log    ${retorno}
    Log    ${resultado}

    [return]    ${resp}

#Lista as avaliações pendentes
Listar Avaliações Pendentes

    [Arguments]    ${user_token}        
  
    &{headers}=      Create Dictionary    Content-Type=application/json                           Authorization=${user_token}
    ${resp}=         Get Request          hook    api/avaliacaoETF/consultaAvaliacaoPendente    headers=${headers}    

    ${retorno}=      Convert To String    ${resp.json().get("isSucesso")}
    ${resultado}=    Convert To String    ${resp.json().get("resultado")}

    Log    ${retorno}
    Log    ${resultado}

    [return]    ${resp}

#Dispensar uma avalição
Dispensar Avaliação

    [Arguments]    ${user_token}        ${id_avaliacao}

    &{headers}=      Create Dictionary    Content-Type=application/json                           Authorization=${user_token}
    ${resp}=         Post Request         hook    api/avaliacaoETF/dispensar/${id_avaliacao}    headers=${headers}    

    ${retorno}=      Convert To String    ${resp.json().get("isSucesso")}
    ${resultado}=    Convert To String    ${resp.json().get("resultado")}

    Log    ${retorno}
    Log    ${resultado}

    [return]    ${resp}

#Lista todos os bancos disponíveis
Listar Bancos

    [Arguments]    ${user_token}    

    &{headers}=      Create Dictionary    Content-Type=application/json    Authorization=${user_token}
    ${resp}=         Get Request          hook    api/bancos/todos       headers=${headers}    

    ${retorno}=      Convert To String    ${resp.json().get("isSucesso")}
    ${resultado}=    Convert To String    ${resp.json().get("resultado")}

    Log    ${retorno}
    Log    ${resultado}

    [return]    ${resp}

#Lista os contatos de todos os contratantes
Lista Contato Contratantes
  
    [Arguments]    ${user_token}    

    &{headers}=      Create Dictionary    Content-Type=application/json                Authorization=${user_token}
    ${resp}=         Get Request          hook    api/contratantes/contatos/todos    headers=${headers}    

    ${retorno}=      Convert To String    ${resp.json().get("isSucesso")}
    ${resultado}=    Convert To String    ${resp.json().get("resultado")}

    Log    ${retorno}
    Log    ${resultado}

    [return]    ${resp}

#Lista todos os contratantes vinculados ao usuário
Lista Contratantes Usuário
  
    [Arguments]    ${user_token}    

    &{headers}=      Create Dictionary    Content-Type=application/json                     Authorization=${user_token}
    ${resp}=         Get Request          hook    api/contratantes/contratantesUsuario    headers=${headers}    

    ${retorno}=      Convert To String    ${resp.json().get("isSucesso")}
    ${resultado}=    Convert To String    ${resp.json().get("resultado")}

    Log    ${retorno}
    Log    ${resultado}

    [return]    ${resp}

#Enviar a avaliação de um ETF
Inserir uma Avaliação
  
    [Arguments]       ${json}           ${expect_message}    
  
    ${user_token}=    Get User Token       username          password
    &{headers}=       Create Dictionary    Content-Type=application/json                  Accept=application/json    Authorization=${user_token} 
    ${payload}=       Convert To Json      ${json}
    ${resp}=          Post Request         hook    /api/avaliacaoETF/incluiAvaliacao    data=${payload}            headers=${headers}

    ${retorno}=       Convert To String    ${resp.json().get("isSucesso")}

    Log    ${retorno} 
    Should Be Equal As Strings    ${retorno}    ${expect_message}

    [return]    ${resp}

#Enviar uma avaliação inválida
Inserir Avaliação Inválida
  
    [Arguments]       ${json}           ${expect_message}    ${erro}    
  
    ${user_token}=    Get User Token       username          password
    &{headers}=       Create Dictionary    Content-Type=application/json                  Accept=application/json    Authorization=${user_token} 
    ${payload}=       Convert To Json      ${json}
    ${resp}=          Post Request         hook    /api/avaliacaoETF/incluiAvaliacao    data=${payload}            headers=${headers}

    ${retorno}=    Convert To String    ${resp.json().get("isSucesso")}
    ${erro}=       Convert To String    ${resp.json().get("erros")}

    :FOR    ${item}    IN    @{resp.json().get("erros")}
    \                             Log             ${item}
    \                             ${codigo}=      Set variable             ${item['codigo']}
    \                             ${mensagem}=    Set variable             ${item['mensagem']}
    \                             Log             ${codigo},${mensagem}
    Should Be Equal As Strings    ${retorno}      ${expect_message}        ${erro}                
    Log                           ${retorno}      
    Log                           ${erro}

    [return]    ${resp}

#Enviar uma avaliação inválida
Inserir Dados Bancários
  
    [Arguments]    ${payload}    ${user_token}

    &{headers}=    Create Dictionary    Content-Type=application/json                                  Accept=application/json       Authorization=${user_token} 
    ${resp}=       Put Request          hook    api/motoristas/username/atualizaDadosBancarios    data=${payload}               headers=${headers}

    ${retorno}=    Convert To String    ${resp.json().get("isSucesso")}

    [return]    ${resp}

#Lista os dados bancários do usuário
Dados Bancários do Motorista
  
    [Arguments]    ${user_token}    ${CPF}

    &{headers}=    Create Dictionary    Content-Type=application/json      Authorization=${user_token}
    ${resp}=       Get Request          hook    /api/motoristas${CPF}    headers=${headers}    

    ${retorno}=    Convert To String    ${resp.json().get("isSucesso")}

    Log    ${retorno}

    [return]    ${resp}

#Delertar os dados bancários do usuário
Deletar Dados Bancários do Motorista
  
    [Arguments]    ${user_token}    ${CPF}

    &{headers}=    Create Dictionary    Content-Type=application/json      Authorization=${user_token}
    ${resp}=       Delete Request       hook    /api/motoristas${CPF}    headers=${headers}    

    ${retorno}=    Convert To String    ${resp.json().get("isSucesso")}

    Log    ${retorno}

    [return]    ${resp}

#Consultar o saldo frete
Consultar Viagem Saldo Frete

    [Arguments]    ${user_token}    ${id_viagem}

    &{headers}=    Create Dictionary    Content-Type=application/json         Authorization=${user_token}
    ${resp}=       Get Request          hook    /api/viagens${id_viagem}    headers=${headers}    

    ${retorno}=    Convert To String    ${resp.json().get("isSucesso")}

    Log    ${retorno}

    [return]    ${resp}

#Consultar documentos exigidos para uma viagem
Consultar Documentos Exigidos

    [Arguments]    ${user_token}    ${id_viagem}

    &{headers}=    Create Dictionary    Content-Type=application/json                     Authorization=${user_token}
    ${resp}=       Get Request          hook    /api/documentacoesViagem${id_viagem}    headers=${headers}    

    ${retorno}=    Convert To String    ${resp.json().get("isSucesso")}

    Log    ${retorno}

    [return]    ${resp}

#Consultar um código de barras para pagamento
Consultar Código de Barras
  
    [Arguments]    ${user_token}    ${codigo_barras}

    &{headers}=    Create Dictionary    Content-Type=application/json                                              Authorization=${user_token}
    ${resp}=       Get Request          hook    /api/PagamentoContas/consultar/codigoDeBarras${codigo_barras}    headers=${headers}    

    ${retorno}=    Convert To String    ${resp.json().get("isSucesso")}

    Log    ${retorno}

    [return]    ${resp}

#Consultar uma linha digitável para pagamento
Consultar Linha Digitável
  
    [Arguments]    ${user_token}    ${linha_digitavel}

    &{headers}=    Create Dictionary    Content-Type=application/json                                                Authorization=${user_token}
    ${resp}=       Get Request          hook    /api/PagamentoContas/consultar/linhaDigitavel${linha_digitavel}    headers=${headers}    

    ${retorno}=    Convert To String    ${resp.json().get("isSucesso")}

    Log    ${retorno}

    [return]    ${resp}

#Realiza o pagamento de um boleto de acordo com os parâmetros informados
Realizar Pagamento de Conta
  
    [Arguments]    ${json}    ${expect_message}    

    ${user_token}=    Get User Token       username    password
    ${payload}=       Convert To Json      ${json}
    &{headers}=       Create Dictionary    Content-Type=application/json            Accept=application/json       Authorization=${user_token}    
    ${resp}=          Post Request         hook                           /api/PagamentoContas/pagar            data=${payload}                headers=${headers}    
    ${ret_tel}=       Convert To String    ${resp.json().get("telefone")}
    ${sms_token}=     Convert To String    ${ret_tel.split("Token:")[-1].replace(")", "")}
    &{headers}=       Create Dictionary    Content-Type=application/json            Accept=application/json    Authorization=${user_token}    SMS-Token=${sms_token}
    ${payload}=       Convert To Json      ${json}
    ${resp}=          Post Request         hook     /api/PagamentoContas/pagar    data=${payload}            headers=${headers}    

    ${retorno}=        Convert To String    ${resp.json().get("isSucesso")}
    ${comprovante}=    Convert To String    ${resp.json().get("resultado")}

    Log    ${retorno}
    Log    ${comprovante}

    Should Be Equal As Strings    ${retorno}    ${expect_message}
    [return]                      ${resp}

#Consultar o conteúdo de um termo por id
Consultar Termo por Id
  
    [Arguments]    ${user_token}    ${id_termo}

    &{headers}=    Create Dictionary    Content-Type=application/json                   Authorization=${user_token}
    ${resp}=       Get Request          hook    /api/termosUso/consulta${id_termo}    headers=${headers}    

    ${retorno}=    Convert To String    ${resp.json().get("isSucesso")}

    Log    ${retorno}

    [return]    ${resp}

#Consultar os termos aceitos
Consultar Termos Aceitos

    [Arguments]    ${user_token}    ${tipo_termo}

    &{headers}=    Create Dictionary    Content-Type=application/json                            Authorization=${user_token}
    ${resp}=       Get Request          hook   /api/termosUso/consulta${tipo_termo}/aceito    headers=${headers}    

    ${retorno}=    Convert To String    ${resp.json().get("isSucesso")}

    Log    ${retorno}

    [return]    ${resp}

#Consultar os termos pendentes de aceite
Consultar Termos Pendentes de Aceite
  
    [Arguments]    ${user_token}    ${CPF}

    &{headers}=    Create Dictionary    Content-Type=application/json                   Authorization=${user_token}
    ${resp}=       Get Request          hook    /api/termosUso/pendencia?cpf${CPF}    headers=${headers}    

    ${retorno}=    Convert To String    ${resp.json().get("isSucesso")}

    Log    ${retorno}

    [return]    ${resp}

#Consultar as versões dos termos vigentes
Consultar Termos Vigentes
  
    [Arguments]    ${user_token}    ${tipo_termo}

    &{headers}=    Create Dictionary    Content-Type=application/json                        Authorization=${user_token}
    ${resp}=       Get Request          hook    /api/termosUso/versaoAtual${tipo_termo}    headers=${headers}    

    ${retorno}=    Convert To String    ${resp.json().get("isSucesso")}

    Log    ${retorno}

    [return]    ${resp}

#Aceitar termo de uso e politicas de privacidade enviando informações válidas
Aceite de Termos e Política

    [Arguments]    ${user_token}    ${payload}

    &{headers}=    Create Dictionary    Content-Type=application/json             Accept=application/json    Authorization=${user_token} 
    ${resp}=       Post Request         hook    /api/termosUso/aceitarTermos    data=${payload}            headers=${headers}

    ${retorno}=    Convert To String    ${resp.json().get("isSucesso")}

    Log    ${retorno} 

    [return]    ${resp}

#Aceitar termo de uso e politicas de privacidade enviando informações válidas
Recusar de Termos e Política

    [Arguments]    ${user_token}    ${payload}

    &{headers}=    Create Dictionary    Content-Type=application/json             Accept=application/json    Authorization=${user_token} 
    ${resp}=       Post Request         hook    /api/termosUso/recusarTermos    data=${payload}            headers=${headers}

    ${retorno}=    Convert To String    ${resp.json().get("isSucesso")}

    Log    ${retorno} 

    [return]    ${resp}


#Registra informações do usuário do app e seu dispositivo
Informações do Usuário

    [Arguments]       ${json}           ${expect_message}    
   
    ${user_token}=    Get User Token       username          password
    &{headers}=       Create Dictionary    Content-Type=application/json                   Accept=application/json    Authorization=${user_token} 
    ${payload}=       Convert To Json      ${json}
    ${resp}=          Post Request         hook    api/usuarios/informacoesUsuarioApp    data=${payload}            headers=${headers}

    ${retorno}=       Convert To String    ${resp.json().get("isSucesso")}

    Log    ${retorno} 

    Should Be Equal As Strings    ${retorno}    ${expect_message}

    [return]    ${resp}

#Enviar uma avaliação inválida
Informações do Usuário Inválida
  
    [Arguments]       ${json}           ${expect_message}    ${erro}    ${erro2}    ${erro3}
  
    ${user_token}=  Get User Token       username          password
    &{headers}=     Create Dictionary    Content-Type=application/json                   Accept=application/json    Authorization=${user_token} 
    ${payload}=     Convert To Json      ${json}
    ${resp}=        Post Request         hook    api/usuarios/informacoesUsuarioApp    data=${payload}            headers=${headers}

    ${retorno}=     Convert To String    ${resp.json().get("isSucesso")}
    ${erro}=        Convert To String    ${resp.json().get("erros")}

    :FOR    ${item}    IN    @{resp.json().get("erros")}
    \                             Log             ${item}
    \                             ${codigo}=      Set variable             ${item['codigo']}
    \                             ${mensagem}=    Set variable             ${item['mensagem']}
    \                             Log             ${codigo},${mensagem}
    Should Be Equal As Strings    ${retorno}      ${expect_message}        ${erro}                ${erro2}    ${erro3}    
    Log                           ${retorno}      
    Log                           ${erro}

    [return]    ${resp}

#Consultar os termos pendentes de aceite atulizados
Consultar Termos Pendentes Atualizados 
  
    [Arguments]    ${user_token}    

    &{headers}=    Create Dictionary    Content-Type=application/json                      Authorization=${user_token}
    ${resp}=       Get Request          hook    /api/termosUso/pendencia/atualizacao     headers=${headers}    

    ${retorno}=    Convert To String    ${resp.json().get("isSucesso")}

    Log    ${retorno}

    [return]    ${resp}

#Consultar informações do usuário logado
Consultar Informações do Usuário Logado

    [Arguments]     ${user_token}

    &{headers}=     Create Dictionary    Content-Type=application/json              Authorization=${user_token}
    ${resp}=        Get Request          hook    /api/usuarios/infointerno        headers=${headers}

    ${retorno}=     Convert To String    ${resp.json().get("isSucesso")}

    Log     ${retorno}

    [return]    ${resp}

#Consultar o status das funcionalidades disponíveis no sistema
Consultar Funcionalidades Disponíveis 

    [Arguments]     ${user_token}

    &{headers}=     Create Dictionary    Content-Type=application/json                               Authorization=${user_token}
    ${resp}=        Get Request          hook    /api/gerenciamentoFuncionalidades/consultar       headers=${headers}

    ${retorno}=     Convert To String    ${resp.json().get("isSucesso")}

    Log     ${retorno}

    [return]    ${resp}

#Consultar o status das funcionalidades disponíveis no sistema
Consultar Valores de Transferência

    [Arguments]     ${user_token}   ${origem_saldo}

    &{headers}=     Create Dictionary    Content-Type=application/json                               Authorization=${user_token}
    ${resp}=        Get Request          hook   /api/interna/cartoes${origem_saldo}/tarifa         headers=${headers}

    ${retorno}=     Convert To String    ${resp.json().get("isSucesso")}

    Log     ${retorno}

    [return]    ${resp}

#Consultar extrato do cartão hook informando o número do cartão, cpf e datas de inicio e fim
Extrato Cartão hook
    
    [Arguments]     ${user_token}   ${cartao}   ${CPF}  ${data_inicial}  ${data_final}

    &{headers}=     Create Dictionary    Content-Type=application/json                                                                                                             Authorization=${user_token}
    ${resp}=        Get Request          hook   /api/interna/cartoes/extrato?NumeroCartaohook${cartao}&CPFCNPJ${CPF}&DataInicial${data_inicial}&DataFinal${data_final}         headers=${headers}

    ${retorno}=     Convert To String    ${resp.json().get("isSucesso")}

    Log     ${retorno}

    [return]    ${resp}

#Consultar extrato do cartão Visa informando o número do cartão, cpf e datas de inicio e fim
Extrato Cartão Visa
    
    [Arguments]     ${user_token}   ${cartao}   ${CPF}  ${data_inicial}  ${data_final}

    &{headers}=     Create Dictionary    Content-Type=application/json                                                                                                             Authorization=${user_token}
    ${resp}=        Get Request          hook   /api/interna/cartoes/extrato?NumeroCartaohook${cartao}&CPFCNPJ${CPF}&DataInicial${data_inicial}&DataFinal${data_final}         headers=${headers}

    ${retorno}=     Convert To String    ${resp.json().get("isSucesso")}

    Log     ${retorno}

    [return]    ${resp}

#Consultar saldo hook e Visa do usuário logado
Saldo Cartão
    
    [Arguments]     ${user_token}  

    &{headers}=     Create Dictionary    Content-Type=application/json            Authorization=${user_token}
    ${resp}=        Get Request          hook   /api/interna/cartoes/me         headers=${headers}

    ${retorno}=     Convert To String    ${resp.json().get("isSucesso")}

    Log     ${retorno}

    [return]    ${resp}

#Consultar tarifas dos serviços hook
Consultar Tarifas 
    
    [Arguments]     ${user_token}  

    &{headers}=     Create Dictionary    Content-Type=application/json                Authorization=${user_token}
    ${resp}=        Get Request          hook   /api/interna/cartoes/tarifas        headers=${headers}

    ${retorno}=     Convert To String    ${resp.json().get("isSucesso")}

    Log     ${retorno}

    [return]    ${resp}

#Realizar transferências únicas ou multiplas
Relizar Transferências Múltiplas 
    
    [Arguments]       ${json}           ${expect_message}    
  
    ${user_token}=    Get User Token       username          password
    &{headers}=       Create Dictionary    Content-Type=application/json                  Accept=application/json               Authorization=${user_token} 
    ${payload}=       Convert To Json      ${json}
    ${resp}=          Post Request         hook    /api/interna/cartoes/982806069885/transferencia    data=${payload}         headers=${headers}

    ${retorno}=       Convert To String    ${resp.json().get("isSucesso")}

    Log To Console   ${retorno} 