*** Settings ***
Library           String
Library           Collections
Library           DatabaseLibrary

*** Keywords ***
请求状态检查
    [Arguments]    ${resp}=${None}
    ${resp}    Set Variable    ${resp}
    ${请求状态}    Convert To String    ${resp.status_code}
    ${断言结果}    Run KeyWord If    '${请求状态}'=='200'    Set Variable    PASS
    ...    ELSE    环境异常，请检查！！！
    [Return]    ${断言结果}
