*** Settings ***
Resource          ../../公共目录/配置信息/环境配置信息.robot
Library           JSONLibrary

*** Keywords ***
证券信息查询_10301001
    [Arguments]    ${证券代码}=${证券代码_全局变量}    ${交易板块}=${交易板块_全局变量}
    [Documentation]    1.20211123 chm 新增
    ${resp}    POST接口下单请求_UTP数据银行    10301001    "STK_CODE": "${证券代码}","STKBD":"${交易板块}"    证券信息查询
    log    ${resp}
    ${返回码}    set variable    ${resp[0]["data"][0]}
    ${返回信息}    set variable    ${resp[0]["data"][1]}
    ${证券信息}    Set Variable    ${返回信息[0]}
    Set Global Variable    ${证券信息}
    ${交易市场_全局变量}    Set Variable    ${证券信息["STKEX"]}
    ${交易板块_全局变量}    Convert To String    ${证券信息["STKBD"]}
    ${货币代码_全局变量}    Convert To String    ${证券信息["CURRENCY"]}
    ${价位价差_全局变量}    Set Variable    ${证券信息["STK_SPREAD"]}
    Set Global Variable    ${交易市场_全局变量}
    Set Global Variable    ${交易板块_全局变量}
    Set Global Variable    ${货币代码_全局变量}
    Set Global Variable    ${价位价差_全局变量}

可用资金查询_10303001
    [Arguments]    ${资金账户}=${资金账户_全局变量}    ${货币代码}=${货币代码_全局变量}
    [Documentation]    1.20211123 chm 新增
    ${resp}    POST接口下单请求_UTP数据银行    10303001    "CUACCT_CODE": "${资金账户}","CURRENCY":"${货币代码}"    可用资金查询
    log    ${resp}
    ${返回码}    set variable    ${resp[0]["data"][0]}
    ${返回信息}    set variable    ${resp[0]["data"][1]}
    [Return]    ${返回码}    ${返回信息}

可用股份查询_10303002
    [Arguments]    ${资金账户}=${资金账户_全局变量}    ${证券代码}=${证券代码_全局变量}    ${客户信息}=${客户信息_全局变量}
    [Documentation]    1.20211123 chm 新增
    ${resp}    POST接口下单请求_UTP数据银行    10303002    "CUACCT_CODE": "${资金账户}","STK_CODE":"${证券代码}","STKPBU":"${客户信息['STKPBU']}"    可用股份查询
    log    ${resp}
    log    ${客户信息['STKPBU']}
    ${返回码}    set variable    ${resp[0]["data"][0]}
    ${返回信息}    Get Value From Json    ${resp}    $..data[1][?(@.STKPBU=="${客户信息['STKPBU']}")]
    [Return]    ${返回码}    ${返回信息}

当日委托查询_10303003
    [Arguments]    ${合同序号}=${合同序号_全局变量}    ${资金账户}=${资金账户_全局变量}
    [Documentation]    1.20211123 chm 新增
    ${resp}    POST接口下单请求_UTP数据银行    10303003    "CUACCT_CODE": "${资金账户}","ORDER_ID":"${合同序号}"    当日委托查询
    log    ${resp}
    ${返回码}    set variable    ${resp[0]["data"][0]}
    ${返回信息}    set variable    ${resp[0]["data"][1]}
    [Return]    ${返回码}    ${返回信息}

当日成交查询_10303004
    [Arguments]    ${资金账户}=${资金账户_全局变量}    ${合同序号}=${合同序号_全局变量}
    [Documentation]    1.20211123 chm 新增
    ${resp}    POST接口下单请求_UTP数据银行    10303004    "CUACCT_CODE": "${资金账户}","ORDER_ID":"${合同序号}"    当日成交查询
    log    ${resp}
    ${返回码}    set variable    ${resp[0]["data"][0]}
    ${返回信息}    set variable    ${resp[0]["data"][1]}
    [Return]    ${返回码}    ${返回信息}
