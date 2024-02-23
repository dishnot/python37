*** Settings ***
Resource          ../../公共目录/配置信息/环境配置信息.robot
Resource          ../../公共目录/通用操作/华锐数据库查询.robot

*** Keywords ***
环境连接
    ${接口类型_全局变量}    Run Keyword If    '${TEST_ENV}'in \ ('66','47','78','125','37','134')    Set Variable    Stk
    ...    ELSE IF    '${TEST_ENV}'in \ ('123','223','188')    Set Variable    Cash
    Set Global Variable    ${接口类型_全局变量}
    ${接口类型}    Set Variable    ${接口类型_全局变量}
    环境信息查询与连接
    Run KeyWord If    '${测试系统_全局变量}'=='ATP'    客户代码获取
    ${交易板块_全局变量}    Run KeyWord If    ${单双中心标志}==0    Set Variable    10
    Set Global Variable    ${交易板块_全局变量}
