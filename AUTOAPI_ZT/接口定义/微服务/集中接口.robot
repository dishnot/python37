*** Settings ***
Library           JSONLibrary
Resource          ../../公共目录/配置信息/环境配置信息.robot
Resource          ../../公共目录/通用操作/常用关键字.robot
Resource          ../../公共目录/配置信息/TSP环境配置信息.robot
Resource          ../../公共目录/配置信息/POST接口调用.robot
Resource          ../../公共目录/配置信息/接口入参数据.robot

*** Keywords ***
502资金查询
    [Arguments]    ${url}    ${uri}
    ${入参数据}    set variable    "user_code":"${TSP客户号}"
    ${resp}    POST接口请求_WFW    ${url}    ${uri}    ${入参数据}
    log    ${resp}
    ${返回码}    set variable    ${resp[0]["code"]}
    ${返回信息}    set variable    ${resp[0]["data"][0]}
    #${返回信息}    Get Value From Json    ${resp}    $..data[1][?(@.STKPBU=="${客户信息['STKPBU']}")]
    [Return]    ${返回码}    ${返回信息}
