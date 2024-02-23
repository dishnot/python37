*** Keywords ***
委托价格_设置全局变量
    [Arguments]    ${委托价格}=${委托价格_全局变量}    ${订单状态}=${订单状态_全局变量}    ${价位价差}=${价位价差_全局变量}
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
