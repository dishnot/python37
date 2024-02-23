*** Variables ***
&{ReqFundQuery_资金查询_取值}    leaves_value=leaves_value    init_leaves_value=init_leaves_value    available_t0=available_t0    available_t1=available_t1    available_t2=available_t2    available_t3=available_t3    available_tall=available_tall    frozen_all=frozen_all    credit_sell_frozen=credit_sell_frozen    credit_sell_occupied=credit_sell_occupied    credit_sell_pre_occupied=credit_sell_pre_occupied    init_credit_sell=init_credit_sell    query_result_code=无计算逻辑    extra_data=无计算逻辑    te_partition_no=无计算逻辑    # 资金余额|日初资金金额|T+0可用资金|T+1可用资金|T+2可用资金|T+3可用资金|T+All可用资金|当前所有冻结|融券卖出冻结金额|融券卖出款占用|融券卖出款预占用|日初融券卖出款|查询结果代码|扩展字段|所属分区号
&{ReqShareQuery_股份查询_取值}    init_qty=init_qty    leaves_qty=leaves_qty    available_qty=available_qty    init_crd_sell_buy_share_qty=init_crd_sell_buy_share_qty    init_crd_sell_occupied_amt=init_crd_sell_occupied_amt    cur_crd_sell_occupied_qty=cur_crd_sell_occupied_qty    cur_crd_sell_occupied_amt=cur_crd_sell_occupied_amt    security_id=无计算逻辑    security_symbol=无计算逻辑    market_id=无计算逻辑    currency=无计算逻辑    security_type=无计算逻辑    # 日初持仓量|剩余股份数量|可用股份数量|日初融券买入量|日初融券占用金额|当前融券买入量|当前融券占用金额|证券代码|证券简称|市场代码|货币种类|证券类别
&{basedb.t_fund_assets_取值}    init_amt=cast(init_amt as char(100))    order_frozen=cast(order_frozen as char(100))    buy_trade=cast(buy_trade as char(100))    sell_trade=cast(sell_trade as char(100))    unusual_frozen=cast(unusual_frozen as char(100))    unusual_frozen_cancel=cast(unusual_frozen_cancel as char(100))    fee_frozen=cast(fee_frozen as char(100))    fee_trade=cast(fee_trade as char(100))    today_in=cast(today_in as char(100))    today_out=cast(today_out as char(100))    temp_add=cast(temp_add as char(100))    temp_sub=cast(temp_sub as char(100))    temp_frozen=cast(temp_frozen as char(100))    temp_frozen_cancel=cast(temp_frozen_cancel as char(100))    balance=cast(balance as char(100))    available_t0=cast(available_t0 as char(100))    on_theway_t1=cast(on_theway_t1 as char(100))
...               on_theway_t2=cast(on_theway_t2 as char(100))    on_theway_t3=cast(on_theway_t3 as char(100))    `partition`=无计算逻辑    currency=无计算逻辑    # 日初可用余额|委托预冻结|买入成交|卖出成交|异常冻结|异常冻结取消|冻结费用|成交费用|当日入金|当日出金|临时调增|临时调减|临时冻结|临时冻结取消|资金余额|T+0可用资金余额|T+1在途可用资金|T+2在途可用资金|T+3在途可用资金|分区|币种
&{basedb.t_stocks_取值}    first_day_pos=cast(first_day_pos as char(100))    first_day_frozen=cast(first_day_frozen as char(100))    first_day_avaiable=cast(first_day_avaiable as char(100))    not_circ_vol=cast(not_circ_vol as char(100))    temp_frozen=cast(temp_frozen as char(100))    today_sell=cast(today_sell as char(100))    init_cover_use_qty=cast(init_cover_use_qty as char(100))    current_available=cast(current_available as char(100)) \    security_id=无计算逻辑    symbol=无计算逻辑    market_id=无计算逻辑    currency=无计算逻辑    # 日初持仓量|日初冻结量|日初可用|非流通量|临时冻结|当日卖出|昨备兑占用数量|当前持仓量|证券编码|证券简称|市场|币种
&{ReqOrderQuery_订单查询_剔除字段}    account_id=account_id    transact_time=transact_time    cl_ord_no=cl_ord_no    order_id=order_id    cl_ord_id=cl_ord_id    client_seq_id=client_seq_id    orig_cl_ord_no=orig_cl_ord_no    # 证券账户|客户委托时间|客户订单编号|交易所订单编号|申报合同号|用户系统消息序号|对于撤单订单
&{ReqTradeOrderQuery_成交查询_剔除字段}    account_id=account_id    exec_id=exec_id    cl_ord_no=cl_ord_no    order_id=order_id    cl_ord_id=cl_ord_id    transact_time=transact_time    client_seq_id=client_seq_id    # 证券账户|执行编号|客户订单编号|交易所订单编号|申报合同号|客户委托时间|用户系统消息序号
&{tradingdb.t_order}    business_type=business_type    security_id=security_id    market_id=market_id    side=side    ord_type=ord_type    price=price    order_qty=order_qty    enforce_flag=enforce_flag    qualification=qualification    offer_way=offer_way    order_way=order_way    # 业务类型|证券类型|证券所属市场|买卖方向|订单类型|申报价格|委托数量|风险强制标识|适当性留痕记录|报盘通道|委托方式
&{tradingdb.t_report}    business_type=business_type    security_id=security_id    market_id=market_id    exec_type=exec_type    ord_status=ord_status    price=price    order_qty=order_qty    leaves_qty=leaves_qty    cum_qty=cum_qty    side=side    last_px=last_px    last_qty=last_qty    total_value_traded=total_value_traded    net_total_value_trade=net_total_value_trade    fee=fee    available_amt=available_amt    total_amt=total_amt
...               total_amt=total_amt    security_symbol=security_symbol    reject_reason_code=reject_reason_code    ord_rej_reason=ord_rej_reason    ord_type=ord_type    # 业务类型|合约编码|证券所属市场|当前订单执行类型|当前申报的状态|申报价格|委托数量|未成交部分的数量|累计成交数量|买卖方向|成交价格|成交数量|成交金额|成交净额|费用|可用资金|资金总额|证券名称|拒绝原因代码|订单拒绝原因|订单类型
&{资金查询_ReqFundQuery_basedb.t_fund_assets}    fund_account_id=fund_id    available_t1=cast(available_t0*10000 as signed)    # 资金账号|可用资金
&{股份查询_ReqShareQuery_basedb.t_stocks}    account_id=account_id    security_id=security_id    leaves_qty=cast(current_available*100 as signed)    # 证券账号|证券代码|剩余股份数量
&{订单查询_ReqOrderQuery_tradingdb.t_order}    cl_ord_id=cl_ord_id    security_id=security_id    side=side    order_qty=order_qty    # 报盘合同号|证券代码|买卖方向|委托数量
&{成交查询_ReqTradeOrderQuery_tradingdb.t_report}    cl_ord_id=cl_ord_id    security_id=security_id    order_qty=order_qty    last_qty=last_qty    last_px=last_px    # 报盘合同号|证券代码|委托数量|成交数量|成交价格
&{ReqETFQueryOrderEx_etf成交查询}    security_symbol=security_symbol    cl_ord_id=cl_ord_id    cl_ord_no=cl_ord_no    exec_id=exec_id    order_id=order_id    transact_time=transact_time    fee=fee
&{etf成交查询_t_report_etf_component}    security_id=security_id    market_id=market_id
&{tradingdb.t_report_etf_component}    fund_account_id=fund_account_id    security_id=security_id    market_id=market_id    qty=qty    amt=amt    price=price    etf_trade_report_type=etf_trade_report_type    create_user=create_user    update_user=update_user    cust_id=cust_id
&{OnRspExtQueryResultShareEx_增强股份查询结果}    init_qty=init_qty    leaves_qty=leaves_qty    available_qty=available_qty    security_id=无计算逻辑    security_symbol=无计算逻辑    market_id=无计算逻辑    account_id=无计算逻辑    security_type=无计算逻辑    profit_loss=无计算逻辑    market_value=无计算逻辑    cost_price=无计算逻辑    last_price=无计算逻辑    stock_buy=无计算逻辑    stock_sale=无计算逻辑    fund_account_id=无计算逻辑    branch_id=无计算逻辑    etf_redemption_qty=无计算逻辑

