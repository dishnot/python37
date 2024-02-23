*** Settings ***
Resource          常用关键字.robot
Resource          ../配置信息/环境配置信息.robot

*** Keywords ***
委托价格
    ${委托当前价格}    query    select ROUND(CURRENT_PRICE/10000.000,0,1) from STK_MKTINFO WHERE STK_CODE=${证券代码_全局变量} and STKBD=${交易板块_全局变量}
    ${委托涨停价格}    query    select ROUND(STK_UPLMT_PRICE/10000,0,1) AS PRICE from STK_INFO WHERE STK_CODE=${证券代码_全局变量} and STKBD=${交易板块_全局变量}
    Set Global Variable    ${委托当前价格}
    Set Global Variable    ${委托涨停价格}
