*** Settings ***
Library           String

*** Variables ***
@{深圳_资金_金证}       88859575    10888427    10888476    79151001
@{上海_资金_金证}       10888476    10888433    10888677    10888459

*** Keywords ***
账户信息_全局变量
    ${取最后一位}    Get Substring    ${CUST_MODE}    -1
    ${资金账户}    Run Keyword If    '0P'in '${CUST_MODE}'    Set Variable    @{深圳_资金_金证}
    ...    ELSE IF    '1P'in '${CUST_MODE}'    Set Variable    @{上海_资金_金证}
    ${资金账户_全局变量}    Run Keyword    Convert To String    ${资金账户[${取最后一位}]}
    Set Global Variable    ${资金账户_全局变量}
    [Return]    ${资金账户_全局变量}
