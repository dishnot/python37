*** Settings ***
Resource          ../../../接口定义/金证/2.实时交易.robot
Resource          ../../../公共目录/通用操作/常用关键字.robot
Resource          ../../../接口定义/金证/4.辅助功能.robot

*** Keywords ***
金证_普通买卖下单流程
    [Arguments]    ${委托数量}=${委托数量_全局变量}    ${订单状态}=${订单状态_全局变量}
    [Documentation]    1.20211123 chm 新增
    ${返回码}    ${返回信息}    Run Keyword    买卖委托_10302001    ${委托数量}
    Run Keyword If    '${订单状态}' in ('已报','全撤','部成','部撤','全成','废单')    SLEEP    1
    ${合同序号_全局变量}    Convert To String    ${返回信息[0]['ORDER_ID']}
    Set Global Variable    ${合同序号_全局变量}
    ${订单状态_临时修改}    Run Keyword If    '${订单状态}'=='全撤'    Set Variable    已报
    ...    ELSE IF    '${订单状态}'=='部撤'    Set Variable    部成
    ...    ELSE    Set Variable    ${订单状态}
    查询模拟撮合是否成功    ${订单状态}
    查询模拟成交数据    ${委托数量}    ${订单状态_临时修改}
    #修改订单状态
    ${返回码_撤单}    ${返回信息_撤单}    Run Keyword if    '${订单状态}' in ('部撤','全撤')    委托撤单_10302004
    Run Keyword If    '${订单状态}' in ('已报','全撤','部成','部撤','全成','废单')    SLEEP    2
    ${合同序号_撤单}    Run Keyword if    '${订单状态}' in ('部撤','全撤')    Convert To String    ${返回信息_撤单[0]['WT_ORDER_ID']}
    ...    ELSE    Set Variable    ${EMPTY}
    ${委托_撤单合同序号_全局变量}    Create Dictionary    委托=${合同序号_全局变量}    撤单=${合同序号_撤单}
    Set Global Variable    ${委托_撤单合同序号_全局变量}
    查询模拟撮合撤单是否成功    ${订单状态}
    查询模拟成交数据    ${委托数量}    ${订单状态}

新股申购交易下单流程
    [Arguments]    ${委托数量}    ${订单状态}=${订单状态_全局变量}
    [Documentation]    1.20211123 chm 新增
    ${返回码}    ${返回信息}    新股申购__10302001    ${委托数量}
    ${合同序号_全局变量}    Convert To String    ${返回信息[0]['ORDER_ID']}
    Set Global Variable    ${合同序号_全局变量}
    ${订单状态_临时修改}    Run Keyword If    '${订单状态}'=='全撤'    Set Variable    已报
    ...    ELSE IF    '${订单状态}'=='部撤'    Set Variable    部成
    ...    ELSE    Set Variable    ${订单状态}
    ${返回码_撤单}    ${返回信息_撤单}    Run Keyword if    '${订单状态}' in ('部撤','全撤')    委托撤单_10302004
    ${合同序号_撤单}    Run Keyword if    '${订单状态}' in ('部撤','全撤')    Convert To String    ${返回信息_撤单[0]['WT_ORDER_ID']}
    ...    ELSE    Set Variable    ${EMPTY}
    ${委托_撤单合同序号_全局变量}    Create Dictionary    委托=${合同序号_全局变量}    撤单=${合同序号_撤单}
    Set Global Variable    ${委托_撤单合同序号_全局变量}

sqltest普通买卖下单流程
    [Arguments]    ${委托数量}=${委托数量_全局变量}
    ${返回码}    ${返回信息}    Run Keyword    买卖委托_10302001    ${委托数量}
    Run Keyword And Continue On Failure    Should Contain    ${返回码}[0][msg]    ${result}
    SLEEP    1
    ${合同序号_全局变量}    Convert To String    ${返回信息[0]['ORDER_ID']}
    Set Global Variable    ${合同序号_全局变量}
    ${合同序号_撤单}    Set Variable    ${EMPTY}
    ${委托_撤单合同序号_全局变量}    Create Dictionary    委托=${合同序号_全局变量}    撤单=${合同序号_撤单}
    Set Global Variable    ${委托_撤单合同序号_全局变量}

sqltest异常买卖下单流程
    [Arguments]    ${委托数量}=${委托数量_全局变量}
    ${返回码}    ${返回信息}    Run Keyword    买卖委托_10302001    ${委托数量}
    #Run Keyword And Continue On Failure    Should Contain    ${返回码}[0][msg]    ${result}
    SLEEP    1
    ${返回信息_数据}    Evaluate    len($返回信息)
    #${返回信息_数据类型判断}    Evaluate    isinstance($返回信息_数据,dict)
    ${合同序号_全局变量}    Run Keyword If    ${返回信息_数据} !=0    Convert To String    ${返回信息[0]['ORDER_ID']}
    ...    ELSE    Set Variable    0
    Set Global Variable    ${合同序号_全局变量}
    ${合同序号_撤单}    Set Variable    ${EMPTY}
    ${委托_撤单合同序号_全局变量}    Create Dictionary    委托=${合同序号_全局变量}    撤单=${合同序号_撤单}
    Set Global Variable    ${委托_撤单合同序号_全局变量}
