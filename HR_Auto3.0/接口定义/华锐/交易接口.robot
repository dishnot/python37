*** Settings ***
Resource          ../../公共目录/配置信息/环境配置信息.robot

*** Keywords ***
ReqCashAuctionOrder_现货委托交易
    [Arguments]    ${委托数量}    ${委托价格}=${委托价格_全局变量}    ${证券代码}=${证券代码_全局变量}    ${买卖方向}=${证券业务_全局变量}    ${委托类型}=${业务行为_全局变量}
    ${env_data}    Run KeyWord If    '${行为_全局变量}'!='121'    Create Dictionary    cust_id=${客户信息_全局变量["客户号"]}    fund_account_id=${客户信息_全局变量["资金账户"]}    account_id=${客户信息_全局变量["证券账户"]}    market_id=${客户信息_全局变量["市场代码"]}    side=${买卖方向}    security_id=${证券代码}    order_type=${委托类型}    price=${委托价格}    order_qty=${委托数量}
    ...    ELSE    Create Dictionary    cust_id=${客户代码_全局变量}    fund_account_id=${资金账户_全局变量}    account_id=${股东账户_全局变量}    market_id=${市场代码_全局变量}    side=${买卖方向}    security_id=${证券代码}    order_type=${委托类型}    price=${委托价格}    order_qty=${委托数量}
    ${resp}    POST接口下单请求_UTP数据银行    112    ${env_data}    ReqCashAuctionOrder    OnRspCashAuctionTradeER
    log    ${resp}
    ${用户系统消息序号}    set variable    ${resp[0]["data"]["client_seq_id"]}
    Should Be Equal As Strings    成功    ${resp[0]["message"]}
    #获取数据
    ${返回码}    ${返回数据}    GET获取返回数据_华锐API    ${用户系统消息序号}
    ${订单编号_全局变量}    Convert To String    ${返回数据["cl_ord_no"]}
    Set Global Variable    ${订单编号_全局变量}
    ${申报合同号_全局变量}    Convert To String    ${返回数据["cl_ord_id"]}
    Set Global Variable    ${申报合同号_全局变量}

ReqCancelOrder_通用撤单
    [Arguments]    ${订单编号}    ${客户信息}=${客户信息_全局变量}
    ${env_data}    Create Dictionary    cust_id=${客户信息["客户号"]}    fund_account_id=${客户信息["资金账户"]}    account_id=${客户信息["证券账户"]}    orig_cl_ord_no=${订单编号}
    ${resp}    POST接口下单请求_UTP数据银行    113    ${env_data}    ReqCancelOrder    OnRspOrderStatusAck
    log    ${resp}
    ${用户系统消息序号}    set variable    ${resp[0]["data"]["client_seq_id"]}
    Should Be Equal As Strings    成功    ${resp[0]["message"]}
    #获取数据
    ${返回码}    ${返回数据}    GET获取返回数据_华锐API    ${用户系统消息序号}
    ${订单编号_撤单_全局变量}    Convert To String    ${返回数据["cl_ord_no"]}
    Set Global Variable    ${订单编号_撤单_全局变量}
    ${申报合同号_撤单_全局变量}    Convert To String    ${返回数据["cl_ord_id"]}
    Set Global Variable    ${申报合同号_撤单_全局变量}
    [Return]    ${订单编号_撤单_全局变量}    ${申报合同号_撤单_全局变量}

ReqRepoAuctionOrder_质押式回购
    [Arguments]    ${委托数量}    ${委托价格}=${委托价格_全局变量}    ${证券代码}=${证券代码_全局变量}    ${买卖方向}=${证券业务_全局变量}    ${委托类型}=${业务行为_全局变量}    ${客户信息}=${客户信息_全局变量}
    ${env_data}    Create Dictionary    cust_id=${客户信息["客户号"]}    fund_account_id=${客户信息["资金账户"]}    account_id=${客户信息["证券账户"]}    market_id=${客户信息["市场代码"]}    side=${买卖方向}    security_id=${证券代码}    order_type=${委托类型}    price=${委托价格}    order_qty=${委托数量}
    ${resp}    POST接口下单请求_UTP数据银行    118    ${env_data}    ReqRepoAuctionOrder    OnRspRepoAuctionTradeER
    log    ${resp}
    ${用户系统消息序号}    set variable    ${resp[0]["data"]["client_seq_id"]}
    Should Be Equal As Strings    成功    ${resp[0]["message"]}
    #获取数据
    ${返回码}    ${返回数据}    GET获取返回数据_华锐API    ${用户系统消息序号}
    ${订单编号_全局变量}    Convert To String    ${返回数据["cl_ord_no"]}
    Set Global Variable    ${订单编号_全局变量}
    ${申报合同号_全局变量}    Convert To String    ${返回数据["cl_ord_id"]}
    Set Global Variable    ${申报合同号_全局变量}

