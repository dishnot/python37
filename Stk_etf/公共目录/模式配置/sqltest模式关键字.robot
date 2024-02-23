*** Settings ***
Library           RequestsLibrary
Library           DatabaseLibrary
Library           demjson
Library           String
Library           Collections
Library           DateTime
Library           OperatingSystem
Resource          ../../公共目录/通用操作/常用关键字.robot
Resource          ../../业务流程/交易流程_金证/1-初始化流程/通用初始化.robot
Resource          ../../业务流程/交易流程_金证/1-初始化流程/普通买卖交易.robot
Resource          ../../业务流程/交易流程_公共/3-检查点流程/公共/计算该笔委托的值_取值计算录制模式.robot

*** Keywords ***
sql文件匹配
    [Arguments]    ${文件名}=${行为_全局变量}_${证券业务_全局变量}
    log    ${CURDIR}
    LOG    ${EXECDIR}
    ${xt}    Evaluate    sys.platform    sys
    ${路径}    Run KeyWord If    '${交易板块_全局变量}'=='00'    Set Variable    ETF深圳sql文件
    ...    ELSE IF    '${交易板块_全局变量}'=='10'    Set Variable    ETF上海sql文件
    ${file_path}    Set Variable IF    '${xt}'=='win32'    ${EXECDIR}\\${路径}\\${文件名}.sql    ${EXECDIR}/${路径}/${文件名}.sql
    [Return]    ${file_path}

sqltest委托入参数据处理
    [Arguments]    ${data}
    ${接口类型_全局变量}    Set Variable    Stk
    ${客户代码_全局变量}    Set Variable    ${data}[CUST_CODE]
    ${资金账户_全局变量}    Set Variable    ${data}[CUACCT_CODE]
    ${交易板块_全局变量}    Set Variable    ${data}[STKBD]
    ${股东账户_全局变量}    Set Variable    ${data}[TRDACCT]
    ${证券代码_全局变量}    Set Variable    ${data}[STK_CODE]
    ${委托数量_全局变量}    Set Variable    ${data}[ORDER_QTY]
    ${证券类别_全局变量}    Set Variable    ${data}[STK_CLS]
    ${业务行为_全局变量}    Set Variable    ${data}[STK_BIZ_ACTION]
    ${证券业务_全局变量}    Set Variable    ${data}[STK_BIZ]
    ${委托价格_全局变量}    Set Variable    ${data}[ORDER_PRICE]
    ${货币代码_全局变量}    Set Variable    0
    ${number}    Set Variable    ${data}[number]
    Set Global Variable    ${客户代码_全局变量}
    Set Global Variable    ${资金账户_全局变量}
    Set Global Variable    ${交易板块_全局变量}
    Set Global Variable    ${股东账户_全局变量}
    Set Global Variable    ${证券代码_全局变量}
    Set Global Variable    ${委托数量_全局变量}
    Set Global Variable    ${证券类别_全局变量}
    Set Global Variable    ${业务行为_全局变量}
    Set Global Variable    ${证券业务_全局变量}
    Set Global Variable    ${委托价格_全局变量}
    Set Global Variable    ${接口类型_全局变量}
    Set Global Variable    ${货币代码_全局变量}
    Set Global Variable    ${number}

sqltest普通买卖初始化
    [Arguments]    ${权限}=${Empty}    ${接口类型}=${接口类型_全局变量}
    用户登录API_10301105
    ${变化数据_金证}    Create List    可用资金查询_10303001    可用股份查询_10303002    CUACCT_FUND    STK_ASSET
    ${变化数据}    Run Keyword If    '${接口类型}'=='Stk'    Set Variable    ${变化数据_金证}
    ${字段提取_需计算_委托前_全局变量}    ${字段提取_无需计算_委托前}    接口/表取值流程_取值计算录制模式    ${变化数据}
    Set Global Variable    ${字段提取_需计算_委托前_全局变量}
    log    ${字段提取_需计算_委托前_全局变量}
    ${委托前录制数据}    Create List    委托前_可用资金查询_接口全字段    委托前_可用股份查询_接口全字段    委托前_CUACCT_FUND_表全字段    委托前_STK_ASSET_表全字段
    Run Keyword And Continue On Failure    查询接口与表委托前全录制的通用    ${委托前录制数据}
