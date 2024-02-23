*** Settings ***
Library           RequestsLibrary
Library           DatabaseLibrary
Library           demjson
Library           String
Library           Collections
Library           DateTime
Library           OperatingSystem
Resource          ../../公共目录/通用操作/常用关键字.robot
Resource          ../../业务流程/交易流程_公共/3-检查点流程/公共/计算该笔委托的值_取值计算录制模式.robot

*** Keywords ***
sql文件匹配
    [Arguments]    ${文件名}=${业务行为_全局变量}_${证券业务_全局变量}
    log    ${CURDIR}
    LOG    ${EXECDIR}
    ${xt}    Evaluate    sys.platform    sys
    ${路径}    Run KeyWord If    '${交易板块_全局变量}'=='00'    Set Variable    ETF深圳sql文件
    ...    ELSE IF    '${交易板块_全局变量}'=='10'    Set Variable    ETF上海sql文件
    ${file_path}    Set Variable IF    '${xt}'=='win32'    ${EXECDIR}\\${路径}\\${文件名}.sql    ${EXECDIR}/${路径}/${文件名}.sql
    [Return]    ${file_path}

sqltest委托入参数据处理
    [Arguments]    ${data}
    ${接口类型_全局变量}    Set Variable    Cash
    ${客户代码_全局变量}    Set Variable    ${data}[cust_id]
    ${资金账户_全局变量}    Set Variable    ${data}[fund_account_id]
    ${市场代码_全局变量}    EVALUATE    str(${data}[market_id])
    ${股东账户_全局变量}    Set Variable    ${data}[account_id]
    ${证券代码_全局变量}    Set Variable    ${data}[security_id]
    ${委托数量_全局变量}    EVALUATE    str(${data}[order_qty])
    ${证券业务_全局变量}    Set Variable    ${data}[side]
    ${业务行为_全局变量}    Set Variable    ${data}[order_type]
    ${分区号_全局变量}    Set Variable    ${data}[partition]
    ${委托价格_全局变量}    EVALUATE    str(${data}[price])
    ${number}    Set Variable    ${data}[number]
    Set Global Variable    ${客户代码_全局变量}
    Set Global Variable    ${资金账户_全局变量}
    Set Global Variable    ${市场代码_全局变量}
    Set Global Variable    ${股东账户_全局变量}
    Set Global Variable    ${证券代码_全局变量}
    Set Global Variable    ${委托数量_全局变量}
    Set Global Variable    ${证券业务_全局变量}
    Set Global Variable    ${委托价格_全局变量}
    Set Global Variable    ${接口类型_全局变量}
    Set Global Variable    ${业务行为_全局变量}
    Set Global Variable    ${分区号_全局变量}
    Set Global Variable    ${number}