ReqRightslssueOrder_配售
    [Arguments]    ${委托数量}    ${委托价格}=${委托价格_全局变量}    ${证券代码}=${证券代码_全局变量}    ${买卖方向}=${证券业务_全局变量}    ${委托类型}=${业务行为_全局变量}    ${客户信息}=${客户信息_全局变量}
    ${env_data}    Create Dictionary    cust_id=${客户信息["客户号"]}    fund_account_id=${客户信息["资金账户"]}    account_id=${客户信息["证券账户"]}    market_id=${客户信息["市场代码"]}    side=${买卖方向}    security_id=${证券代码}    order_type=${委托类型}    price=${委托价格}    order_qty=${委托数量}
    ${resp}    POST接口下单请求_UTP数据银行    121    ${env_data}    ReqRightsIssueOrder    ReqRightsIssueOrderER
    log    ${resp}
    ${用户系统消息序号}    set variable    ${resp[0]["data"]["client_seq_id"]}
    Should Be Equal As Strings    成功    ${resp[0]["message"]}
    #获取数据
    ${返回码}    ${返回数据}    GET获取返回数据_华锐API    ${用户系统消息序号}
    ${订单编号_全局变量}    Convert To String    ${返回数据["cl_ord_no"]}
    Set Global Variable    ${订单编号_全局变量}
    ${申报合同号_全局变量}    Convert To String    ${返回数据["cl_ord_id"]}
    Set Global Variable    ${申报合同号_全局变量}

ReqETFRedemptionOrder_ETF申赎
    [Arguments]    ${委托数量}    ${委托价格}=${委托价格_全局变量}    ${证券代码}=${证券代码_全局变量}    ${买卖方向}=${证券业务_全局变量}    ${委托类型}=${业务行为_全局变量}    ${客户信息}=${客户信息_全局变量}
    ${env_data}    Create Dictionary    cust_id=${客户信息["客户号"]}    fund_account_id=${客户信息["资金账户"]}    account_id=${客户信息["证券账户"]}    market_id=${客户信息["市场代码"]}    side=${买卖方向}    security_id=${证券代码}    order_type=${委托类型}    price=${委托价格}    order_qty=${委托数量}
    ${resp}    POST接口下单请求_UTP数据银行    119    ${env_data}    ReqETFRedemptionOrder    OnRspETFRedemptionTradeER
    log    ${resp}
    ${用户系统消息序号}    set variable    ${resp[0]["data"]["client_seq_id"]}
    Should Be Equal As Strings    成功    ${resp[0]["message"]}
    #获取数据
    ${返回码}    ${返回数据}    GET获取返回数据_华锐API    ${用户系统消息序号}
    ${订单编号_全局变量}    Convert To String    ${返回数据["cl_ord_no"]}
    Set Global Variable    ${订单编号_全局变量}
    ${申报合同号_全局变量}    Convert To String    ${返回数据["cl_ord_id"]}
    Set Global Variable    ${申报合同号_全局变量}

ReqlssueOrder_网上发行
    [Arguments]    ${委托数量}    ${委托价格}=${委托价格_全局变量}    ${证券代码}=${证券代码_全局变量}    ${客户信息}=${客户信息_全局变量}
    ${env_data}    Create Dictionary    cust_id=${客户信息["客户号"]}    fund_account_id=${客户信息["资金账户"]}    account_id=${客户信息["证券账户"]}    market_id=${客户信息["市场代码"]}    security_id=${证券代码}    price=${委托价格}    order_qty=${委托数量}
    ${resp}    POST接口下单请求_UTP数据银行    120    ${env_data}    ReqIssueOrder    ReqIssueOrderER
    log    ${resp}
    ${用户系统消息序号}    set variable    ${resp[0]["data"]["client_seq_id"]}
    Should Be Equal As Strings    成功    ${resp[0]["message"]}
    #获取数据
    ${返回码}    ${返回数据}    GET获取返回数据_华锐API    ${用户系统消息序号}
    ${订单编号_全局变量}    Convert To String    ${返回数据["cl_ord_no"]}
    Set Global Variable    ${订单编号_全局变量}
    ${申报合同号_全局变量}    Convert To String    ${返回数据["cl_ord_id"]}
    Set Global Variable    ${申报合同号_全局变量}

ReqSwapPutbackOrder_转股
    [Arguments]    ${委托数量}    ${委托价格}=${委托价格_全局变量}    ${证券代码}=${证券代码_全局变量}    ${买卖方向}=${证券业务_全局变量}    ${委托类型}=${业务行为_全局变量}    ${客户信息}=${客户信息_全局变量}
    ${env_data}    Create Dictionary    cust_id=${客户信息["客户号"]}    fund_account_id=${客户信息["资金账户"]}    account_id=${客户信息["证券账户"]}    market_id=${客户信息["市场代码"]}    side=${买卖方向}    security_id=${证券代码}    order_type=${委托类型}    price=${委托价格}    order_qty=${委托数量}
    ${resp}    POST接口下单请求_UTP数据银行    122    ${env_data}    ReqSwapPutbackOrder    ReqSwapPutbackOrderER
    log    ${resp}
    ${用户系统消息序号}    set variable    ${resp[0]["data"]["client_seq_id"]}
    Should Be Equal As Strings    成功    ${resp[0]["message"]}
    #获取数据
    ${返回码}    ${返回数据}    GET获取返回数据_华锐API    ${用户系统消息序号}
    ${订单编号_全局变量}    Convert To String    ${返回数据["cl_ord_no"]}
    Set Global Variable    ${订单编号_全局变量}
    ${申报合同号_全局变量}    Convert To String    ${返回数据["cl_ord_id"]}
    Set Global Variable    ${申报合同号_全局变量}

ReqTibAfterHourAuctionOrder_盘后定价
    [Arguments]    ${委托数量}    ${委托价格}=${委托价格_全局变量}    ${证券代码}=${证券代码_全局变量}    ${买卖方向}=${证券业务_全局变量}    ${委托类型}=${业务行为_全局变量}    ${客户信息}=${客户信息_全局变量}
