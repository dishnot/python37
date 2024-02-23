*** Settings ***
Resource          ../../公共目录/配置信息/环境配置信息.robot

*** Keywords ***
买卖委托__10302001
    [Arguments]    ${委托数量}    ${客户代码}=${客户代码__全局变量}    ${资金账户}=${资金账户_全局变量}    ${交易板块}=${交易板块_全局变量}    ${证券代码}=${证券代码__全局变量}    ${委托价格}=${委托价格_全局变量}    ${证券业务}=${证券业务_全局变量}    ${业务行为}=${业务行为_全局变量}    ${交易单元}=${客户信息_全局变量['STKPBU']}    ${股东代码}=${客户信息_全局变量['STK_TRDACCT']}
    [Documentation]    1.20211123 chm 新增
    ${resp}    POST接口下单请求_UTP数据银行    10302001    "CUST_CODE": "${客户代码}","CUACCT_CODE": "${资金账户}","STKBD": "${交易板块}","STK_CODE": "${证券代码}","ORDER_PRICE": "${委托价格}","ORDER_QTY": "${委托数量}","STK_BIZ": "${证券业务}","STK_BIZ_ACTION": "${业务行为}","STKPBU": "${交易单元}","TRDACCT": "${股东代码}"    买卖委托
    log    ${resp}
    ${返回码}    set variable    ${resp[0]["data"][0]}
    ${返回信息}    set variable    ${resp[0]["data"][1]}
    [Return]    ${返回码}    ${返回信息}

委托撤单_10302004
    [Arguments]    ${资金账户}=${资金账户_全局变量}    ${交易板块}=${交易板块__全局变量}    ${合同序号}=${合同序号_全局变量}
    [Documentation]    1.20211123 chm 新增
    ${resp}    POST接口下单请求_UTP数据银行    10302004    "CUACCT_CODE": "${资金账户}","STKBD": "${交易板块}","ORDER_ID": "${合同序号}"    委托撤单
    log    ${resp}
    ${返回码}    set variable    ${resp[0]["data"][0]}
    ${返回信息}    set variable    ${resp[0]["data"][1]}
    [Return]    ${返回码}    ${返回信息}

新股申购__10302001
    [Arguments]    ${委托数量}    ${客户代码}=${客户代码__全局变量}    ${资金账户}=${资金账户_全局变量}    ${交易板块}=${交易板块_全局变量}    ${证券代码}=${证券代码__全局变量}    ${证券业务}=${证券业务_全局变量}    ${业务行为}=${业务行为_全局变量}    ${交易单元}=${客户信息_全局变量['STKPBU']}    ${股东代码}=${客户信息_全局变量['STK_TRDACCT']}
    [Documentation]    1.20211123 chm 新增
    ${交易单元}    Convert To String    ${客户信息_全局变量['STKPBU']}
    ${股东代码}    Convert To String    ${客户信息_全局变量['STK_TRDACCT']}
    ${接口入参}    Create Dictionary    lCustCode=${客户代码}    lCuacctCode=${资金账户}    sStkbd=${交易板块}    sStkCode=${证券代码}    lOrderQty=${委托数量}    iStkBiz=${证券业务}    iStkBizAction=${业务行为}    sStkpbu=${交易单元}    sTrdacct=${股东代码}
    log    功能号:10302001|参数：${接口入参}
    ${返回码}    ${返回信息}    route    10302001    ${接口入参}
    log    返回码：${返回码}|返回信息：${返回信息}
    [Return]    ${返回码}    ${返回信息}

买卖委托(极速)__10302102
    [Arguments]    ${委托数量}    ${资金账户}=${资金账户_全局变量}    ${交易板块}=${交易板块_全局变量}    ${证券代码}=${证券代码__全局变量}    ${委托价格}=${委托价格_全局变量}    ${证券业务}=${证券业务_全局变量}    ${业务行为}=${业务行为_全局变量}    ${股东代码}=${客户信息_全局变量['STK_TRDACCT']}    ${交易单元}=${客户信息_全局变量['STKPBU']}
    ${resp}    POST接口下单请求_UTP数据银行    10302102    "CUACCT_CODE": "${资金账户}","STKBD": "${交易板块}","STK_CODE": "${证券代码}","ORDER_PRICE": "${委托价格}","ORDER_QTY": "${委托数量}","STK_BIZ": "${证券业务}","STK_BIZ_ACTION": "${业务行为}","TRDACCT": "${股东代码}","STKPBU":"${交易单元}"    买卖委托（极速）
    log    ${resp}
    ${返回码}    set variable    ${resp[0]["data"][0]}
    ${返回信息}    set variable    ${resp[0]["data"][1]}
    [Return]    ${返回码}    ${返回信息}

委托撤单(极速)_10302104
    [Arguments]    ${资金账户}=${资金账户_全局变量}    ${交易板块}=${交易板块__全局变量}    ${合同序号}=${合同序号_全局变量}    ${证券业务}=${证券业务_全局变量}
    ${resp}    POST接口下单请求_UTP数据银行    10302104    "CUACCT_CODE": "${资金账户}","STKBD": "${交易板块}","ORDER_ID": "${合同序号}","STK_BIZ": "${证券业务}"    委托撤单 （极速）
    log    ${resp}
    ${返回码}    set variable    ${resp[0]["data"][0]}
    ${返回信息}    set variable    ${resp[0]["data"][1]}
    [Return]    ${返回码}    ${返回信息}

ETF篮子委托_10302019
    [Arguments]    ${委托数量}    ${客户代码}=${客户代码__全局变量}    ${资金账户}=${资金账户_全局变量}    ${交易板块}=${交易板块_全局变量}    ${交易类型}=${交易类型_全局}    ${证券代码}=${证券代码__全局变量}    ${证券业务}=${证券业务_全局变量}    ${业务行为}=${业务行为_全局变量}    ${交易单元}=${客户信息_全局变量['STKPBU']}    ${股东代码}=${客户信息_全局变量['STK_TRDACCT']}
    ${resp}    POST接口下单请求_UTP数据银行    10302019    "CUST_CODE": "${客户代码}","CUACCT_CODE": "${资金账户}","STKBD": "${交易板块}","ETF_CODE": "${证券代码}","BIZ_TYPE": "${交易类型}","ORDER_QTY": "${委托数量}","STK_BIZ": "${证券业务}","STK_BIZ_ACTION": "${业务行为}","STKPBU": "${交易单元}","TRDACCT": "${股东代码}"    ETF篮子委托
    log    ${resp}
    ${返回码}    set variable    ${resp[0]["data"][0]}
    ${返回信息}    set variable    ${resp[0]["data"][1]}
    [Return]    ${返回码}    ${返回信息}
