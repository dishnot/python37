*** Settings ***
Resource          常用关键字.robot

*** Keywords ***
总对总表数据查询
    [Arguments]    ${字段名称key}    ${字段名称values}    ${接口或表名称}    ${字段名称}    ${Status}    ${客户信息}=${客户信息_全局变量}
    ${处理字符}    Create Dictionary    [=${EMPTY}    ]=${EMPTY}    '=${EMPTY}    :=${EMPTY}
    ${字段名称}    Run Keyword If    '${接口或表名称}'not in ('CUACCT_FUND','STK_ASSET','STK_ORDER','STK_MATCHING','CUACCT_FUND全表字段','STK_ASSET全表字段') and'${Status}'=='FAIL'    Set Variable    ${字段名称values}
    ...    ELSE    Set Variable    ${字段名称key}
    ${字段名称}    字符串处理    ${字段名称}    ${处理字符}
    #查询条件
    log    ${客户信息['STKPBU']}
    log    ${接口或表名称}
    ${条件}    Run Keyword If    '${接口或表名称}'in ('可用资金查询_10303001','CUACCT_FUND','可用资金_10303001_全接口字段','CUACCT_FUND全表字段','委托前_可用资金查询_接口全字段','委托前_CUACCT_FUND_表全字段')    Set Variable    CUACCT_CODE='${资金账户_全局变量}' and CURRENCY='${货币代码_全局变量}' ORDER BY CURRENCY
    ...    ELSE IF    '${接口或表名称}' in ('可用股份查询_10303002','STK_ASSET','可用股份_10303002_全接口字段','STK_ASSET全表字段','委托前_可用股份查询_接口全字段','委托前_STK_ASSET_表全字段')and '${业务行为_全局变量}'=='121'    Set Variable    CUACCT_CODE='${资金账户_全局变量}' and CURRENCY='${货币代码_全局变量}' and STK_CODE in (SELECT COMP_STK_CODE FROM STK_ETF_BASKET WHERE ETF_CODE='${证券代码_全局变量}') and STKPBU = '${客户信息['STKPBU']}' ORDER BY STK_CODE
    ...    ELSE IF    '${接口或表名称}' in ('可用股份查询_10303002','STK_ASSET','可用股份_10303002_全接口字段','STK_ASSET全表字段','委托前_可用股份查询_接口全字段','委托前_STK_ASSET_表全字段')and '${证券业务_全局变量}' not in ('121','181','182')    Set Variable    CUACCT_CODE='${资金账户_全局变量}' and STK_CODE='${证券代码_全局变量}' and STKPBU = '${客户信息['STKPBU']}' ORDER BY STK_CODE
    ...    ELSE IF    '${接口或表名称}' in ('可用股份查询_10303002','STK_ASSET','可用股份_10303002_全接口字段','STK_ASSET全表字段','委托前_可用股份查询_接口全字段','委托前_STK_ASSET_表全字段')and '${证券业务_全局变量}' in ('181','182')    Set Variable    CUACCT_CODE='${资金账户_全局变量}' and (STK_CODE in (SELECT COMP_STK_CODE FROM STK_ETF_BASKET WHERE ETF_CODE='${证券代码_全局变量}') or STK_CODE ='${证券代码_全局变量}') ORDER BY STK_CODE
    ...    ELSE IF    '${接口或表名称}' in ('当日委托查询_10303003','STK_ORDER')    Set Variable    CUACCT_CODE='${资金账户_全局变量}' and ORDER_ID='${合同序号_全局变量}'or RAW_ORDER_ID='${合同序号_全局变量}' ORDER BY STK_CODE
    ...    ELSE IF    '${接口或表名称}' in ('当日成交查询_10303004','STK_MATCHING')    Set Variable    CUACCT_CODE='${资金账户_全局变量}' and ORDER_ID='${合同序号_全局变量}' ORDER BY QUERY_POS
    ...    ELSE IF    '${接口或表名称}' in ('STK_ORDER_DETAIL')    Set Variable    CUACCT_CODE='${资金账户_全局变量}' and ORDER_ID='${合同序号_全局变量}' ORDER BY STK_CODE
    #表
    ${表名}    Run Keyword If    '${接口或表名称}'in ('可用资金查询_10303001','可用资金_10303001_全接口字段','CUACCT_FUND全表字段','委托前_可用资金查询_接口全字段','委托前_CUACCT_FUND_表全字段')    Set Variable    CUACCT_FUND
    ...    ELSE IF    '${接口或表名称}'in ('可用股份查询_10303002','可用股份_10303002_全接口字段','STK_ASSET全表字段','委托前_可用股份查询_接口全字段','委托前_STK_ASSET_表全字段')    Set Variable    STK_ASSET
    ...    ELSE IF    '${接口或表名称}' =='当日委托查询_10303003'    Set Variable    STK_ORDER
    ...    ELSE IF    '${接口或表名称}' =='当日成交查询_10303004'    Set Variable    STK_MATCHING
    ...    ELSE    Set Variable    ${接口或表名称}
    [Return]    ${字段名称}    ${表名}    ${条件}

