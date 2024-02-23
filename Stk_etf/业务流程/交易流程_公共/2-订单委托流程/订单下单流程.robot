*** Settings ***
Resource          ../../交易流程_金证/2-订单委托流程/订单下单流程.robot

*** Keywords ***
普通买卖下单流程
    [Arguments]    ${接口类型}=${接口类型_全局变量}
    Run Keyword If    '${接口类型}'=='Stk'    金证_普通买卖下单流程

买蓝下单流程
    [Arguments]    ${接口类型}=${接口类型_全局变量}
    ${交易类型_全局}    Run Keyword If    '${交易类型_全局变量}'=='篮子卖出'    Set Variable    S
    ...    ELSE    Set Variable    B
    Set Global Variable    ${交易类型_全局}
    Run Keyword If    '${接口类型}'=='Stk'    金证_买蓝下单流程
