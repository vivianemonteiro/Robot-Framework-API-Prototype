*** Settings ***
Library     SeleniumLibrary

*** Variables ***
${base_url}      https://siteadresshere 

*** Keywords ***
Start Session
    Open Browser                about:blank  chrome
    Set Selenium Implicit Wait  5

End Session
    Close Browser

End Test
    Capture Page Screenshot
    