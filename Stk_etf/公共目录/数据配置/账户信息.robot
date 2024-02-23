*** Settings ***
Library           String

*** Variables ***
@{深圳_资金_金证}       10888504    85024604    85024604    10888460
@{上海_资金_金证}       88850238    10864583    88850238

*** Keywords ***
账户信息_全局变量
    [Documentation]    1.20211123 chm 新增
    ${接口类型_全局变量}    Run Keyword If    '${TEST_ENV}'in \ ('66','47','27','78','67','209')    Set Variable    Stk
    Set Global Variable    ${接口类型_全局变量}
    ${接口类型}    Set Variable    ${接口类型_全局变量}
    ${取最后一位}    Get Substring    ${CUST_MODE}    -1
    ${资金账户_金证}    Run Keyword If    '0P'in '${CUST_MODE}' and '${接口类型}'=='Stk'    Set Variable    @{深圳_资金_金证}
    ...    ELSE IF    '1P'in '${CUST_MODE}'and '${接口类型}'=='Stk'    Set Variable    @{上海_资金_金证}
    ${资金账户_全局变量}    Run Keyword If    '${接口类型}'=='Stk'    Convert To String    ${资金账户_金证[${取最后一位}]}
    Set Global Variable    ${资金账户_全局变量}
    [Return]    ${资金账户_全局变量}
