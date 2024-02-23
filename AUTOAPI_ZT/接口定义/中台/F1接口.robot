*** Settings ***
Resource          ../../公共目录/配置信息/环境配置信息.robot
Resource          ../../公共目录/通用操作/常用关键字.robot
Resource          ../../公共目录/配置信息/TSP环境配置信息.robot
Resource          ../../公共目录/配置信息/POST接口调用.robot

*** Keywords ***
F10301105_客户登录
    [Arguments]    ${资金账户}=${资金账户_全局变量}
    ${resp}    POST接口请求_ZT    ${url}    ${uri}    "account": "${资金账户}","opUser":"${操作用户代码}"
    log    ${resp}
    ${返回码}    set variable    ${resp[code]}
    ${返回信息}    Get Value From Json    ${resp[]}
    #${返回信息}    Get Value From Json    ${resp}    $..data[1][?(@.STKPBU=="${客户信息['STKPBU']}")]
    [Return]    ${返回码}    ${返回信息}
