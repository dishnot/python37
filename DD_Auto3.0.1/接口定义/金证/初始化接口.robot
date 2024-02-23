*** Settings ***
Library           DateTime
Resource          ../../公共目录/配置信息/环境配置信息.robot

*** Keywords ***
资金调整_10305004
    [Arguments]    ${调整资金}    ${划拨方向}=0    ${资金账户}=${资金账户_全局变量}    ${货币代码}=${货币代码_全局变量}    ${业务代码}=10990227    ${备注}=1
    [Documentation]    1.20211123 chm 新增
    ${划拨方向}    Run Keyword If    '${调整资金}'>'0'    Set Variable    0
    ...    ELSE    Set Variable    1
    ${调整金额}    Run Keyword If    '${调整资金}'>'0'    Set Variable    ${调整资金}
    ...    ELSE IF    '${调整资金}'<'0'    Evaluate    -${调整资金}
    ${unfixpram}    Set Variable    "CUACCT_CODE":"${资金账户}","CURRENCY":${货币代码},"BIZ_CODE":${业务代码},"DIRECT":${划拨方向},"FUND_AVL":${调整资金},"REMARK":"${备注}"
    log    ${fixpram_全局变量}${unfixpram}
    ${resp}    POST接口下单请求_UTP数据银行    10305004    ${fixpram_全局变量}${unfixpram}
    ${MSG}    set variable    ${resp[0]["data"][0][0]}
    ${MSG_LEVEL}    set variable    ${resp[0]["data"][0][1][0]}
    ${MSG_TEXT}    set variable    ${resp[0]["data"][0][2][0]}
    [Return]    ${MSG}    ${MSG_LEVEL}    ${MSG_TEXT}

股份调整_10305005
    [Arguments]    ${调整股份}    ${证券代码}=${证券代码_全局变量}    ${股份调整方向}=0    ${资金账户}=${资金账户_全局变量}    ${交易板块}=${交易板块_全局变量}    ${客户信息}=${客户信息_全局变量}    ${业务代码}=0    ${备注}=1    ${成本价}=1
    [Documentation]    1.20211123 chm 新增
    ${划拨方向}    Run Keyword If    '${调整股份}'>'0'    Set Variable    0
    ...    ELSE IF    ${调整股份}<'0'    Set Variable    1
    ${调整股份}    Run Keyword If    '${调整股份}'>'0'    Set Variable    ${调整股份}
    ...    ELSE IF    ${调整股份}<'0'    evaluate    -${调整股份}
    ${unfixpram}    Set Variable    "CUACCT_CODE":"${资金账户}","STKBD":"${交易板块}","TRDACCT":"${客户信息["STK_TRDACCT"]}","STK_CODE":"${证券代码}","STKPBU":"${客户信息["STKPBU"]}","BIZ_CODE":"${业务代码}","DIRECT":${股份调整方向},"STK_AVL":${调整股份},"REMARK":"${备注}","COST_PRICE":"${成本价}"
    log    ${fixpram_全局变量}${unfixpram}
    ${resp}    POST接口下单请求_UTP数据银行    10305005    ${fixpram_全局变量}${unfixpram}
    ${MSG}    set variable    ${resp[0]["data"][0][0]}
    ${MSG_LEVEL}    set variable    ${resp[0]["data"][0][1][0]}
    ${MSG_TEXT}    set variable    ${resp[0]["data"][0][2][0]}
    [Return]    ${MSG}    ${MSG_LEVEL}    ${MSG_TEXT}

交易协议临时查询_10304103
    [Arguments]    ${权限}    ${客户代码}=${客户代码_全局变量}
    [Documentation]    1.20211123 chm 新增
    ${unfixparam}    Set Variable    "CUST_CODE":${客户代码}
    ${resp}    POST接口下单请求_UTP数据银行    10304103    ${fixpram_全局变量}${unfixpram}
    log    ${resp}
    ${MSG}    set variable    ${resp[0]["data"][0][0]}
    ${MSG_LEVEL}    set variable    ${resp[0]["data"][0][1][0]}
    ${MSG_TEXT}    set variable    ${resp[0]["data"][0][2][0]}
    FOR    ${i}    IN    @{MSG_TEXT}
        log    ${i["CUST_AGMT_TYPE"]}
        ${是否存在权限}    Run Keyword And Return Status    Should Be Equal As Strings    ${i["CUST_AGMT_TYPE"]}    ${权限}
        Exit For Loop If    ${是否存在权限}
    END
    [Return]    ${是否存在权限}

交易协议临时设置_10304104
    [Arguments]    ${权限}    ${修改类型}    ${客户代码}=${客户代码_全局变量}
    [Documentation]    1.20211123 chm 新增
    ${日期}    Get Current Date    result_format=%Y%m%d
    ${权限类型}    Run Keyword If    '${修改类型}'=='0'    Set Variable    "ADD_BIZ_CODE":${修改类型}
    ...    ELSE IF    '${修改类型}'=='1'    Set Variable    "MDF_BIZ_CODE":${修改类型}
    ...    ELSE IF    '${修改类型}'=='2'    Set Variable    "DEL_BIZ_CODE":${修改类型}
    ${unfixpram}    Set Variable    ${权限类型},"CUST_CODE":"${客户代码}","TRDACCT":@,"CUST_AGMT_TYPE":${权限},"EFT_DATE":${日期},"EXP_DATE":${日期},"UPD_DATE":${日期}
    log    ${fixpram_全局变量}${unfixpram}
    ${resp}    POST接口下单请求_UTP数据银行    10304104    ${fixpram_全局变量}${unfixpram}
    ${MSG}    set variable    ${resp[0]["data"][0][0]}
    ${MSG_LEVEL}    set variable    ${resp[0]["data"][0][1][0]}
    ${MSG_TEXT}    set variable    ${resp[0]["data"][0][2][0]}
    [Teardown]
    [Return]    ${MSG}    ${MSG_LEVEL}    ${MSG_TEXT}
