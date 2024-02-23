*** Settings ***

*** KeyWords ***
字段转换
    [Arguments]    ${返回消息}
    LOG    ${返回消息}
    ${FUND_BLN}    Set Variable    ${返回消息[0]}[FUND_BLN]
    ${FUND_AVL}    Set Variable    ${返回消息[0]}[FUND_AVL]
    ${替换值}    Set Variable If    ${FUND_BLN}<=${FUND_AVL}    FUND_BLN    FUND_AVL
    [Return]    ${替换值}
