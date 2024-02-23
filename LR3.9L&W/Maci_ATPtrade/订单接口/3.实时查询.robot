*** Settings ***
Resource          ../公共目录/配置信息/环境配置信息.robot
Library           JSONLibrary
Resource          ../公共目录/通用操作/数据库操作.robot

*** Keywords ***
担保品证券信息查询_10321010
    [Arguments]    ${证券代码}=${证券代码_全局变量}
    [Documentation]    1.20221123 ch 新增
    ${resp}    POST接口下单请求_UTP数据银行    10321010    "STK_CODE": "${证券代码}"    担保品证券信息查询
    log    ${resp}
    ${返回码}    set variable    ${resp[0]["data"][0]}
    ${返回信息}    set variable    ${resp[0]["data"][1]}
    ${证券信息}    Set Variable    ${返回信息[0]}
    Set Global Variable    ${证券信息}
    ${交易市场_全局变量}    Set Variable    ${证券信息["STKEX"]}
    ${交易板块_全局变量}    Convert To String    ${证券信息["STKBD"]}
    ${担保品折算率_全局变量}    Set Variable    ${证券信息["COLLAT_RATIO"]}
    ${信用资金使用标志}    Convert To String    ${证券信息["CREDIT_FUND_USE_FLAG"]}
    #${货币代码_全局变量}    Convert To String    ${证券信息["CURRENCY"]}
    #${价位价差_全局变量}    Set Variable    ${证券信息["STK_SPREAD"]}
    Set Global Variable    ${交易市场_全局变量}
    Set Global Variable    ${交易板块_全局变量}
    Set Global Variable    ${担保品折算率_全局变量}
    Set Global Variable    ${信用资金使用标志}
    #Set Global Variable    ${货币代码_全局变量}
    #Set Global Variable    ${价位价差_全局变量}

可用资金查询_10303001
    [Arguments]    ${资金账户}=${资金账户_全局变量}    ${货币代码}=${货币代码_全局变量}
    [Documentation]    1.20211123 chm 新增
    ${resp}    POST接口下单请求_UTP数据银行    10303001    "CUACCT_CODE": "${资金账户}","CURRENCY":"${货币代码}"    可用资金查询
    log    ${resp}
    ${返回码}    set variable    ${resp[0]["data"][0]}
    ${返回信息}    set variable    ${resp[0]["data"][1]}
    [Return]    ${返回码}    ${返回信息}

融资融券合约_10323001_备份
    [Arguments]    ${资金账户}=${资金账户_全局变量}    ${合约类型}=${合约类型_全局变量}    ${合同序号}=${合同序号_全局变量}
    [Documentation]    1.20230307 ch 新增
    ${resp}    POST接口下单请求_UTP数据银行    10323001    "CUACCT_CODE": "${资金账户}","CONTRACT_TYPE":"${合约类型}","ORDER_ID":"${合同序号}"    融资融券合约查询
    log    ${resp}
    ${返回码}    set variable    ${resp[0]["data"][0]}
    ${返回信息}    set variable    ${resp[0]["data"][1]}
    [Return]    ${返回码}    ${返回信息}

融资融券合约_10323001
    [Arguments]    ${资金账户}=${资金账户_全局变量}    ${合约类型}=${合约类型_全局变量}    ${证券业务}=${证券业务_全局变量}    ${合同序号}=${合同序号_全局变量}
    [Documentation]    1.20230307 ch 新增
    ${接口参数}    Run KeyWord If    '${证券业务}' in ('702','703','直接还款')    Set Variable    "CUACCT_CODE": "${资金账户}","CONTRACT_TYPE":"${合约类型}","ORDER_ID":"${合同序号}"
    ...    ELSE    Set Variable    "CUACCT_CODE": "${资金账户}","CONTRACT_TYPE":"${合约类型}","STK_CODE":"${证券代码_全局变量}"
    ${resp}    POST接口下单请求_UTP数据银行    10323001    ${接口参数}    融资融券合约查询
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
    log    ${返回信息}
    [Return]    ${返回码}    ${返回信息}

客户负债查询_10323006
    [Arguments]    ${资金账户}=${资金账户_全局变量}    ${货币代码}=${货币代码_全局变量}
    [Documentation]    1.20221216 ch 新增
    ${resp}    POST接口下单请求_UTP数据银行    10323006    "CUACCT_CODE": "${资金账户}","CURRENCY":"${货币代码}"    信用客户资产负债查询
    log    ${resp}
    ${返回码}    set variable    ${resp[0]["data"][0]}
    ${返回信息}    set variable    ${resp[0]["data"][1]}
    [Return]    ${返回码}    ${返回信息}

