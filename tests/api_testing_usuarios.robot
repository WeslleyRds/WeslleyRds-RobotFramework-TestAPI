*** Settings ***
Resource     ../resources/api_testing_usuarios.resource

*** Variables ***

*** Test Cases ***

Caso de teste 01: Cadastrar um novo usuário na ServeRest
    Criar um usuário novo
    Cadastrar o usuario criado na ServeRest  email=${EMAIL_TEST}  status_code_desejado=201
    Conferir se o usuário foi cadastrado corretamente

Caso de teste 02: Cadastrar um usuário já existente
    Criar um usuário novo
    Cadastrar o usuario criado na ServeRest  email=${EMAIL_TEST}  status_code_desejado=201
    Vou repetir o cadastro do usuário  
    Verificar se a API não permitiu o cadastro repetido

