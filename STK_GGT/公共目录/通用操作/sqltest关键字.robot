*** Settings ***
Library           String
Library           Collections
Library           DatabaseLibrary

*** Keywords ***
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
    #${number}    Set Variable    ${data}[number]
    #${result}    Set Variable    ${data}[result]
    ${订单状态_全局变量}    Set Variable    ${订单状态}
    Set Global Variable    ${订单状态_全局变量}
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
    #Set Global Variable    ${number}
    #Set Global Variable    ${result}
