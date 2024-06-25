*** Settings ***
Documentation       Ações para o portal

Library             SeleniumLibrary


*** Variables ***
# Trocar seletores por um de cada
${pagina}                   https://www.advantageonlineshopping.com/#/
${speaker}                  id=speakersTxt
${bose}                     xpath=//*/div/div/div[2]/ul/li[2]
${botao_locator}            xpath=//*[@id="productProperties"]/div[2]/e-sec-plus-minus/div/div[3]
${index}    1
${evidencia_teste}          ${OUTPUT_DIR}/screenshot/Evidencia_Portal_{index:02}.png
${adicionar_ao_carrinho}    xpath=//*[@id="productProperties"]/div[4]/button
${dropDownCart}             checkOutPopUp
${shoppingCart}             xpath=/html/body/div[3]/section/article/h3
${checkoutButton}           check_out_btn
${newUser}                  css=h3[class="roboto-regular sticky fixedImportant ng-scope"]
${registrationButton}       xpath=//*[@id="registration_btn"]
${createAccount}            css=h3[class="roboto-regular sticky fixedImportant ng-scope"]
&{dados_pessoais}
...                         username= SrTeste159
...                         email= testedasilva@teste.com
...                         senha= Qwe123
...                         confirmacao= Qwe123
...                         nome= Teste
...                         sobrenome= da Silva
...                         celular= 11999999999
...                         cidade= São Paulo
...                         rua= Rua da Baderna
...                         estado= SP
...                         cep= 000000
...                         numero_cartao= 123412341234
...                         cvv= 546
...                         nome_cartao= Teste
${input_username}           usernameRegisterPage
${input_email}              emailRegisterPage
${input_pass}               passwordRegisterPage
${input_confir}             confirm_passwordRegisterPage
${input_name}               first_nameRegisterPage
${input_lastname}           last_nameRegisterPage
${input_phone}              phone_numberRegisterPage
${input_city}               cityRegisterPage
${input_address}            addressRegisterPage
${input_state}              //*[@id="formCover"]/div[3]/div[2]/sec-view[2]/div/input
${input_postal}             postal_codeRegisterPage
${selecionar_pais}          countryListboxRegisterPage
${agree}                    i_agree
${register_button}          id=register_btn
${payment_order}            xpath=/html/body/div[3]/section/article/h3
${itens_carrinho}           xpath=//*[@id="userCart"]/span
${carrinho}                 xpath=//*[@id="detailslink"]/label[1]
${next_button}              id=next_btn
${selecione_pagamento}      xpath=//*[@id="paymentMethod"]/div/label
${pagamento_master}         xpath=//*[@id="paymentMethod"]/div/div[1]/div[2]/img
${pagamento_safepay}        safepay
${select_mes}               xpath=//*[@id="paymentMethod"]/div/div[4]/sec-form/div[2]/div/sec-view[1]/div/select
${select_ano}               xpath=//*[@id="paymentMethod"]/div/div[4]/sec-form/div[2]/div/sec-view[2]/div/select
${input_numero_cartao}      card_number
${input_cvv}                xpath=/html/body/div[3]/section/article/div[1]/div[1]/div/div[3]/div/div[4]/sec-form/div[1]/sec-view[2]/div/input
${input_card_holder}        cardholder_name
${paynow}                   xpath=/html/body/div[3]/section/article/div[1]/div[1]/div/div[3]/div/div[4]/sec-form/div[4]/label/sec-sender/button
${sucesso_pagamento}        css=span[translate="Thank_you_for_buying_with_Advantage"]
${tracking_number}          id:trackingNumberLabel


*** Keywords ***
Validar tela principal
    Wait Until Element Is Visible    ${speaker}    timeout=60
    Click Element    ${speaker}
    Capture Page Screenshot    ${evidencia_teste}

Selecionar produto
    Wait Until Element Is Visible    ${bose}
    Click Element    ${bose}
    Capture Page Screenshot    ${evidencia_teste}

Adicionar 5 produtos no carrinho
    Wait Until Element Is Visible    ${botao_locator}
    FOR    ${i}    IN RANGE    4
        Click Element    ${botao_locator}
        Log    ${botao_locator}
    END
    Capture Page Screenshot    ${evidencia_teste}
    Click Button    ${adicionar_ao_carrinho}

