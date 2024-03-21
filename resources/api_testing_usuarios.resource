*** Settings ***
Library   RequestsLibrary
Library   String
Library   Collections    

*** Keywords ***

Criar um usuário novo
    ${palavra_aleatoria}    Generate Random String     length=4   chars=[LETTERS]
    ${palavra_aleatoria}    Convert To Lower Case      ${palavra_aleatoria}  
    Set Test Variable    ${EMAIL_TEST}  ${palavra_aleatoria}@emaitest.com
    Log    ${EMAIL_TEST}

Cadastrar o usuario criado na ServeRest
    [Arguments]  ${email}  ${status_code_desejado}
    ${body}     Create Dictionary  
    ...  nome=Weslley da Silva  
    ...  email=${email}  
    ...  password=47007  
    ...  administrador=true                   
    Log    ${body}

    Cria sessão na ServeRest

    ${resposta}        POST On Session    
    ...                alias=ServeRest
    ...                url=/usuarios
    ...                json=${body}
    ...                expected_status=${status_code_desejado} 
    log  ${resposta.json()}
    Set Test Variable    ${RESPOSTA}  ${resposta.json()}
    
Cria sessão na ServeRest
    ${headers}    Create Dictionary    
    ...        accept=application/json   
    ...        Content-type=application/json      
    Create Session    
    ...        alias=ServeRest    
    ...        url=https://serverest.dev
    ...        headers=${headers}         
Conferir se o usuário foi cadastrado corretamente
    log  ${RESPOSTA}
    Dictionary Should Contain Item    ${RESPOSTA}  message  Cadastro realizado com sucesso
    Dictionary Should Contain Key    ${RESPOSTA}    _id

Vou repetir o cadastro do usuário  
    Cadastrar o usuario criado na ServeRest      email=${EMAIL_TEST}   status_code_desejado=400

Verificar se a API não permitiu o cadastro repetido
    Dictionary Should Contain Item    ${RESPOSTA}    message    Este email já está sendo usado