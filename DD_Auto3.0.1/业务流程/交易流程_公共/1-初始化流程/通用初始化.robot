*** Settings ***
Resource          ../../交易流程_金证/1-初始化流程/通用初始化.robot
Resource          ../../../公共目录/通用操作/业务数据库查询操作.robot

*** Keywords ***
客户与证券信息查询
    [Arguments]    ${交易信息}    ${委托数量_全局变量}    ${接口类型}=${接口类型_全局变量}
    ${证券代码_全局变量}    Set Variable    ${交易信息["证券代码"]}
    Set Global Variable    ${证券代码_全局变量}
    Set Global Variable    ${委托数量_全局变量}
    委托价格
    log    ${委托当前价格}[0]
    ${委托当前价格}    Get From LIST    ${委托当前价格[0]}    0
    ${委托当前价格}    Convert To Integer    ${委托当前价格}
    ${委托涨停价格}    Get From LIST    ${委托涨停价格[0]}    0
    ${委托涨停价格}    Convert To Integer    ${委托涨停价格}
    log    ${委托涨停价格}
    ${委托价格整数}    Run Keyword If    ${交易信息["委托价格"]}!=0    Set Variable    ${交易信息["委托价格"]}
    ...    ELSE IF    ${交易信息["委托价格"]}==0 and ${委托涨停价格}!=0 and ${委托涨停价格}!=[] and ${委托涨停价格}<100000    Set Variable    ${委托涨停价格}
    ...    ELSE    Set Variable    ${委托当前价格}
    log    ${委托价格整数}
    Run Keyword If    '${接口类型}'=='Stk'    金证_客户与证券信息查询
    委托价格_设置全局变量    ${委托价格整数}
    ${委托价格_全局变量}    Run Keyword If    '${接口类型}'=='Stk'    Set Variable    ${委托价格_全局变量}
    ${委托数量_全局变量}    Run Keyword If    '${接口类型}'=='Stk'    Set Variable    ${委托数量_全局变量}
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
