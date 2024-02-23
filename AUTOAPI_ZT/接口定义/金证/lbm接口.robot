*** Settings ***
Library           DateTime
Resource          ../../公共目录/配置信息/环境配置信息.robot

*** Keywords ***
密码重置_10304012
    [Arguments]    ${客户账户}=${客户账户_全局变量}    ${交易密码}=123444    ${默认值}=0
    ${unfixpram}    Set Variable    "USER_CODE":"${客户账户}","AUTH_DATA":${交易密码},"OPERATION_TYPE":${默认值}
    log    ${fixpram_全局变量}${unfixpram}
    ${resp}    POST接口下单请求_UTP数据银行    10304012    ${fixpram_全局变量}${unfixpram}
    ${MSG}    set variable    ${resp[0]["data"][0][0]}
    ${MSG_LEVEL}    set variable    ${resp[0]["data"][0][1][0]}
    ${MSG_TEXT}    set variable    ${resp[0]["data"][0][2][0]}
    ${当前资金}    set variable    ${resp}
    #Set Global Variable    ${当前资金}
    [Return]    ${MSG}    ${MSG_LEVEL}    ${MSG_TEXT}

指定股东账户查询_10303170
    [Arguments]    ${客户账户}=${客户账户_全局变量}
    ${unfixpram}    Set Variable    "CUST_CODE":"${客户账户}"
    log    ${fixpram_全局变量}${unfixpram}
    ${resp}    POST接口下单请求_UTP数据银行    10303170    ${fixpram_全局变量}${unfixpram}
    ${MSG}    set variable    ${resp[0]["data"][0][0]}
    ${MSG_LEVEL}    set variable    ${resp[0]["data"][0][1][0]}
    ${MSG_TEXT}    set variable    ${resp[0]["data"][0][2][0]}
    ${当前资金}    set variable    ${resp}
    #Set Global Variable    ${当前资金}
    [Return]    ${MSG}    ${MSG_LEVEL}    ${MSG_TEXT}

全股东账户查询_10303170
    log    ${fixpram_全局变量}
    ${resp}    POST接口下单请求_UTP数据银行    10303170    ${fixpram_全局变量}
    ${MSG}    set variable    ${resp[0]["data"][0][0]}
    ${MSG_LEVEL}    set variable    ${resp[0]["data"][0][1][0]}
    ${MSG_TEXT}    set variable    ${resp[0]["data"][0][2][0]}
    ${当前资金}    set variable    ${resp}
    #Set Global Variable    ${当前资金}
    [Return]    ${MSG}    ${MSG_LEVEL}    ${MSG_TEXT}

股东账户状态修改_10301486
    [Arguments]    ${客户代码}=${客户代码_全局}    ${资产账户}=${资产账户_全局}    ${内部机构}=${内部机构_全局}    ${交易市场}=${交易市场_全局}    ${交易板块}=${交易板块_全局}    ${交易账户}=${交易账户_全局}    ${交易账户名称}=${交易账户名称_全局}    ${交易账户类型}=${交易账户类型_全局}    ${交易账户类别}=${交易账户类别_全局}    ${报盘交易账户}=${报盘交易账户_全局}    ${交易指定状态}=${交易指定状态_全局}    ${回购指定状态}=${回购指定状态_全局}    ${交易单元}=${交易单元_全局}    ${主股东账户标志}=${主股东账户标志_全局}    ${开户日期}=${开户日期_全局}    ${修改状态}=1
    ...    ${交易账户状态}=0
    ${unfixpram}    Set Variable    "MDF_BIZ_CODE":"${修改状态}"    "CUST_CODE":"${客户代码}"    "CUACCT_CODE":"${资产账户}"    "INT_ORG":"${内部机构}"    "STKEX":"${交易市场}"    "STKBD":"${交易板块}"    "TRDACCT":"${交易账户}"    "TRDACCT_NAME":"${交易账户名称}"    "TRDACCT_TYPE":"${交易账户类型}"    "TRDACCT_EXCLS":"${交易账户类别}"    "TRDACCT_EXID":"${报盘交易账户}"    "TRDACCT_STATUS":"${交易账户状态}"    "TREG_STATUS":"${交易指定状态}"    "BREG_STATUS":"${回购指定状态}"    "STKPBU":"${交易单元}"
    ...    "TRDACCT_MAIN_FLAG":"${主股东账户标志}"    "OPEN_DATE":"${开户日期}"
    log    ${fixpram_全局变量}${unfixpram}
    ${resp}    POST接口下单请求_UTP数据银行    10301486    ${fixpram_全局变量}${unfixpram}
    ${MSG}    set variable    ${resp[0]["data"][0][0]}
    ${MSG_LEVEL}    set variable    ${resp[0]["data"][0][1][0]}
    ${MSG_TEXT}    set variable    ${resp[0]["data"][0][2][0]}
    ${当前资金}    set variable    ${resp}
    #Set Global Variable    ${当前资金}
    [Return]    ${MSG}    ${MSG_LEVEL}    ${MSG_TEXT}
