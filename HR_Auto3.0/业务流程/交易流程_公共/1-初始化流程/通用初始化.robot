*** Settings ***
Resource          ../../交易流程_华锐/1-初始化流程/通用初始化.robot

*** Keywords ***
客户与证券信息查询_备份
    [Arguments]    ${交易信息}    ${委托数量_全局变量}    ${接口类型}=${接口类型_全局变量}
    ${证券代码_全局变量}    Set Variable    ${交易信息["证券代码"]}
    ${委托价格整数}    Set Variable    ${交易信息["委托价格"]}
    Set Global Variable    ${证券代码_全局变量}
    Set Global Variable    ${委托数量_全局变量}
    Run Keyword If    '${接口类型}'=='Cash'    华锐_客户与证券信息查询
    委托价格_设置全局变量    ${委托价格整数}
    ${委托价格_全局变量}    Run Keyword If    '${接口类型}'=='Cash'    Evaluate    str(int(${委托价格_全局变量}*10000))
    ${委托数量_全局变量}    Run Keyword If    '${接口类型}'=='Cash'    Evaluate    str(${委托数量_全局变量}*100)
    Set Global Variable    ${委托价格_全局变量}
    Set Global Variable    ${委托数量_全局变量}
    #委托价格*10000
    #委托数量*100

客户与证券信息查询
    [Arguments]    ${交易信息}    ${委托数量_全局变量}    ${接口类型}=${接口类型_全局变量}
    ${证券代码_全局变量}    Set Variable    ${交易信息["证券代码"]}
    ${委托价格整数}    Set Variable    ${交易信息["委托价格"]}
    Set Global Variable    ${证券代码_全局变量}
    Set Global Variable    ${委托数量_全局变量}
    ${委托价格}    按业务取对应的证券价格    ${交易信息}
    Run Keyword If    '${接口类型}'=='Cash'    华锐_客户与证券信息查询
    #委托价格_设置全局变量    ${委托价格整数}
    ${委托价格_全局变量}    Set Variable    ${委托价格}
    LOG    ${委托价格_全局变量}
    Set Global Variable    ${委托价格_全局变量}
    ${委托价格_全局变量a}    Run Keyword If    '${接口类型}'=='Cash'    Evaluate    math.ceil(${委托价格_全局变量}*10000)    math
    ${委托价格_全局变量}    Evaluate    str(${委托价格_全局变量a})
    ${委托数量_全局变量}    Run Keyword If    '${接口类型}'=='Cash'    Evaluate    str(${委托数量_全局变量}*100)
    Set Global Variable    ${委托价格_全局变量}
    Set Global Variable    ${委托数量_全局变量}
    #委托价格*10000
    #委托数量*100

委托价格_设置全局变量
    [Arguments]    ${委托价格}=${委托价格整数}    ${订单状态}=${订单状态_全局变量}    ${价位价差}=${价位价差_全局变量}
    [Documentation]    1.20211123 chm 新增
    ${撮合规则_两位小数}    Run Keyword If    '${订单状态}' in('全撤','已报')    Set Variable    16
    ...    ELSE IF    '${订单状态}'=='全成'    Set Variable    12
    ...    ELSE IF    '${订单状态}'in('部成','部撤')    Set Variable    11
    ...    ELSE IF    '${订单状态}' in('废单')    Set Variable    14
    ${证券代码位数}    Run Keyword If    '${价位价差}'=='0.01'    Set Variable    ${撮合规则_两位小数}
    ...    ELSE IF    '${价位价差}'=='0.001'    Set Variable    ${撮合规则_两位小数}5
    ${委托价格_全局变量}    Run Keyword If    '${订单状态}' in('确认')    Set Variable    ${委托价格}
    ...    ELSE    Convert To String    ${委托价格}.${撮合规则_两位小数}
    Set Global Variable    ${委托价格_全局变量}

按业务取对应的证券价格
    [Arguments]    ${交易信息}    ${证券代码}=${证券代码_全局变量}    ${证券业务}=${业务_全局变量}
    数据库链接
    ${竞价价格}    Run KeyWord If    '${证券业务}'in('100','101')    QUERY    select prev_close_price from basedb.t_securities where security_id=${证券代码}
    ${新股价格}    Run KeyWord If    '${证券业务}'=='113'    QUERY    select price_upper_limit from tradingconfigdb.t_security_issue_biz_rule where security_id=${证券代码}
    ${交易价格}    Run KeyWord If    '${证券业务}'not in('100','101','113')    Set Variable    ${交易信息["委托价格"]}
    log    ${证券业务}
    ${证券价格}    Run KeyWord If    '${证券业务}'in('100','101')    Set Variable    ${竞价价格}[0][0]
    ...    ELSE IF    '${证券业务}'=='113'    Set Variable    ${新股价格}[0][0]
    ...    ELSE    Set Variable    ${交易价格}
    log    ${证券价格}
    ${证券价格}    EVALUATE    round(${证券价格},2)    #价格取两位小数
    [Return]    ${证券价格}