金证_买卖委托表数据查询
    [Arguments]    ${字段名称key}    ${字段名称values}    ${接口或表名称}    ${字段名称}    ${Status}    ${客户信息}=${客户信息_全局变量}
    ${处理字符}    Create Dictionary    [=${EMPTY}    ]=${EMPTY}    '=${EMPTY}    :=${EMPTY}
    ${字段名称}    Run Keyword If    '${接口或表名称}'not in ('CUACCT_FUND','STK_ASSET','STK_ORDER','STK_MATCHING') and'${Status}'=='FAIL'    Set Variable    ${字段名称values}
    ...    ELSE    Set Variable    ${字段名称key}
    ${字段名称}    字符串处理    ${字段名称}    ${处理字符}
    #查询条件
    log    ${客户信息['STKPBU']}
    ${条件}    Run Keyword If    '${接口或表名称}'in ('可用资金查询_10303001','CUACCT_FUND')    Set Variable    CUACCT_CODE='${资金账户_全局变量}' and CURRENCY='${货币代码_全局变量}' ORDER BY CURRENCY
    ...    ELSE IF    '${接口或表名称}' in ('可用股份查询_10303002','STK_ASSET','可用股份_10303002_全接口字段','STK_ASSET全表字段','委托前_可用股份查询_接口全字段','委托前_STK_ASSET_表全字段')and '${业务行为_全局变量}'=='121'    Set Variable    CUACCT_CODE='${资金账户_全局变量}' and CURRENCY='${货币代码_全局变量}' and STK_CODE in (SELECT COMP_STK_CODE FROM STK_ETF_BASKET WHERE ETF_CODE='${证券代码_全局变量}')    ORDER BY STK_CODE
    ...    ELSE IF    '${接口或表名称}' in ('可用股份查询_10303002','STK_ASSET','可用股份_10303002_全接口字段','STK_ASSET全表字段','委托前_可用股份查询_接口全字段','委托前_STK_ASSET_表全字段')and '${证券业务_全局变量}' not in ('181','182') and '${业务行为_全局变量}'!='121'    Set Variable    CUACCT_CODE='${资金账户_全局变量}' and CURRENCY='${货币代码_全局变量}' and STK_CODE ='${证券代码_全局变量}' ORDER BY STK_CODE
    ...    ELSE IF    '${接口或表名称}' in ('可用股份查询_10303002','STK_ASSET','可用股份_10303002_全接口字段','STK_ASSET全表字段','委托前_可用股份查询_接口全字段','委托前_STK_ASSET_表全字段')and '${证券业务_全局变量}' in ('181','182')    Set Variable    CUACCT_CODE='${资金账户_全局变量}' and (STK_CODE in (SELECT COMP_STK_CODE FROM STK_ETF_BASKET WHERE ETF_CODE='${证券代码_全局变量}') or STK_CODE ='${证券代码_全局变量}') ORDER BY STK_CODE
    ...    ELSE IF    '${接口或表名称}' in ('当日委托查询_10303003','STK_ORDER')    Set Variable    CUACCT_CODE='${资金账户_全局变量}' and ORDER_ID='${合同序号_全局变量}'or RAW_ORDER_ID='${合同序号_全局变量}' ORDER BY STK_CODE
    ...    ELSE IF    '${接口或表名称}' in ('当日成交查询_10303004','STK_MATCHING')    Set Variable    CUACCT_CODE='${资金账户_全局变量}' and ORDER_ID='${合同序号_全局变量}' ORDER BY QUERY_POS
    ...    ELSE IF    '${接口或表名称}' in ('STK_ORDER_DETAIL')    Set Variable    CUACCT_CODE='${资金账户_全局变量}' and ORDER_ID='${合同序号_全局变量}' ORDER BY STK_CODE
    #表
    ${表名}    Run Keyword If    '${接口或表名称}'=='可用资金查询_10303001'    Set Variable    CUACCT_FUND
    ...    ELSE IF    '${接口或表名称}' =='可用股份查询_10303002'    Set Variable    STK_ASSET
    ...    ELSE IF    '${接口或表名称}' =='当日委托查询_10303003'    Set Variable    STK_ORDER
    ...    ELSE IF    '${接口或表名称}' =='当日成交查询_10303004'    Set Variable    STK_MATCHING
    ...    ELSE    Set Variable    ${接口或表名称}
    [Return]    ${字段名称}    ${表名}    ${条件}
