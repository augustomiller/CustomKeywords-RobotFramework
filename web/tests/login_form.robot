*** Settings ***
Resource        base.robot

Test Setup      Nova sessão
Test Teardown   Encerra sessão

*** Test Case ***
CN-1 Login realizado com sucesso
    Go To           ${url}/login
    Login With      stark       jarvis!

    Should see logged user      Tony Stark

CN-2 Senha inválida
    Go To           ${url}/login
    Login With      stark  123456

    Should contain login alert      Senha é invalida!

CN-3 Usuário não existe
    [tags]          login_user404
    Go To           ${url}/login
    Login With      what!       jarvis!

    Should contain login alert      O usuário informado não está cadastrado!

*** Keywords ***
# - Emcapsulando a funcionalidade de login dentro de uma CustomKeyWord
Login With
    [Arguments]     ${uname}        ${pass}

    Input text      css:input[name=username]        ${uname} 
    Input text      css:input[name=password]        ${pass}
    Click Element   class:btn-login

Should contain login alert
    [Arguments]     ${expect_message}

    ${message}=     Get WebElement      id:flash
    Should Contain  ${message.text}     ${expect_message}

Should see logged user
    [Arguments]     ${full_name}

    Page Should Contain     Olá, ${full_name}. Você acessou a área logada!
