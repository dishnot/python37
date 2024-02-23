*** Settings ***
Library           RequestsLibrary
Resource          ../../公共目录/配置信息/环境配置信息.robot

*** Keywords ***
Connect_连接函数
    [Arguments]    ${环境}=${环境_全局变量}
    ${resp}    POST环境请求_UTP    {"opt_type": "startEnv","id":${环境["序号"]},"env_name":"${环境["环境名称"]}","env_desc":"${环境["环境描述"]}","gate_user":"${环境["网关账户"]}","gate_password":"${环境["网关密码"]}","env_ip":"${环境["网关IP"]}","port":${环境["网关端口"]}}    1
    sleep    3
    log    ${resp["data"]["msg"]}

Close_连接关闭函数
    [Arguments]    ${环境}=${环境_全局变量}
    POST环境请求_UTP    {"opt_type": "closeEnv","id":${环境["序号"]},"env_name":"${环境["环境名称"]}","env_desc":"${环境["环境描述"]}","gate_user":"${环境["网关账户"]}","gate_password":"${环境["网关密码"]}","env_ip":"${环境["网关IP"]}","port":${环境["网关端口"]}}    1
    sleep    3

ReqCustLoginOther_账户登入函数
    ${env_data}    Run KeyWord If    '${行为_全局变量}'!='121'    Create Dictionary    cust_id=${客户信息_全局变量["客户号"]}    fund_account_id=${客户信息_全局变量["资金账户"]}    account_id=${客户信息_全局变量["证券账户"]}    branch_id=${客户信息_全局变量["营业部"]}    login_mode=1    password=123444
    ...    ELSE    Create Dictionary    cust_id=${客户代码_全局变量}    fund_account_id=${资金账户_全局变量}    account_id=${股东账户_全局变量}    login_mode=1    password=123444
    ${resp}    POST接口下单请求_UTP数据银行    111    ${env_data}    ReqCustLoginOther    OnRspCustLoginResp
    log    ${resp}
    ${用户系统消息序号}    set variable    ${resp[0]["data"]["client_seq_id"]}
    Should Be Equal As Strings    成功    ${resp[0]["message"]}
    ${返回数据}    GET获取返回数据_华锐API    ${用户系统消息序号}
