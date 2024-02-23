*** Settings ***
Resource          ../../公共目录/配置信息/环境配置信息.robot

*** Keywords ***
ReqFundQuery_资金查询
    ${币种}    set variable    CNY
    ${env_data}    Run KeyWord If    '${行为_全局变量}'!='121'    Create Dictionary    cust_id=${客户信息_全局变量["客户号"]}    fund_account_id=${客户信息_全局变量["资金账户"]}    account_id=${客户信息_全局变量["证券账户"]}    currency=${币种}
    ...    ELSE    Create Dictionary    cust_id=${客户代码_全局变量}    fund_account_id=${资金账户_全局变量}    account_id=${股东账户_全局变量}    currency=${币种}
    ${resp}    POST接口下单请求_UTP数据银行    116    ${env_data}    ReqFundQuery    OnRspFundQueryResult
    log    ${resp}
    ${用户系统消息序号}    set variable    ${resp[0]["data"]["client_seq_id"]}
    Should Be Equal As Strings    成功    ${resp[0]["message"]}
    #获取数据
    ${返回码}    ${返回数据}    GET获取返回数据_华锐API    ${用户系统消息序号}
    ${返回数据}    Create List    ${返回数据}
    [Return]    ${返回码}    ${返回数据}

ReqShareQuery_股份查询
    [Arguments]    ${证券代码}=${证券代码_全局变量}
    ${env_data}    Run KeyWord If    '${行为_全局变量}'!='121'    Create Dictionary    cust_id=${客户信息_全局变量["客户号"]}    fund_account_id=${客户信息_全局变量["资金账户"]}    account_id=${客户信息_全局变量["证券账户"]}    security_id=${证券代码}
    ...    ELSE    Create Dictionary    cust_id=${客户代码_全局变量}    fund_account_id=${资金账户_全局变量}    account_id=${股东账户_全局变量}    security_id=${证券代码}
    ${resp}    POST接口下单请求_UTP数据银行    117    ${env_data}    ReqShareQuery    OnRspShareQueryResult
    log    ${resp}
    ${用户系统消息序号}    set variable    ${resp[0]["data"]["client_seq_id"]}
    Should Be Equal As Strings    成功    ${resp[0]["message"]}
    #获取数据
    ${返回码}    ${返回数据}    GET获取返回数据_华锐API    ${用户系统消息序号}
    ${返回数据}    Set Variable    ${返回数据["order_array"]}
    [Return]    ${返回码}    ${返回数据}

ReqOrderQuery_订单查询
    [Arguments]    ${订单编号}=${订单编号_全局变量}
    ${env_data}    Run KeyWord If    '${行为_全局变量}'!='121'    Create Dictionary    cust_id=${客户信息_全局变量["客户号"]}    fund_account_id=${客户信息_全局变量["资金账户"]}    account_id=${客户信息_全局变量["证券账户"]}    cl_ord_no=${订单编号}
    ...    ELSE    Create Dictionary    cust_id=${客户代码_全局变量}    fund_account_id=${资金账户_全局变量}    account_id=${股东账户_全局变量}    cl_ord_no=${订单编号}
    FOR    ${i}    IN RANGE    2
        ${resp}    POST接口下单请求_UTP数据银行    115    ${env_data}    ReqOrderQuery    OnRspOrderQueryResult
        log    ${resp}
        ${用户系统消息序号}    set variable    ${resp[0]["data"]["client_seq_id"]}
        Should Be Equal As Strings    成功    ${resp[0]["message"]}
    #获取数据
        Sleep    1
        ${返回码}    ${返回数据}    GET获取返回数据_华锐API    ${用户系统消息序号}
        ${空数据}    Set Variable If    ${返回数据}!={}    5    6
        ${返回数据}    Set Variable If    ${返回数据}!={}    ${返回数据["order_array"]}    [{exec_type:555}]
        Run KeyWord If    '${返回数据}[0][exec_type]' in ('0','1') or ${空数据}==6    Continue For Loop
        Exit For Loop If    '${返回数据}[0][exec_type]' not in ('0','1')
    END
    [Return]    ${返回码}    ${返回数据}

ReqTradeOrderQuery_成交查询
    [Arguments]    ${订单编号}=${订单编号_全局变量}
    ${env_data}    Run KeyWord If    '${行为_全局变量}'!='121' and '${业务_全局变量}' in ('181','182','187','188','827','828')    Create Dictionary    cust_id=${客户信息_全局变量["客户号"]}    fund_account_id=${客户信息_全局变量["资金账户"]}    account_id=${客户信息_全局变量["证券账户"]}    cl_ord_no=${订单编号}    etf_purchase_redemption_flag=1
    ...    ELSE IF    '${行为_全局变量}'!='121' and '${业务_全局变量}' not in ('181','182','187','188','827','828')    Create Dictionary    cust_id=${客户信息_全局变量["客户号"]}    fund_account_id=${客户信息_全局变量["资金账户"]}    account_id=${客户信息_全局变量["证券账户"]}    cl_ord_no=${订单编号}
    ...    ELSE    Create Dictionary    cust_id=${客户代码_全局变量}    fund_account_id=${资金账户_全局变量}    account_id=${股东账户_全局变量}    cl_ord_no=${订单编号}
    ${resp}    POST接口下单请求_UTP数据银行    114    ${env_data}    ReqTradeOrderQuery    OnRspTradeOrderQueryResult
    log    ${resp}
    ${用户系统消息序号}    set variable    ${resp[0]["data"]["client_seq_id"]}
    Should Be Equal As Strings    成功    ${resp[0]["message"]}
    #获取数据
    ${返回码}    ${返回数据}    GET获取返回数据_华锐API    ${用户系统消息序号}
    ${返回数据}    Set Variable    ${返回数据["order_array"]}
    [Return]    ${返回码}    ${返回数据}