股份头寸查询_10323009
    [Arguments]    ${资金账户}=${资金账户_全局变量}    ${证券代码}=${证券代码_全局变量}    ${客户信息}=${客户信息_全局变量}    ${头寸编号}=${头寸编号_全局变量}
    [Documentation]    1.20221216 ch 新增
    ${resp}    POST接口下单请求_UTP数据银行    10323009    "CUACCT_CODE": "${资金账户}","STK_CODE":"${证券代码}","STKEX":"${客户信息['STKEX']}","STKBD":"${客户信息['STKBD']}","CASH_NO": "${头寸编号}"    融资融券股份头寸查询
    log    ${resp}
    ${返回码}    set variable    ${resp[0]["data"][0]}
    ${返回信息}    set variable    ${resp[0]["data"][1]}
    [Return]    ${返回码}    ${返回信息}

资金头寸查询_10323008
    [Arguments]    ${头寸编号}=${头寸编号_全局变量}
    [Documentation]    1.20221216 ch 新增
    ${resp}    POST接口下单请求_UTP数据银行    10323008    "CASH_NO": "${头寸编号}"    资金头寸查询
    log    ${resp}
    ${返回码}    set variable    ${resp[0]["data"][0]}
    ${返回信息}    set variable    ${resp[0]["data"][1]}
    [Return]    ${返回码}    ${返回信息}

最大可交易数量计算查询_10302010
    [Arguments]    ${客户代码}=${客户代码_全局变量}    ${资金账户}=${资金账户_全局变量}    ${证券代码}=${证券代码_全局变量}    ${股东代码}=${客户信息_全局变量['STK_TRDACCT']}    ${交易板块}=${交易板块_全局变量}    ${证券业务}=${证券业务_全局变量}    ${业务行为}=${业务行为_全局变量}    ${委托价格}=${委托价格_全局变量}
    [Documentation]    1.20220110 ch 新增
    ${resp}    POST接口下单请求_UTP数据银行    10302010    "CUST_CODE": "${客户代码}","CUACCT_CODE": "${资金账户}","STKBD": "${交易板块}","STK_CODE": "${证券代码}","STK_BIZ": "${证券业务}","STK_BIZ_ACTION": "${业务行为}","TRDACCT": "${股东代码}","ORDER_PRICE": "${委托价格}"    最大可交易数计算
    log    ${resp}
    ${返回码}    set variable    ${resp[0]["data"][0]}
    ${返回信息}    set variable    ${resp[0]["data"][1]}
    [Return]    ${返回码}    ${返回信息}

融券合约汇总查询_10323031
    [Arguments]    ${资金账户}=${资金账户_全局变量}    ${证券代码}=${证券代码_全局变量}    ${交易板块}=${交易板块_全局变量}
    [Documentation]    1.20221216 ch 新增
    ${resp}    POST接口下单请求_UTP数据银行    10323031    "CUACCT_CODE": "${资金账户}","STKBD": "${交易板块}","STK_CODE": "${证券代码}"    融券合约汇总查询
    log    ${resp}
    ${返回码}    set variable    ${resp[0]["data"][0]}
    ${返回信息}    set variable    ${resp[0]["data"][1]}
    [Return]    ${返回码}    ${返回信息}

融资合约汇总查询_10323030
    [Arguments]    ${资金账户}=${资金账户_全局变量}    ${证券代码}=${证券代码_全局变量}    ${交易板块}=${交易板块_全局变量}
    [Documentation]    1.20221216 ch 新增
    ${resp}    POST接口下单请求_UTP数据银行    10323030    "CUACCT_CODE": "${资金账户}","STKBD": "${交易板块}","STK_CODE": "${证券代码}"    融资合约汇总查询
    log    ${resp}
    ${返回码}    set variable    ${resp[0]["data"][0]}
    ${返回信息}    set variable    ${resp[0]["data"][1]}
    #融资融券合约
    [Return]    ${返回码}    ${返回信息}

证券市值额度查询_10301034
    [Arguments]    ${股东账户}=${股东代码_全局变量}
    [Documentation]    ch 新增
    ${resp}    POST接口下单请求_UTP数据银行    10301034    "TRDACCT": "${股东账户}"    证券市值额度查询
    log    ${resp}
    ${返回码}    set variable    ${resp[0]["data"][0]}
    ${返回信息}    set variable    ${resp[0]["data"][1]}
    [Return]    ${返回码}    ${返回信息}

股东账户查询_10303005
    [Arguments]    ${股东账户}=${股东代码_全局变量}
    [Documentation]    ch 新增
    ${resp}    POST接口下单请求_UTP数据银行    10303005    "TRDACCT": "${股东账户}"    股东账户查询
    log    ${resp}
    ${返回码}    set variable    ${resp[0]["data"][0]}
    ${返回信息}    set variable    ${resp[0]["data"][1]}
    [Return]    ${返回码}    ${返回信息}

实时偿还明细_10321012
    [Arguments]    ${客户代码}=${客户代码_全局变量}    ${交易时间}=${交易时间_全局变量}
    [Documentation]    ch 新增
    ${resp}    POST接口下单请求_UTP数据银行    10321012    "CUST_CODE": "${客户代码}","TRD_DATE":"${交易时间}"    实时偿还明细
    log    ${resp}
    ${返回码}    set variable    ${resp[0]["data"][0]}
    ${返回信息}    set variable    ${resp[0]["data"][1]}
    [Return]    ${返回码}    ${返回信息}