Acessar carrinho
    Wait Until Element Is Visible    ${dropDownCart}    timeout=2000
    Click Element    xpath=//*[@id="checkOutPopUp"]
    Wait Until Element Is Visible    ${shoppingCart}    timeout=60
    Click Button    ${checkoutButton}
    Capture Page Screenshot    ${evidencia_teste}

É Novo usuário?
    ${elemento_visivel}    Run Keyword And Return Status    Element Should Be Visible    ${newUser}
    IF    ${elemento_visivel}
        Wait Until Element Is Visible    ${registrationButton}    timeout=60
        Click Button    ${registrationButton}
    ELSE
        Log    Você já possui uma conta
    END
    Element Should Be Visible    ${createAccount}
    Capture Page Screenshot    ${evidencia_teste}

Usuário
    Wait Until Element Is Visible    ${input_username}    timeout=60
    Input Text    ${input_username}    ${dados_pessoais}[username]
    Input Text    ${input_email}    ${dados_pessoais}[email]
    Input Text    ${input_pass}    ${dados_pessoais}[senha]
    Input Text    ${input_confir}    ${dados_pessoais}[confirmacao]
    Capture Page Screenshot    ${evidencia_teste}

Dados Pessoais
    Input Text    ${input_name}    ${dados_pessoais}[nome]
    Input Text    ${input_lastname}    ${dados_pessoais}[sobrenome]
    Input Text    ${input_phone}    ${dados_pessoais}[celular]
    Capture Page Screenshot    ${evidencia_teste}

Endereço
    Select From List By Label    ${selecionar_pais}    Brazil
    Input Text    ${input_city}    ${dados_pessoais}[cidade]
    Input Text    ${input_address}    ${dados_pessoais}[rua]
    Input Text    ${input_state}    ${dados_pessoais}[estado]
    Input Text    ${input_postal}    ${dados_pessoais}[cep]
    Capture Page Screenshot    ${evidencia_teste}

Aceitar
    Select Checkbox    ${agree}
    ${selecionado}    Checkbox Should Be Selected    ${agree}
    Click Button    ${register_button}
    Capture Page Screenshot    ${evidencia_teste}

Quanto Estou Comprando?
    Wait Until Element Is Visible    ${carrinho}    timeout=60
    ${quantidade}    Get Text    ${itens_carrinho}
    Capture Page Screenshot    ${evidencia_teste}
    Log    ${quantidade}
    IF    "${quantidade}=='5'"
        Click Button    ${next_button}
    ELSE
        Log    Você precisa de 5 itens no carrinho para continuar.
    END

Selecionar Pagamento
    Wait Until Element Is Visible    ${selecione_pagamento}    timeout=60
    ${cartao_credito}    Get Element Attribute    ${pagamento_master}    checked
    ${outro_metodo}    Get Element Attribute    ${pagamento_safepay}    checked
    IF    "${outro_metodo}" == "true"
        Click Image    ${pagamento_master}
    ELSE
        Log    O pagamento Crédito já está selecionado.
    END
    Capture Page Screenshot    ${evidencia_teste}

Preencher Dados de Pagamento
    Wait Until Element Is Visible    ${input_numero_cartao}
    Input Text    ${input_cvv}    ${dados_pessoais}[cvv]
    Select From List By Label    ${select_mes}    02
    Select From List By Label    ${select_ano}    2025
    Input Text    ${input_card_holder}    ${dados_pessoais}[nome_cartao]
    Input Text    ${input_numero_cartao}    ${dados_pessoais}[numero_cartao]
    Capture Page Screenshot    ${evidencia_teste}
    Click Button    ${paynow}

Pagamento Realizado com Sucesso
    Wait Until Element Is Visible    ${sucesso_pagamento}    timeout=60
    Capture Page Screenshot    ${evidencia_teste}
    ${sucesso}    Get Text    ${sucesso_pagamento}
    ${rastreio}    Get Text    ${tracking_number}
    Should Be Equal    ${sucesso}    Thank you for buying with Advantage
    Should Not Be Empty    ${rastreio}
    Length Should Be    ${rastreio}    10
