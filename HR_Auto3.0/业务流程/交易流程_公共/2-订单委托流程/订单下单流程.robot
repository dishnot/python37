*** Settings ***
Resource          ../../交易流程_华锐/2-订单委托流程/订单下单流程.robot

*** Keywords ***
普通买卖下单流程
    [Arguments]    ${接口类型}=${接口类型_全局变量}
    Run Keyword If    '${接口类型}'=='Cash'    华锐_普通买卖下单流程
