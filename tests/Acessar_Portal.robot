*** Settings ***
Documentation       Acessar portal AdvantageShopping

Resource            ../resource/base.resource

Test Setup          Iniciar Execução    ${pagina}
Test Teardown       Finalizar Execução


*** Test Cases ***
Acessar página principal
    [Tags]    principal
    Validar tela principal
    Selecionar produto
    Adicionar 5 produtos no carrinho
    Acessar carrinho
    É Novo usuário?
    Usuário
    Dados Pessoais
    Endereço
    Aceitar
    Quanto Estou Comprando?
    Selecionar Pagamento
    Preencher Dados de Pagamento
    Pagamento Realizado com Sucesso