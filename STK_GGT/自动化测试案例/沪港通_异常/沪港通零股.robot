*** Settings ***
Resource          ../../sql文件配置.robot
Resource          ../../公共目录/配置信息/环境配置信息.robot
Resource          ../../公共目录/数据配置/交易信息.robot
Resource          ../../业务流程/交易流程_公共/业务流程.robot

*** Test Cases ***
沪港通零股委托异常_沪港通委托异常_沪港通买入零股失败_无状态
    用例模式
    Run KeyWord If    '${用例首字段}' in ('03','13')    港股通交易委托流程
    ...    ELSE    sqltest港股通交易委托流程

沪港通零股委托异常_沪港通委托异常_不存在小于港股整手数的持仓,零股卖出失败_无状态
    用例模式
    Run KeyWord If    '${用例首字段}' in ('03','13')    港股通交易委托流程
    ...    ELSE    sqltest港股通交易委托流程