ReqETFQueryOrderEx_ETF申赎成交查询
    [Arguments]    ${订单编号}=${订单编号_全局变量}    ${客户信息}=${客户信息_全局变量}
    ${env_data}    Run KeyWord If    '${行为_全局变量}'!='121'    Create Dictionary    cust_id=${客户信息_全局变量["客户号"]}    fund_account_id=${客户信息_全局变量["资金账户"]}    account_id=${客户信息_全局变量["证券账户"]}    cl_ord_no=${订单编号}    security_id=${证券代码_全局变量}    market_id=${客户信息_全局变量["市场代码"]}
    ...    ELSE    Create Dictionary    cust_id=${客户代码_全局变量}    fund_account_id=${资金账户_全局变量}    account_id=${股东账户_全局变量}    cl_ord_no=${订单编号}
    ${resp}    POST接口下单请求_UTP数据银行    130    ${env_data}    ReqETFQueryOrderEx    OnRspEtfTradeOrderQueryResult
    log    ${resp}
    ${用户系统消息序号}    set variable    ${resp[0]["data"]["client_seq_id"]}
    Should Be Equal As Strings    成功    ${resp[0]["message"]}
    #获取数据
    ${返回码}    ${返回数据}    GET获取返回数据_华锐API    ${用户系统消息序号}
    ${返回数据}    Set Variable    ${返回数据["order_array"]}
    [Return]    ${返回码}    ${返回数据}

ReqIPOQtyQuery_新股发行申购额度查询
    [Arguments]    ${订单编号}=${订单编号_全局变量}    ${客户信息}=${客户信息_全局变量}
    [Return]    ${返回码}    ${返回数据}

ReqTIBIPOQtyQuery_科创板新股发行申购额度查询
    [Arguments]    ${订单编号}=${订单编号_全局变量}    ${客户信息}=${客户信息_全局变量}
    [Return]    ${返回码}    ${返回数据}

ReqExtQueryNewSharelnfo_新股清单查询
    [Arguments]    ${订单编号}=${订单编号_全局变量}    ${客户信息}=${客户信息_全局变量}
    [Return]    ${返回码}    ${返回数据}

ReqExtQueryShareEx_增强股份查询
    [Arguments]    ${证券代码}=${证券代码_全局变量}
    ${env_data}    Run KeyWord If    '${行为_全局变量}'!='121'    Create Dictionary    cust_id=${客户信息_全局变量["客户号"]}    fund_account_id=${客户信息_全局变量["资金账户"]}    account_id=${客户信息_全局变量["证券账户"]}    security_id=${证券代码}
    ...    ELSE    Create Dictionary    cust_id=${客户代码_全局变量}    fund_account_id=${资金账户_全局变量}    account_id=${股东账户_全局变量}    security_id=${证券代码}
    ${resp}    POST接口下单请求_UTP数据银行    140    ${env_data}    ReqExtQueryShareEx    OnRspExtQueryResultShareEx
    log    ${resp}
    ${用户系统消息序号}    set variable    ${resp[0]["data"]["client_seq_id"]}
    Should Be Equal As Strings    成功    ${resp[0]["message"]}
    #获取数据
    ${返回码}    ${返回数据}    GET获取返回数据_华锐API    ${用户系统消息序号}
    ${返回数据}    Set Variable    ${返回数据["order_array"]}
    [Return]    ${返回码}    ${返回数据}

ReqTradeOrderExQuery_增强成交查询
    [Arguments]    ${订单编号}=${订单编号_全局变量}
    ${env_data}    Run KeyWord If    '${行为_全局变量}'!='121' and '${业务_全局变量}' in ('181','182','187','188','827','828')    Create Dictionary    cust_id=${客户信息_全局变量["客户号"]}    fund_account_id=${客户信息_全局变量["资金账户"]}    account_id=${客户信息_全局变量["证券账户"]}    cl_ord_no=${订单编号}    etf_purchase_redemption_flag=1
    ...    ELSE IF    '${行为_全局变量}'!='121' and '${业务_全局变量}' not in ('181','182','187','188','827','828')    Create Dictionary    cust_id=${客户信息_全局变量["客户号"]}    fund_account_id=${客户信息_全局变量["资金账户"]}    account_id=${客户信息_全局变量["证券账户"]}    cl_ord_no=${订单编号}
    ...    ELSE    Create Dictionary    cust_id=${客户代码_全局变量}    fund_account_id=${资金账户_全局变量}    account_id=${股东账户_全局变量}    cl_ord_no=${订单编号}
    ${resp}    POST接口下单请求_UTP数据银行    141    ${env_data}    ReqTradeOrderExQuery    OnRspTradeOrderQueryResult
    log    ${resp}
    ${用户系统消息序号}    set variable    ${resp[0]["data"]["client_seq_id"]}
    Should Be Equal As Strings    成功    ${resp[0]["message"]}
    #获取数据
    ${返回码}    ${返回数据}    GET获取返回数据_华锐API    ${用户系统消息序号}
    ${返回数据}    Set Variable    ${返回数据["order_array"]}
    [Return]    ${返回码}    ${返回数据}
