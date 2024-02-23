*** Settings ***
Resource          ../../sql文件配置.robot
Resource          ../../公共目录/配置信息/环境配置信息.robot
Resource          ../../公共目录/数据配置/交易信息.robot
Resource          ../../业务流程/交易流程_公共/业务流程.robot

*** Test Cases ***
深港通交易日历校验委托成功_深港通委托成功_交易日深市港股买入成功_全成
    用例模式
    Run KeyWord If    '${用例首字段}' in ('03','13')    港股通交易委托流程
    ...    ELSE    sqltest港股通交易委托流程

深港通交易日历校验委托成功_深港通委托成功_交易日深市港股卖出成功_全成
    用例模式
    Run KeyWord If    '${用例首字段}' in ('03','13')    港股通交易委托流程
    ...    ELSE    sqltest港股通交易委托流程
