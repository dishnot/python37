*** Settings ***
Resource          ../../公共目录/配置信息/环境配置信息.robot
Resource          ../../公共目录/通用操作/常用关键字.robot
Resource          ../../公共目录/配置信息/TSP环境配置信息.robot
Resource          ../../公共目录/配置信息/POST接口调用.robot
Resource          ../../公共目录/配置信息/接口入参数据.robot

*** Keywords ***
F900000_客户登录
    [Arguments]    ${无效1}    ${无效2}
    登录固参逻辑取值
    ${固定入参数据}    Run KeyWord    登录固定入参数据
    ${业务入参数据}    Run KeyWord    登录业务入参数据
    ${入参数据}    set variable    ${固定入参数据},${业务入参数据}
    ${resp}    POST接口请求_ZT    ${url}    F900000    ${入参数据}
    log    ${resp}
    ${返回码}    set variable    ${resp[0]["code"]}
    ${返回信息}    set variable    ${resp[0]["data"][0]}
    ${session_全局变量}    set variable    ${resp[0]["data"][0]}[session]
    Set Global Variable    ${session_全局变量}
    [Return]    ${返回码}    ${返回信息}

F900201_交易资金查询
    [Arguments]    ${url}    ${uri}    ${市场}=${EMPTY}    ${币种}=0
    ${固定入参数据}    Run KeyWord    固定入参数据
    ${业务入参数据}    Set Variable    "account":"${资金账户}","market":"${市场}","currency":"${币种}"
    ${入参数据}    set variable    ${固定入参数据},${业务入参数据}
    ${resp}    POST接口请求_ZT    ${url}    ${uri}    ${入参数据}
    log    ${resp}
    ${返回码}    set variable    ${resp[0]["code"]}
    ${返回信息}    set variable    ${resp[0]["data"][0]}
    [Return]    ${返回码}    ${返回信息}

F900202_可划拨资金查询
    [Arguments]    ${url}    ${uri}    ${划拨方向}=${划拨方向_全局变量}    ${币种}=0
    ${固定入参数据}    Run KeyWord    固定入参数据
    ${业务入参数据}    Set Variable    "account":"${资金账户}","direct":"${划拨方向}","currency":"${币种}"
    ${入参数据}    set variable    ${固定入参数据},${业务入参数据}
    ${resp}    POST接口请求_ZT    ${url}    ${uri}    ${入参数据}
    log    ${resp}
    ${返回码}    set variable    ${resp[0]["code"]}
    ${返回信息}    set variable    ${resp[0]["data"][0]}
    [Return]    ${返回码}    ${返回信息}

F900203_交易资金划拨
    [Arguments]    ${url}    ${uri}    ${划拨方向}=${TSP划拨方向_全局变量}    ${发生金额}=${发生金额_全局变量}    ${币种}=0
    ${固定入参数据}    Run KeyWord    固定入参数据
    ${业务入参数据}    Set Variable    "account":"${资金账户}","direct":"${划拨方向}","currency":"${币种}","bizAmount":"${发生金额}"
    ${入参数据}    set variable    ${固定入参数据},${业务入参数据}
    ${resp}    POST接口请求_ZT    ${url}    ${uri}    ${入参数据}
    log    ${resp}
    ${返回码}    set variable    ${resp[0]["code"]}
    ${返回信息}    set variable    ${resp[0]["data"][0]}
    ${流水号获取}    Set Variable    ${返回信息}[serialNo]
    ${流水号_全局变量}    Set Variable    ${流水号获取}
    Set Global Variable    ${流水号_全局变量}
    [Return]    ${返回码}    ${返回信息}

F900204_资金划拨
    [Arguments]    ${url}    ${uri}    ${划拨方向}=${划拨方向_全局变量}    ${发生金额}=${发生金额_全局变量}    ${币种}=0
    ${固定入参数据}    Run KeyWord    固定入参数据
    ${业务入参数据}    Set Variable    "account":"${资金账户}","direct":"${划拨方向}","currency":"${币种}","bizAmount":"${发生金额}"
    ${入参数据}    set variable    ${固定入参数据},${业务入参数据}
    ${resp}    POST接口请求_ZT    ${url}    ${uri}    ${入参数据}
    log    ${resp}
    ${返回码}    set variable    ${resp[0]["code"]}
    ${返回信息}    set variable    ${resp[0]["data"][0]}
    [Return]    ${返回码}    ${返回信息}

F900402_当日委托查询

F900404_当日成交查询

F910005_融资融券

F910100_头寸组查询

F910300_融资融券

F910401_股份头寸查询
