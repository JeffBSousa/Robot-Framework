*** Settings ***
Library    SeleniumLibrary 

*** Variables ***
${URL}                         https://www.amazon.com.br/
${MENU ELETONICOS}             //a[@href='/Eletronicos-e-Tecnologia/b/?ie=UTF8&node=16209062011&ref_=nav_cs_electronics'][contains(.,'Eletrônicos')]
${BARRA_PESQUISA}              //input[contains(@type,'text')]
${Botao_PESQUISA}              //input[contains(@type,'submit')]  
${PRODUTO}                     Xbox Series S   
*** Keywords ***
 Abrir o navegador
     Open Browser    browser=chrome     options=add_experimental_option("detach", True)

     Maximize Browser Window


Fechar o navegador
    Capture Page Screenshot
    Close Browser

Acessar a home page do site Amazon.com.br
    Go To                            url=${URL}
    Wait Until Element Is Visible    locator=${MENU ELETONICOS}

Entrar no menu "Eletrônicos"
    Click Element    locator=${MENU ELETONICOS}

Verificar se aparece a frase "${FRASE}"
    Wait Until Page Contains        text=${FRASE}

Verificar se o título da página fica "${TITULO}"
    Title Should Be    title=${TITULO}

Verificar se aparece a categoria "${CATEGORIA_NOME}"
    Element Should Be Visible    locator=//span[@class='nav-a-content'][contains(.,'Computadores e Informática')]

 Digitar o nome de produto "${PRODUTO}" no campo de pesquisa
    Input Text    locator=${BARRA_PESQUISA}     text=${PRODUTO}

Clicar no botão de pesquisa
    Click Button    locator=${Botao_PESQUISA} 

Verificaro resultado da pesquisa, listando o produto pesquisado
     Wait Until Page Contains        text="Xbox Series S"
Verificar o resultado da pesquisa se está listando o produto "${PRODUTO}"
    Acessar a home page do site Amazon.com.br
    Input Text    locator=${BARRA_PESQUISA}     text=${PRODUTO}
    Click Button    locator=${Botao_PESQUISA}
    Verificaro resultado da pesquisa, listando o produto pesquisado
Adicionar o produto "Xbox Series S" no carrinho
    Click Element    locator=(//a[contains(.,'Xbox Series S')])[3]
    Wait Until Element Is Visible  locator=//span[@class='a-size-large product-title-word-break'][contains(.,'Console Xbox Series S')]
    Click Button    locator=//input[contains(@name,'submit.add-to-cart')]
    

Verificar se o produto "${PRODUTO}" foi adicionado com sucesso
    Click Element    locator=//a[contains(@class,'nav-logo-link nav-progressive-attribute')]
    Click Element   locator=//a[@href='/gp/cart/view.html?ref_=nav_cart']
    Wait Until Page Contains        text=${PRODUTO}

 Dado que estou na home page da Amazon.com.br
     Acessar a home page do site Amazon.com.br
     Digitar o nome de produto "${PRODUTO}" no campo de pesquisa
     Clicar no botão de pesquisa
     Verificar o resultado da pesquisa se está listando o produto "${PRODUTO}"
     Adicionar o produto "Xbox Series S" no carrinho
     

E existe o produto "Console Xbox Series S" no carrinho
    Verificar se o produto "${PRODUTO}" foi adicionado com sucesso
Quando remover o produto "Console Xbox Series S" do carrinho
    Click Element  locator=(//span[contains(@class,'a-icon a-icon-small-trash')])[1]
    
 Então o carrinho deve ficar vazio   
    Wait Until Page Contains    text="foi removido"
    
     