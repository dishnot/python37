*** Settings ***
Library           String

*** Variables ***
@{深圳_客户_华锐}       20324410    34325778    10011592    20351790
@{上海_客户_华锐}       10000027    10000091    20011631    20011633

*** Keywords ***
账户信息_全局变量
    [Documentation]    1.20211123 chm 新增
    ${接口类型_全局变量}    Run Keyword If    '${TEST_ENV}'in \ ('123','223','188','123_new','223_new','188_new','77')    Set Variable    Cash
    Set Global Variable    ${接口类型_全局变量}
    ${接口类型}    Set Variable    ${接口类型_全局变量}
    ${取最后一位}    Get Substring    ${CUST_MODE}    -1
    ${客户号_华锐}    Run Keyword If    '0P'in '${CUST_MODE}' and '${接口类型}'=='Cash'    Set Variable    @{深圳_客户_华锐}
    ...    ELSE IF    '1P'in '${CUST_MODE}'and '${接口类型}'=='Cash'    Set Variable    @{上海_客户_华锐}
    ${客户代码_全局变量}    Run Keyword If    '${接口类型}'=='Cash'    Convert To String    ${客户号_华锐[${取最后一位}]}
    Set Global Variable    ${客户代码_全局变量}
    [Return]    ${客户代码_全局变量}
