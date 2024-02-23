*** Settings ***
Library           RequestsLibrary
Resource          ../通用操作/常用关键字.robot
Library           DatabaseLibrary
Library           demjson

*** Keywords ***
ETF申赎数量查询
    ${查询结果}    QUERY    select cast(purchase_redemption_unit as SIGNED)*100 as test from tradingconfigdb.t_etf_biz_rule where security_id=${证券代码_全局变量}
    LOG    ${查询结果}[0][0]
    ${委托数量_全局变量}    evaluate    str(${查询结果}[0][0])
    Set Global Variable    ${委托数量_全局变量}
