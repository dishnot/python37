*** Settings ***
Resource          ../公共目录/配置信息/环境配置信息.robot
Library           JSONLibrary

*** Keywords ***
融资融券协议查询_10321004
    [Arguments]    ${资金账户}=${资金账户_全局变量}    ${货币代码}=${货币代码_全局变量}
    [Documentation]    1.20230104 ch 新增
    ${resp}    POST接口下单请求_UTP数据银行    10321004    "CUACCT_CODE": "${资金账户}","CURRENCY":"${货币代码}"    融资融券协议查询
    log    ${resp}
    ${返回码}    set variable    ${resp[0]["data"][0]}
    ${返回信息}    set variable    ${resp[0]["data"][1]}
    [Return]    ${返回码}    ${返回信息}
