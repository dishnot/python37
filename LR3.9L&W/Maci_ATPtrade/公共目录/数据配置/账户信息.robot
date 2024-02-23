*** Settings ***
Library           String

*** Variables ***
@{深圳_资金账户}        79197090    12988702    22978488    33827017    12988688    12988717    88878692    5878970    94897328
@{上海_资金账户}        94697159    32997362    94697111    8222110003    79197176    79197361    93397038    32997382    37994551    94697158    94697159

*** Keywords ***
账户信息_全局变量
    ${接口类型_全局变量}    Run Keyword If    '${TEST_ENV}'in \ ('125','69','83','210','204','206','210b','182','182x')    Set Variable    Fis
    Set Global Variable    ${接口类型_全局变量}
    ${接口类型}    Set Variable    ${接口类型_全局变量}
    ${取最后一位}    Get Substring    ${CUST_MODE}    -1
    ${资金账户}    Run Keyword If    '0P'in '${CUST_MODE}' and '${接口类型}'=='Fis'    Set Variable    @{深圳_资金账户}
    ...    ELSE IF    '1P'in '${CUST_MODE}'and '${接口类型}'=='Fis'    Set Variable    @{上海_资金账户}
    ${资金账户_全局变量}    Run Keyword If    '${接口类型}'=='Fis'    Convert To String    ${资金账户[${取最后一位}]}
    Set Global Variable    ${资金账户_全局变量}
    [Return]    ${资金账户_全局变量}
