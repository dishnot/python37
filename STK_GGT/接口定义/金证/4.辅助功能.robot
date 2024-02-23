*** Settings ***
Resource          ../../公共目录/配置信息/环境配置信息.robot

*** Keywords ***
用户登录API_10301105
    [Arguments]    ${密码}=123444
    [Documentation]    1.20211123 chm 新增
    ${resp}    ${headers}    POST接口下单请求_UTP数据银行    10301105    "ACCT_TYPE":"Z","ACCT_ID": "${资金账户_全局变量}","USE_SCOPE": "0","ENCRYPT_KEY": "${密码}","AUTH_TYPE": "0","AUTH_DATA": "${密码}","THIRD_PARTY": "","ENCRYPT_TYPE": ""    用户登录API
    log    ${resp}
    ${返回码}    set variable    ${resp["data"][0]}
    ${返回信息}    set variable    ${resp["data"][1]}
    ${session_全局变量}    set variable    ${headers["session"]}
    Set Global Variable    ${session_全局变量}
    #把返回信息提取客户信息
    ${深圳_客户信息}    Create Dictionary
    ${深圳_港股通_客户信息}    Create Dictionary
    ${上海_客户信息}    Create Dictionary
    ${上海_港股通_客户信息}    Create Dictionary
    FOR    ${i}    IN    @{返回信息}
        ${STKEX}    Set Variable    ${i['STKEX']}
        ${STKBD}    Convert To String    ${i['STKBD']}
        ${STK_TRDACCT}    Convert To String    ${i['STK_TRDACCT']}
        ${STKPBU}    Convert To String    ${i['STKPBU']}
        Run Keyword If    '${STKEX}'=='0' and '${STKBD}'=='00'    Set To Dictionary    ${深圳_客户信息}    CUST_CODE=${i['CUST_CODE']}    CUACCT_CODE=${i['CUACCT_CODE']}    STKEX=${i['STKEX']}    STKBD=${i['STKBD']}    STK_TRDACCT=${i['STK_TRDACCT']}    TRDACCT_STATUS=${i['TRDACCT_STATUS']}    STKPBU=${i['STKPBU']}    ACCT_TYPE=${i['ACCT_TYPE']}    INT_ORG=${i['INT_ORG']}
        ...    ELSE IF    '${STKEX}'=='0' and '${STKBD}'=='03'    Set To Dictionary    ${深圳_港股通_客户信息}    CUST_CODE=${i['CUST_CODE']}    CUACCT_CODE=${i['CUACCT_CODE']}    STKEX=${i['STKEX']}    STKBD=${i['STKBD']}    STK_TRDACCT=${i['STK_TRDACCT']}    TRDACCT_STATUS=${i['TRDACCT_STATUS']}    STKPBU=${i['STKPBU']}    ACCT_TYPE=${i['ACCT_TYPE']}    INT_ORG=${i['INT_ORG']}
        ...    ELSE IF    '${STKEX}'=='1' and '${STKBD}'=='13'    Set To Dictionary    ${上海_港股通_客户信息}    CUST_CODE=${i['CUST_CODE']}    CUACCT_CODE=${i['CUACCT_CODE']}    STKEX=${i['STKEX']}    STKBD=${i['STKBD']}    STK_TRDACCT=${i['STK_TRDACCT']}    TRDACCT_STATUS=${i['TRDACCT_STATUS']}    STKPBU=${i['STKPBU']}    ACCT_TYPE=${i['ACCT_TYPE']}    INT_ORG=${i['INT_ORG']}
        ...    ELSE IF    '${STKEX}'=='1' and '${STKBD}'=='10'    Set To Dictionary    ${上海_客户信息}    CUST_CODE=${i['CUST_CODE']}    CUACCT_CODE=${i['CUACCT_CODE']}    STKEX=${i['STKEX']}    STKBD=${i['STKBD']}    STK_TRDACCT=${i['STK_TRDACCT']}    TRDACCT_STATUS=${i['TRDACCT_STATUS']}    STKPBU=${i['STKPBU']}    ACCT_TYPE=${i['ACCT_TYPE']}    INT_ORG=${i['INT_ORG']}
    END
    log    ${深圳_客户信息}
    log    ${上海_客户信息}
    log    ${深圳_港股通_客户信息}
    log    ${上海_港股通_客户信息}
    Set Global Variable    ${上海_港股通_客户信息}
    Set Global Variable    ${深圳_港股通_客户信息}
    Set Global Variable    ${深圳_客户信息}
    Set Global Variable    ${上海_客户信息}
    ${客户信息_全局变量}    Run Keyword If    '${交易板块_全局变量}'=='00'    Set Variable    ${深圳_客户信息}
    ...    ELSE IF    '${交易板块_全局变量}'=='10'    Set Variable    ${上海_客户信息}
    ...    ELSE IF    '${交易板块_全局变量}'=='03'    Set Variable    ${深圳_港股通_客户信息}
    ...    ELSE IF    '${交易板块_全局变量}'=='13'    Set Variable    ${上海_港股通_客户信息}
    ${客户代码_全局变量}    Set Variable    ${i['CUST_CODE']}
    Set Global Variable    ${客户信息_全局变量}
    Set Global Variable    ${客户代码_全局变量}
