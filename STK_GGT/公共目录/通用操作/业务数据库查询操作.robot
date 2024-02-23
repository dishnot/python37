*** Settings ***
Resource          常用关键字.robot
Resource          ../配置信息/环境配置信息.robot

*** Keywords ***
委托价格
    ${委托当前价格}    query    select ROUND(CURRENT_PRICE/10000.000,3,1) from STK_MKTINFO WHERE STK_CODE=${证券代码_全局变量} and STKBD=${交易板块_全局变量}
    ${委托涨停价格}    query    select ROUND(STK_UPLMT_PRICE/10000,3,1) AS PRICE from STK_INFO WHERE STK_CODE=${证券代码_全局变量} and STKBD=${交易板块_全局变量}
    Set Global Variable    ${委托涨停价格}
    [Return]    ${委托当前价格}

价差
    [Arguments]    ${委托当前价格}
    ${价差}    query    SELECT ROUND(STK_SPREAD/10000.000,3,1) AS ORDER_PRICE FROM STK_PRICE_UNIT WHERE STK_CLS = 'A' AND STKBD = ${交易板块_全局变量} AND ${委托当前价格} BETWEEN BGN_PRICE/10000 AND END_PRICE/10000
    log    ${价差}
    ${价差}    Get From LIST    ${价差[0]}    0
    ${价差}    EVALUATE    round(${价差},3)    #价格保留3位小数
    Set Global Variable    ${价差}
