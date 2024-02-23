*** Settings ***
Resource          ../../公共目录/配置信息/环境配置信息.robot
Resource          ../../业务流程/检查点流程.robot

*** Keywords ***
ReqFundQuery_资金查询
    [Arguments]    ${客户信息}=${客户信息_全局变量}
    ${币种}    set variable    CNY
    ${env_data}    Create Dictionary    cust_id=${客户信息["客户号"]}    fund_account_id=${客户信息["资金账户"]}    account_id=${客户信息["证券账户"]}    currency=${币种}
    ${resp}    POST接口下单请求_UTP数据银行    116    ${env_data}    ReqFundQuery    OnRspFundQueryResult
    log    ${resp}
    ${用户系统消息序号}    set variable    ${resp[0]["data"]["client_seq_id"]}
    Should Be Equal As Strings    成功    ${resp[0]["message"]}
    #获取数据
    ${返回码}    ${返回数据}    GET获取返回数据_华锐API    ${用户系统消息序号}
    ${返回数据}    Create List    ${返回数据}
    [Return]    ${返回码}    ${返回数据}

ReqShareQuery_股份查询
    [Arguments]    ${证券代码}=${证券代码_全局变量}    ${客户信息}=${客户信息_全局变量}
    ${env_data}    Create Dictionary    cust_id=${客户信息["客户号"]}    fund_account_id=${客户信息["资金账户"]}    account_id=${客户信息["证券账户"]}    security_id=${证券代码}
    ${resp}    POST接口下单请求_UTP数据银行    117    ${env_data}    ReqShareQuery    OnRspShareQueryResult
    log    ${resp}
    ${用户系统消息序号}    set variable    ${resp[0]["data"]["client_seq_id"]}
    Should Be Equal As Strings    成功    ${resp[0]["message"]}
    #获取数据
    ${返回码}    ${返回数据}    GET获取返回数据_华锐API    ${用户系统消息序号}
    ${返回数据}    Set Variable    ${返回数据["order_array"]}
    [Return]    ${返回码}    ${返回数据}

ReqOrderQuery_订单查询
    [Arguments]    ${订单编号}=${订单编号_全局变量}    ${客户信息}=${客户信息_全局变量}
    ${env_data}    Create Dictionary    cust_id=${客户信息["客户号"]}    fund_account_id=${客户信息["资金账户"]}    account_id=${客户信息["证券账户"]}    cl_ord_no=${订单编号}
    ${resp}    POST接口下单请求_UTP数据银行    115    ${env_data}    ReqOrderQuery    OnRspOrderQueryResult
    log    ${resp}
    ${用户系统消息序号}    set variable    ${resp[0]["data"]["client_seq_id"]}
    Should Be Equal As Strings    成功    ${resp[0]["message"]}
    #获取数据
    ${返回码}    ${返回数据}    GET获取返回数据_华锐API    ${用户系统消息序号}
    ${返回数据}    Set Variable    ${返回数据["order_array"]}
    [Return]    ${返回码}    ${返回数据}

ReqTradeOrderQuery_成交查询
    [Arguments]    ${订单编号}=${订单编号_全局变量}    ${客户信息}=${客户信息_全局变量}
    ${env_data}    Create Dictionary    cust_id=${客户信息["客户号"]}    fund_account_id=${客户信息["资金账户"]}    account_id=${客户信息["证券账户"]}    cl_ord_no=${订单编号}
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
