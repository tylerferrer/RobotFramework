*** Settings ***
Documentation       Recursos principais

Library             SeleniumLibrary
Library             OperatingSystem
Library             Process
Library             ./lib/evidencia.py    AS    evidencia
Resource            .//action/portal.resource


*** Keywords ***
Iniciar Execução
    [Arguments]    ${pagina}
    Open Browser    url=${pagina}    browser=chrome
    Maximize Browser Window

Finalizar Execução
    Close Browser
    # Run Process    python   ./lib/evidencia.py 
