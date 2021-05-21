*** Keywords ***

# Helpers
Convert To Json

    [Arguments]    ${target}

    ${result}=    evaluate     json.loads($target)    json
    [return]      ${result}