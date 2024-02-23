*** Settings ***
Resource          ../../交易流程_公共/3-检查点流程/公共/计算该笔委托的值_取值计算录制模式.robot
Resource          ../../交易流程_公共/3-检查点流程/公共/接口与表_比对模式.robot
Resource          ../../交易流程_公共/3-检查点流程/公共/接口与表_录制模式.robot

*** Keywords ***
华锐_普通买卖检查流程
    [Arguments]    ${订单状态}=${订单状态_全局变量}
    ${调用接口}    Run KeyWord If    '${业务_全局变量}' not in \ ('181','182','187','188','827','828')    Create List    ReqFundQuery_资金查询    ReqShareQuery_股份查询    ReqOrderQuery_订单查询    ReqTradeOrderQuery_成交查询
    ...    ELSE IF    '${业务_全局变量}' in ('181','182','187','188','827','828') and '${交易板块_全局变量}'!='00'    Create List    ReqFundQuery_资金查询    ReqShareQuery_股份查询    ReqOrderQuery_订单查询    ReqTradeOrderQuery_成交查询    ReqTradeOrderExQuery_增强成交查询    ReqETFQueryOrderEx_ETF申赎成交查询
    ...    ELSE    Create List    ReqFundQuery_资金查询    ReqShareQuery_股份查询    ReqOrderQuery_订单查询
    log    ----------比对
    Run Keyword if    '${订单状态}' in ('部撤','已报','部成','全成')    Run Keyword And Continue On Failure    查询接口与表比对的通用流程    ${调用接口}
    log    ----------取值计算录制
    ${变化数据}    Create List    ReqFundQuery_资金查询    ReqShareQuery_股份查询    ReqExtQueryShareEx_增强股份查询    basedb.t_fund_assets    basedb.t_stocks
    Run Keyword And Continue On Failure    查询接口与表取值计算录制的通用流程    ${变化数据}
    log    ----------取值录制
    ${录制数据}    Run KeyWord If    '${业务_全局变量}' not in \ ('181','182','187','188','827','828')    Create List    ReqOrderQuery_订单查询    ReqTradeOrderQuery_成交查询    ReqTradeOrderExQuery_增强成交查询    tradingdb.t_order    tradingdb.t_report
    ...    ELSE    Create List    ReqOrderQuery_订单查询    ReqTradeOrderQuery_成交查询    ReqTradeOrderExQuery_增强成交查询    ReqETFQueryOrderEx_ETF申赎成交查询    tradingdb.t_order    tradingdb.t_report_etf_component
    Run Keyword And Continue On Failure    查询接口与表取值录制的通用流程    ${录制数据}

华锐_新股申购检查流程
    [Arguments]    ${订单状态}=${订单状态_全局变量}
    ${调用接口}    Create List    ReqOrderQuery_订单查询    ReqTradeOrderQuery_成交查询
    log    ----------比对
    Run Keyword if    '${订单状态}' in ('部撤','已报','部成','全成')    Run Keyword And Continue On Failure    查询接口与表比对的通用流程    ${调用接口}
    log    ----------取值录制
    ${录制数据}    Create List    ReqOrderQuery_订单查询    ReqTradeOrderQuery_成交查询    tradingdb.t_order    tradingdb.t_report
    Run Keyword And Continue On Failure    查询接口与表取值录制的通用流程    ${录制数据}
