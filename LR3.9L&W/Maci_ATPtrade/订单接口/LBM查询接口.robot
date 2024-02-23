*** Settings ***
Resource          ../公共目录/配置信息/环境配置信息.robot
Library           DateTime

*** Keywords ***
公司担保品查询_10321010
    [Arguments]    ${证券代码}=${证券代码_全局变量}
    [Documentation]    1.20211123 chm 新增
    ${unfixpram}    Set Variable    "STK_CODE":"${证券代码}"
    log    ${fixpram_全局变量}${unfixpram}
    ${resp}    POST接口下单请求_UTP数据银行    10321010    ${fixpram_全局变量}${unfixpram}
    ${MSG}    set variable    ${resp[0]["data"][0][0]}
    ${MSG_LEVEL}    set variable    ${resp[0]["data"][0][1][0]}
    ${MSG_TEXT}    set variable    ${resp[0]["data"][0][2][0]}
    [Return]    ${MSG}    ${MSG_LEVEL}    ${MSG_TEXT}
