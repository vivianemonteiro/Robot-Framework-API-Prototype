*** Settings ***
Resource    ../../../resources/services.robot

Test Setup    Create Session    hook    ${base_url}    verify=${True}

*** Test Cases ***

#Usuário e senha válidos
Realizar Login de um Usuário Válido
   
    ${resp}=     Post Session           username     password    
   
    Should Be Equal As Strings    ${resp.status_code}    200

#Usuário inválido senha válida
Realizar Login com Usuário Inválido e Senha Válida 
  
    ${resp}=    Post Session           username      password

    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.text}      {"error":"invalid_grant","error_description":"The user name or password is incorrect."}

#Usuário válido senha inválida
Realizar Login com Usuário Válido e Senha Inválida 
   
    ${resp}=    Post Session           username      password

    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.text}      {"error":"invalid_grant","error_description":"The user name or password is incorrect."}

#Usuário e senha em branco
Realizar Login sem Informar Usuário e Senha
    
    ${resp}=    Post Session           ${EMPTY}       ${EMPTY} 

    Should Be Equal As Strings    ${resp.status_code}    400
    Should Be Equal As Strings    ${resp.text}      {"error":"invalid_grant","error_description":"The user name or password is incorrect."}
