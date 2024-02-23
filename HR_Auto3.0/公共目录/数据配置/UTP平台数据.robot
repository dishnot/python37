*** Settings ***
Library           RequestsLibrary
Resource          ../通用操作/常用关键字.robot
Resource          ../配置信息/环境配置信息.robot
Library           DatabaseLibrary
Library           demjson

*** Keywords ***
获取token
    ${返回}    POST环境请求_UTP登录    http://utp.ciccwm.com/public/login/    {"auth_type":"other","username":"chenhui2"}
    ${token}    Set Variable    ${返回}[data][token]
    Set Global Variable    ${token}
