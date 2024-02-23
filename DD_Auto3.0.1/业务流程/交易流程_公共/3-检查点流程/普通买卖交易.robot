*** Settings ***
Resource          ../../交易流程_金证/3-检查点流程/普通买卖交易.robot

*** Keywords ***
普通买卖交易检查流程
    [Arguments]    ${接口类型}=${接口类型_全局变量}
    [Documentation]    1.20211123 chm 新增
    Run Keyword If    '${接口类型}'=='Stk'    金证_普通买卖检查流程

新股申购交易检查流程
    [Arguments]    ${接口类型}=${接口类型_全局变量}
    [Documentation]    1.20211123 chm 新增
    Run Keyword If    '${接口类型}'=='Stk'    金证_新股申购检查流程