*** Keywords ***
华锐_录制字段
    [Arguments]    ${名称}
    ${委托字段}    Run Keyword If    '${名称}'=='ReqFundQuery_资金查询'    Set Variable    ${ReqFundQuery_资金查询_取值}
    ...    ELSE IF    '${名称}'=='ReqShareQuery_股份查询'    Set Variable    ${ReqShareQuery_股份查询_取值}
    ...    ELSE IF    '${名称}'=='basedb.t_fund_assets'    Set Variable    ${basedb.t_fund_assets_取值}
    ...    ELSE IF    '${名称}'=='basedb.t_stocks'    Set Variable    ${basedb.t_stocks_取值}
    ...    ELSE IF    '${名称}'=='ReqOrderQuery_订单查询'    Set Variable    ${ReqOrderQuery_订单查询_剔除字段}
    ...    ELSE IF    '${名称}'=='ReqTradeOrderQuery_成交查询'    Set Variable    ${ReqTradeOrderQuery_成交查询_剔除字段}
    ...    ELSE IF    '${名称}'=='tradingdb.t_order'    Set Variable    ${tradingdb.t_order}
    ...    ELSE IF    '${名称}'=='tradingdb.t_report'    Set Variable    ${tradingdb.t_report}
    ...    ELSE IF    '${名称}'=='ReqETFQueryOrderEx_ETF申赎成交查询'    Set Variable    ${ReqETFQueryOrderEx_etf成交查询}
    ...    ELSE IF    '${名称}'=='tradingdb.t_report_etf_component'    Set Variable    ${tradingdb.t_report_etf_component}
    ...    ELSE IF    '${名称}'=='ReqExtQueryShareEx_增强股份查询'    Set Variable    ${OnRspExtQueryResultShareEx_增强股份查询结果}
    ...    ELSE IF    '${名称}'=='ReqTradeOrderExQuery_增强成交查询'    Set Variable    ${ReqTradeOrderQuery_成交查询_剔除字段}
    ...    ELSE    Create List    无删除字段
    [Return]    ${委托字段}

华锐_比对字段
    [Arguments]    ${查询接口名称}
    ${接口字典}    Run Keyword If    '${查询接口名称}'=='ReqFundQuery_资金查询'    Set Variable    ${资金查询_ReqFundQuery_basedb.t_fund_assets}
    ...    ELSE IF    '${查询接口名称}'=='ReqShareQuery_股份查询'    Set Variable    ${股份查询_ReqShareQuery_basedb.t_stocks}
    ...    ELSE IF    '${查询接口名称}'=='ReqOrderQuery_订单查询'    Set Variable    ${订单查询_ReqOrderQuery_tradingdb.t_order}
    ...    ELSE IF    '${查询接口名称}'=='ReqTradeOrderQuery_成交查询'    Set Variable    ${成交查询_ReqTradeOrderQuery_tradingdb.t_report}
    ...    ELSE IF    '${查询接口名称}'=='ReqETFQueryOrderEx_ETF申赎成交查询'    Set Variable    ${etf成交查询_t_report_etf_component}
    [Return]    ${接口字典}
