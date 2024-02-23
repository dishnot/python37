*** Settings ***
Library           JSONLibrary
Resource          ../../公共目录/配置信息/环境配置信息.robot
Resource          ../../公共目录/通用操作/常用关键字.robot
Resource          ../../公共目录/配置信息/TSP环境配置信息.robot
Resource          ../../公共目录/配置信息/POST接口调用.robot
Resource          ../../公共目录/配置信息/接口入参数据.robot

*** Keywords ***
F400030_回购合约查询

F400020_股份查询

F400001_快订资金查询
    [Arguments]    ${url}    ${uri}    ${市场}=${EMPTY}
    ${固定入参数据}    Run KeyWord    固定入参数据
    ${业务入参数据}    Set Variable    "account":"${资金账户}","market":"${市场}"
    ${入参数据}    set variable    ${固定入参数据},${业务入参数据}
    ${resp}    POST接口请求_ZT    ${url}    ${uri}    ${入参数据}
    log    ${resp}
    ${返回码}    set variable    ${resp[0]["code"]}
    ${返回信息}    set variable    ${resp[0]["data"][0]}
    #${返回信息}    Get Value From Json    ${resp}    $..data[1][?(@.STKPBU=="${客户信息['STKPBU']}")]
    [Return]    ${返回码}    ${返回信息}

F400002_资金划拨
    [Arguments]    ${url}    ${uri}    ${划拨方向}=${划拨方向_全局变量}    ${币种}=0
    ${固定入参数据}    Run KeyWord    固定入参数据
    ${业务入参数据}    Set Variable    "account":"${资金账户}","direct":"${划拨方向}","currency":"${币种}"
    ${入参数据}    set variable    ${固定入参数据},${业务入参数据}
    ${resp}    POST接口请求_ZT    ${url}    ${uri}    ${入参数据}
    log    ${resp}
    ${返回码}    set variable    ${resp[0]["code"]}
    ${返回信息}    set variable    ${resp[0]["data"][0]}
    [Return]    ${返回码}    ${返回信息}

F400003_双中心资金划拨
    [Arguments]    ${url}    ${uri}    ${划拨方向}=${TSP划拨方向_全局变量}    ${发生金额}=${发生金额_全局变量}    ${币种}=0
    ${固定入参数据}    Run KeyWord    固定入参数据
    ${业务入参数据}    Set Variable    "account":"${资金账户}","direct":"${划拨方向}","currency":"${币种}","bizAmount":"${发生金额}"
    ${入参数据}    set variable    ${固定入参数据},${业务入参数据}
    ${resp}    POST接口请求_ZT    ${url}    ${uri}    ${入参数据}
    log    ${resp}
    ${返回码}    set variable    ${resp[0]["code"]}
    ${返回信息}    set variable    ${resp[0]["data"][0]}
    ${流水号获取}    Set Variable    ${返回信息}[serialNo]
    ${流水号_全局变量}    Set Variable    ${流水号获取}[0]
    Set Global Variable    ${流水号_全局变量}
    [Return]    ${返回码}    ${返回信息}

F400004_双中心资金划拨
    [Arguments]    ${url}    ${uri}    ${划拨方向}=${划拨方向_全局变量}    ${发生金额}=${发生金额_全局变量}    ${币种}=0
    ${固定入参数据}    Run KeyWord    固定入参数据
    ${业务入参数据}    Set Variable    "account":"${资金账户}","direct":"${划拨方向}","currency":"${币种}","bizAmount":"${发生金额}"
    ${入参数据}    set variable    ${固定入参数据},${业务入参数据}
    ${resp}    POST接口请求_ZT    ${url}    ${uri}    ${入参数据}
    log    ${resp}
    ${返回码}    set variable    ${resp[0]["code"]}
    ${返回信息}    set variable    ${resp[0]["data"][0]}
    [Return]    ${返回码}    ${返回信息}
