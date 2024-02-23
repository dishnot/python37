*** Settings ***
Resource          ../../sql文件配置.robot
Resource          ../../公共目录/配置信息/环境配置信息.robot
Resource          ../../公共目录/数据配置/交易信息.robot
Resource          ../../业务流程/交易流程_公共/业务流程.robot

*** Test Cases ***
深港通标的范围委托成功_深港通委托成功_港股通买入标的范围内的深港通股票成功_全成
    用例模式
    Run KeyWord If    '${用例首字段}' in ('03','13')    港股通交易委托流程
    ...    ELSE    sqltest港股通交易委托流程

深港通标的范围委托成功_深港通委托成功_港股通卖出标的范围内的深港通股票成功_全成
    用例模式
    Run KeyWord If    '${用例首字段}' in ('03','13')    港股通交易委托流程
    ...    ELSE    sqltest港股通交易委托流程

深港通标的范围委托成功_深港通委托成功_港股通卖出标的范围外的深港通股票成功_全成
    用例模式
    Run KeyWord If    '${用例首字段}' in ('03','13')    港股通交易委托流程
    ...    ELSE    sqltest港股通交易委托流程
