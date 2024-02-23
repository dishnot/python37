*** Settings ***
Resource          ../../公共目录/配置信息/环境配置信息.robot

*** Keywords ***
接口类型参数
    ${接口类型_全局变量}    Run Keyword If    '${TEST_ENV}'in \ ('69','210','83','125')    Set Variable    Fis
    Set Global Variable    ${接口类型_全局变量}
    ${接口类型}    Set Variable    ${接口类型_全局变量}
