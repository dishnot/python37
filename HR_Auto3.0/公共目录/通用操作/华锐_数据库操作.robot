*** Settings ***
Resource          常用关键字.robot

*** Keywords ***
华锐_买卖委托表数据查询_备份
    [Arguments]    ${字段名称key}    ${字段名称values}    ${接口或表名称}    ${字段名称}    ${Status}    ${客户信息}=${客户信息_全局变量}    ${订单状态}=${订单状态_全局变量}
    ${处理字符}    Create Dictionary    [=${EMPTY}    ]=${EMPTY}    '=${EMPTY}    :=${EMPTY}
    ${字段名称}    Run Keyword If    '${接口或表名称}' not in ('basedb.t_fund_assets','STK_ASSET','STK_ORDER','STK_MATCHING') and '${Status}'=='FAIL'    Set Variable    ${字段名称values}
    ...    ELSE IF    '${接口或表名称}' in ('basedb.t_fund_assets','STK_ASSET','STK_ORDER','STK_MATCHING') and '${Status}'=='FAIL'    Set Variable    ${字段名称values}
    ...    ELSE    Set Variable    ${字段名称key}
    ${字段名称}    字符串处理    ${字段名称}    ${处理字符}
    #查询条件
    ${条件}    Run Keyword If    '${接口或表名称}'in ('ReqFundQuery_资金查询','basedb.t_fund_assets')    Set Variable    fund_id='${客户信息["资金账户"]}' and `partition`='${客户信息["分区号"]}' ORDER BY id
    ...    ELSE IF    '${接口或表名称}'in ('ReqShareQuery_股份查询','basedb.t_stocks')    Set Variable    account_id='${客户信息["证券账户"]}' and security_id ='${证券代码_全局变量}' ORDER BY security_id
    ...    ELSE IF    '${接口或表名称}'in ('ReqOrderQuery_订单查询','tradingdb.t_order','ReqTradeOrderQuery_成交查询','tradingdb.t_report') and '${订单状态}' in ('已报','部成','全成','废单')    Set Variable    fund_account_id='${客户信息["资金账户"]}' and cl_ord_id='${申报合同号_全局变量}' ORDER BY cl_ord_no
    ...    ELSE IF    '${接口或表名称}'in ('ReqOrderQuery_订单查询','tradingdb.t_order','ReqTradeOrderQuery_成交查询','tradingdb.t_report') and '${订单状态}' in ('部撤','全撤')    Set Variable    fund_account_id='${客户信息["资金账户"]}' and cl_ord_id='${申报合同号_全局变量}' or cl_ord_id='${申报合同号_撤单_全局变量}' ORDER BY cl_ord_no
    #表
    ${表名}    Run Keyword If    '${接口或表名称}' in ('ReqFundQuery_资金查询','basedb.t_fund_assets')    Set Variable    basedb.t_fund_assets
    ...    ELSE IF    '${接口或表名称}' in ('ReqShareQuery_股份查询','STK_ASSET')    Set Variable    basedb.t_stocks
    ...    ELSE IF    '${接口或表名称}'in ('ReqOrderQuery_订单查询','tradingdb.t_order')    Set Variable    tradingdb.t_order
    ...    ELSE IF    '${接口或表名称}' in ('ReqTradeOrderQuery_成交查询','tradingdb.t_report')    Set Variable    tradingdb.t_report
    ...    ELSE    Set Variable    ${接口或表名称}
    [Return]    ${字段名称}    ${表名}    ${条件}

