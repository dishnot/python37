*** Settings ***
Resource          ../../sql文件配置.robot
Resource          ../../公共目录/配置信息/环境配置信息.robot
Resource          ../../公共目录/数据配置/交易信息.robot
Resource          ../../业务流程/交易流程_公共/业务流程.robot

*** Test Cases ***
深港通交易遍历委托成功_深港通委托成功_买入全部使用主资金_废单
    用例模式
    Run KeyWord If    '${用例首字段}' in ('03','13')    港股通交易委托流程
    ...    ELSE    sqltest港股通交易委托流程

深港通交易遍历委托成功_深港通委托成功_买入全部使用二级台账资金_废单
    用例模式
    Run KeyWord If    '${用例首字段}' in ('03','13')    港股通交易委托流程
    ...    ELSE    sqltest港股通交易委托流程

深港通交易遍历委托成功_深港通委托成功_买入部分使用主资金_废单
    用例模式
    Run KeyWord If    '${用例首字段}' in ('03','13')    港股通交易委托流程
    ...    ELSE    sqltest港股通交易委托流程

深港通交易遍历委托成功_深港通委托成功_卖出全部归还主资金_废单
    用例模式
    Run KeyWord If    '${用例首字段}' in ('03','13')    港股通交易委托流程
    ...    ELSE    sqltest港股通交易委托流程

深港通交易遍历委托成功_深港通委托成功_卖出全部归还二级台账资金_废单
    用例模式
    Run KeyWord If    '${用例首字段}' in ('03','13')    港股通交易委托流程
    ...    ELSE    sqltest港股通交易委托流程

深港通交易遍历委托成功_深港通委托成功_卖出部分归还主资金_废单
    用例模式
    Run KeyWord If    '${用例首字段}' in ('03','13')    港股通交易委托流程
    ...    ELSE    sqltest港股通交易委托流程