华锐_买卖委托表数据查询
    [Arguments]    ${字段名称key}    ${字段名称values}    ${接口或表名称}    ${字段名称}    ${Status}    ${订单状态}=${订单状态_全局变量}
    ${处理字符}    Create Dictionary    [=${EMPTY}    ]=${EMPTY}    '=${EMPTY}    :=${EMPTY}
    ${字段名称}    Run Keyword If    '${接口或表名称}' not in ('basedb.t_fund_assets','STK_ASSET','STK_ORDER','STK_MATCHING') and '${Status}'=='FAIL'    Set Variable    ${字段名称values}
    ...    ELSE IF    '${接口或表名称}' in ('basedb.t_fund_assets','STK_ASSET','STK_ORDER','STK_MATCHING') and '${Status}'=='FAIL'    Set Variable    ${字段名称values}
    ...    ELSE    Set Variable    ${字段名称key}
    ${字段名称}    字符串处理    ${字段名称}    ${处理字符}
    #查询条件
    ${条件}    Run Keyword If    '${接口或表名称}'in ('ReqFundQuery_资金查询','basedb.t_fund_assets') and '${行为_全局变量}'!='121'    Set Variable    fund_id='${客户信息_全局变量["资金账户"]}' and `partition`='${客户信息_全局变量["分区号"]}' ORDER BY id
    ...    ELSE IF    '${接口或表名称}'in ('ReqFundQuery_资金查询','basedb.t_fund_assets') and '${行为_全局变量}'=='121'    Set Variable    fund_id='${资金账户_全局变量}' and `partition`='${分区号_全局变量}' ORDER BY id
    ...    ELSE IF    '${接口或表名称}'in ('ReqShareQuery_股份查询','basedb.t_stocks') and '${行为_全局变量}'!='121'    Set Variable    account_id='${客户信息_全局变量["证券账户"]}' and security_id ='${证券代码_全局变量}' ORDER BY security_id
    ...    ELSE IF    '${接口或表名称}'in ('ReqShareQuery_股份查询','basedb.t_stocks') and '${行为_全局变量}'=='121'    Set Variable    account_id='${股东账户_全局变量}' and security_id ='${证券代码_全局变量}' ORDER BY security_id
    ...    ELSE IF    '${接口或表名称}'in ('ReqOrderQuery_订单查询','tradingdb.t_order','ReqTradeOrderQuery_成交查询','tradingdb.t_report') and '${订单状态}' in ('已报','部成','全成','废单') and '${行为_全局变量}'!='121'    Set Variable    fund_account_id='${客户信息_全局变量["资金账户"]}' and cl_ord_id='${申报合同号_全局变量}' ORDER BY security_id
    ...    ELSE IF    '${接口或表名称}'in ('ReqOrderQuery_订单查询','tradingdb.t_order','ReqTradeOrderQuery_成交查询','tradingdb.t_report') and '${订单状态}' in ('已报','部成','全成','废单') and '${行为_全局变量}'=='121'    Set Variable    fund_account_id='${资金账户_全局变量}' and cl_ord_id='${申报合同号_全局变量}' ORDER BY security_id
    ...    ELSE IF    '${接口或表名称}'in ('ReqOrderQuery_订单查询','tradingdb.t_order','ReqTradeOrderQuery_成交查询','tradingdb.t_report') and '${订单状态}' in ('部撤','全撤') and '${行为_全局变量}'!='121'    Set Variable    fund_account_id='${客户信息_全局变量["资金账户"]}' and cl_ord_id='${申报合同号_全局变量}' or cl_ord_id='${申报合同号_撤单_全局变量}' ORDER BY security_id
    ...    ELSE IF    '${接口或表名称}'in ('ReqOrderQuery_订单查询','tradingdb.t_order','ReqTradeOrderQuery_成交查询','tradingdb.t_report') and '${订单状态}' in ('部撤','全撤') and '${行为_全局变量}'=='121'    Set Variable    fund_account_id='${资金账户_全局变量}' and cl_ord_id='${申报合同号_全局变量}' or cl_ord_id='${申报合同号_撤单_全局变量}' ORDER BY security_id
    ...    ELSE IF    '${接口或表名称}'in ('ReqETFQueryOrderEx_ETF申赎成交查询','tradingdb.t_report_etf_component') and '${行为_全局变量}'!='121'    Set Variable    fund_account_id='${客户信息_全局变量["资金账户"]}' and cl_ord_no='${订单编号_全局变量}' ORDER BY security_id
    #表
    ${表名}    Run Keyword If    '${接口或表名称}' in ('ReqFundQuery_资金查询','basedb.t_fund_assets')    Set Variable    basedb.t_fund_assets
    ...    ELSE IF    '${接口或表名称}' in ('ReqShareQuery_股份查询','basedb.t_stocks')    Set Variable    basedb.t_stocks
    ...    ELSE IF    '${接口或表名称}'in ('ReqOrderQuery_订单查询','tradingdb.t_order')    Set Variable    tradingdb.t_order
    ...    ELSE IF    '${接口或表名称}' in ('ReqTradeOrderQuery_成交查询','tradingdb.t_report')    Set Variable    tradingdb.t_report
    ...    ELSE IF    '${接口或表名称}' in ('ReqETFQueryOrderEx_ETF申赎成交查询','tradingdb.t_report_etf_component')    Set Variable    tradingdb.t_report_etf_component
    ...    ELSE    Set Variable    ${接口或表名称}
    [Return]    ${字段名称}    ${表名}    ${条件}
