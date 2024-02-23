*** Settings ***
Library           String
Library           Collections
Library           DatabaseLibrary

*** Keywords ***
用例名称转换为字典
    [Arguments]    ${接口类型}=${接口类型_全局变量}
    log    ${TEST_NAME}
    ${用例名称转换成List}    Split String    ${TEST_NAME}    _
    ${用例名称转换成字典}    Create Dictionary    交易板块=${用例名称转换成List[0]}    证券类别=${用例名称转换成List[1]}    业务行为=${用例名称转换成List[2]}    证券业务=${用例名称转换成List[3]}    用例编号=${用例名称转换成List[4]}    用例名称=${用例名称转换成List[5]}    用例状态=${用例名称转换成List[-1]}
    log    ${用例名称转换成字典}
    Set Global Variable    ${用例名称转换成字典}
    ${交易板块_全局变量}    Set Variable    ${用例名称转换成字典['交易板块']}
    ${证券类别_全局变量}    Set Variable    ${用例名称转换成字典['证券类别']}
    ${行为_全局变量}    Set Variable    ${用例名称转换成字典['业务行为']}
    ${业务行为_全局变量}    Run Keyword If    '${接口类型}'=='Cash' and '${用例名称转换成字典['业务行为']}'=='100'    Set Variable    a    #金证：100-限价委托 华锐：限价委托、增强限价
    ${证券业务_全局变量}    Run Keyword If    '${接口类型}'=='Cash' and '${用例名称转换成字典['证券业务']}' in ('100','106')    Set Variable    1
    ...    ELSE IF    '${接口类型}'=='Cash' and '${用例名称转换成字典['证券业务']}' in ('101','153')    Set Variable    2
    ...    ELSE IF    '${接口类型}'=='Cash' and '${用例名称转换成字典['证券业务']}'=='165'    Set Variable    4
    ...    ELSE IF    '${接口类型}'=='Cash' and '${用例名称转换成字典['证券业务']}'=='160'    Set Variable    5
    ...    ELSE IF    '${接口类型}'=='Cash' and '${用例名称转换成字典['证券业务']}'=='161'    Set Variable    6
    ...    ELSE IF    '${接口类型}'=='Cash' and '${用例名称转换成字典['证券业务']}'=='113'    Set Variable    7
    ...    ELSE IF    '${接口类型}'=='Cash' and '${用例名称转换成字典['证券业务']}' in ('181','187','827')    Set Variable    D
    ...    ELSE IF    '${接口类型}'=='Cash' and '${用例名称转换成字典['证券业务']}' in ('182','188','828')    Set Variable    E    #金证：100-买入，101-卖出 华锐：1-买，2-卖,配售：1-深圳，2-上海 D申购，E赎回    #金证：165-逆回购 华锐：4-逆回购    #金证：160-转股 华锐：5-转股    #金证：161-回售 华锐：6-回售
    ${订单状态_全局变量}    Set Variable    ${用例名称转换成字典['用例状态']}
    ${业务_全局变量}    Set Variable    ${用例名称转换成字典['证券业务']}
    Set Global Variable    ${行为_全局变量}
    Set Global Variable    ${证券类别_全局变量}
    Set Global Variable    ${业务行为_全局变量}
    Set Global Variable    ${证券业务_全局变量}
    Set Global Variable    ${订单状态_全局变量}
    Set Global Variable    ${交易板块_全局变量}
    Set Global Variable    ${业务_全局变量}

字典重新提取成新字典
    [Arguments]    ${原本dict}    ${提取dict}
    [Documentation]    1.20211123 chm 新增
    ${字段名称key}    ${字段名称values}    字典拆分为key和Values    ${提取dict}
    log    ${原本dict}
    log    ${提取dict}
    log    ${字段名称values}
    log    ${字段名称key}
    ${new_dict}    Create Dictionary
    FOR    ${j}    IN    @{字段名称key}
        log    ${j}
        comment    把查询的字段和值建立成字典
        ${value}    Set Variable    ${原本dict["${j}"]}
        Set To Dictionary    ${new_dict}    ${j}=${value}
    END
    log    ${new_dict}
    [Return]    ${new_dict}

字典拆分为key和Values
    [Arguments]    ${dict}
    ${字段名称key}    Get Dictionary Keys    ${dict}    sort_keys=False
    ${字段名称values}    Get Dictionary Values    ${dict}    sort_keys=False
    [Return]    ${字段名称key}    ${字段名称values}

追加list转换为字符串
    [Arguments]    ${list_1}    ${list_2}
    Append To List    ${list_1}
    ${list_2}    Catenate    SEPARATOR=|    ${list_2}    ${list_1}
    log    ${list_2}
    [Return]    ${list_2}

字符串转换成list
    [Arguments]    ${字段}
    [Documentation]    1.20211123 chm 新增
    ${string}    Get Substring    ${字段}    1
    ${list}    Split String    ${string}    |
    log    ${list}
    [Return]    ${list}

字符串处理
    [Arguments]    ${替换数据}    ${替换类型}
    [Documentation]    1.20211123 chm 新增
    ${替换数据}    Convert To String    ${替换数据}
    FOR    ${i}    IN    @{替换类型}
        log    ${i}
        log    ${替换类型["${i}"]}
        ${替换数据}    Replace String    ${替换数据}    ${i}    ${替换类型["${i}"]}
        log    ${替换数据}
    END
    ${替换数据}    Replace String    ${替换数据}    {    ${EMPTY}
    ${替换数据}    Replace String    ${替换数据}    }    ${EMPTY}
    log    ${替换数据}
    [Return]    ${替换数据}

查询模拟成交数据
    [Arguments]    ${委托数量}    ${订单状态}=${订单状态_临时修改}    ${资金账户}=${资金账户_全局变量}    ${合同序号}=${合同序号_全局变量}    ${证券代码}=${证券代码_全局变量}    ${交易板块}=${交易板块_全局变量}
    [Documentation]    1.20211123 chm 新增
    log    ${订单状态}
    FOR    ${i}    IN RANGE    20
        ${数据是否落表}    Run Keyword And Return Status    Run Keyword If    '${交易板块}' not in('03','13')    Check If Exists In Database    SELECT \ MATCHED_QTY,WITHDRAWN_QTY,OFFER_RET_MSG FROM STK_ORDER WHERE CUACCT_CODE='${资金账户}'AND ORDER_ID='${合同序号}' ORDER BY ORDER_DATE
        Run Keyword If    '${数据是否落表}'=='False'    sleep    0.5
        Run Keyword If    '${数据是否落表}'=='False'    Continue For Loop
        @{查询委托表中成交数量_撤单数量_合法信息}    Run Keyword If    '${交易板块}' not in('03','13')    Query    SELECT \ MATCHED_QTY,WITHDRAWN_QTY,OFFER_RET_MSG FROM STK_ORDER WHERE CUACCT_CODE='${资金账户}'AND ORDER_ID='${合同序号}' ORDER BY ORDER_DATE \
        ${len}    Get Length    ${查询委托表中成交数量_撤单数量_合法信息}
        ${成交数量}    Set Variable    ${查询委托表中成交数量_撤单数量_合法信息[0][0]}
        ${撤单数量}    Set Variable    ${查询委托表中成交数量_撤单数量_合法信息[0][1]}
        ${合法信息}    Set Variable    ${查询委托表中成交数量_撤单数量_合法信息[0][2]}
        ${是否存在交易冻结}    Run Keyword And Return Status    Check If Exists In Database    select STK_TRD_FRZ from STK_ASSET where CUACCT_CODE=${资金账户} and STK_CODE =${证券代码}and STKBD=${交易板块}
        @{交易股份冻结数量}    Query    select STK_TRD_FRZ from STK_ASSET where CUACCT_CODE=${资金账户} and STK_CODE =${证券代码}and STKBD=${交易板块}
        ${交易股份冻结数量}    Run Keyword If    '${是否存在交易冻结}'=='True'    Set Variable    ${交易股份冻结数量[0][0]}
        ...    ELSE    Set Variable    NULL
        Run Keyword If    '${订单状态}'in ('全成','部成') and '${成交数量}'=='0' or '${订单状态}'in ('废单','全撤') and '${撤单数量}'=='0' or '${订单状态}'=='部撤' and '${成交数量}'=='0' and '${撤单数量}'=='0' or '${订单状态}'=='已报' and '${成交数量}'=='0' and '${撤单数量}'!='0'    sleep    1
        ${是否终止循环}    Run Keyword If    '${订单状态}'in ('全成','部成') and '${成交数量}'>'0' or '${订单状态}'=='废单' and '${成交数量}'=='0' and '${撤单数量}'>'0' or '${订单状态}'=='部撤' and '${成交数量}'>'0' and '${撤单数量}'>'0' or '${订单状态}'=='全撤' and '${成交数量}'=='0' and '${撤单数量}'>'0' or '${订单状态}'=='已报' and '${成交数量}'=='0' and '${撤单数量}'=='0'    Set Variable    Status
        Exit For Loop If    '${是否终止循环}'=='Status'
    END
    ${成交数量_预期}    Run Keyword If    '${订单状态}'=='全成'    evaluate    ${委托数量}
    ...    ELSE IF    '${订单状态}'in ('部成','部撤')    Evaluate    ${委托数量}/2
    ...    ELSE IF    '${订单状态}' in ('已报','全撤','废单')    Evaluate    0
    ${成交数量_预期}    Evaluate    int(${成交数量_预期})
    ${撤单数量_预期}    Run Keyword If    '${订单状态}'in ('部成','全成','已报')    evaluate    0
    ...    ELSE IF    '${订单状态}'in ('部撤')    Evaluate    ${委托数量}/2
    ...    ELSE    Evaluate    ${委托数量}
    ${撤单数量_预期}    Evaluate    int(${撤单数量_预期})
    log    '${订单状态}'in('全成','部成','部撤','全撤','废单','已报')and'${成交数量}'=='${成交数量_预期}'and '${撤单数量}'=='${撤单数量_预期}'
    ${模拟成交校验}    Run Keyword If    '${订单状态}'in('全成','部成','部撤','全撤','废单','已报')and'${成交数量}'=='${成交数量_预期}'and '${撤单数量}'=='${撤单数量_预期}'    Set Variable    正确
    ...    ELSE    Set Variable    错误
    Run Keyword And Continue On Failure    Run Keyword If    '${订单状态}'in('全成','部成','部撤','全撤','废单','已报')    Should Be Equal As Strings    ${模拟成交校验}    正确    撮合规则不一致

类似字典类的字符串转换为字典
    [Arguments]    ${转换字符串}
    [Documentation]    1.20211123 chm 新增
    log    ${转换字符串}
    ${转换字符串}    Replace String    ${转换字符串}    None    0.00
    ${去掉最后一位}    Get Substring    ${转换字符串}    \    -1
    ${去掉第一位}    Get Substring    ${去掉最后一位}    1
    log    ${转换字符串}
    ${转换单引号为双引号}    Replace String    ${去掉第一位}    '    "
    log    ${转换单引号为双引号}
    &{字典}=    Evaluate    eval('{${转换单引号为双引号}}')
    log    ${字典}
    ${keys}    Get Dictionary Keys    ${字典}    sort_keys=False
    ${values}    Get Dictionary Values    ${字典}    sort_keys=False
    [Return]    ${keys}    ${values}    ${字典}

类似字典类的字符串转换为字典00
    [Arguments]    ${转换字符串}
    [Documentation]    1.20211123 chm 新增
    log    ${转换字符串}
    ${转换字符串}    Replace String    ${转换字符串}    None    0.00
    ${去掉最后一位}    Get Substring    ${转换字符串}    \    -1
    ${去掉第一位}    Get Substring    ${去掉最后一位}    1
    log    ${转换字符串}
    ${转换单引号为双引号}    Replace String    ${去掉第一位}    '    "
    ${转换单引号为双引号}    Replace String    ${转换单引号为双引号}    }    ]
    ${转换单引号为双引号}    Replace String    ${转换单引号为双引号}    {    [
    log    ${转换单引号为双引号}
    &{字典}=    Evaluate    eval('{${转换单引号为双引号}}')
    log    ${字典}
    ${keys}    Get Dictionary Keys    ${字典}    sort_keys=False
    ${values}    Get Dictionary Values    ${字典}    sort_keys=False
    [Return]    ${keys}    ${values}    ${字典}

删除字典部分字段
    [Arguments]    ${字典}    ${删除的keys}
    [Documentation]    1.20211123 chm 新增
    FOR    ${i}    IN    @{删除的keys}
        log    ${i}
        Pop From Dictionary    ${字典}    ${i}    #也可以用关键字Remove From Dictionary
    END
    LOG    ${字典}
    [Return]    ${字典}

接口数据排序
    [Arguments]    ${msgbody}    ${sortkeys}
    # 使用split对字符串进行解析, 将key形成list
    log    ${sortkeys}
    ${list}    Split String    ${sortkeys}    |
    log    ${list}
    ${个数}    Evaluate    len(${list})
    # 使用itemgetter, 进行排序
    ${msgbody}    Run KeyWord If    '${个数}'=='1'    Evaluate    sorted(${msgbody},key=operator.itemgetter(*${list}))    operator
    ...    ELSE    Evaluate    [dict(d, order_array=[{k: v for k, v in item.items() if k != 'exec_id'} for item in d.get('order_array', [])]) for d in ${msgbody}]
    ${msgbody}    Run KeyWord If    '${个数}'=='1'    Set Variable    ${msgbody}
    ...    ELSE    Evaluate    sorted(${msgbody}, key=lambda x: [d.get('security_id') for d in x.get('order_array', [])])
    log    ${msgbody}
    [Return]    ${msgbody}

列表转换为字典
    [Arguments]    ${列表key}    ${列表value}
    ${new_dict}    Create Dictionary
    ${len}    Get Length    ${列表key}
    FOR    ${j}    IN RANGE    ${len}
        comment    把查询的字段和值建立成字典
        Set To Dictionary    ${new_dict}    ${列表key[${j}]}=${列表value[${j}]}
    END
    log    ${new_dict}
    [Return]    ${new_dict}

列表相减
    [Arguments]    ${列表1}    ${列表2}
    ${new_list}    Create List
    ${len}    Get Length    ${列表1}
    FOR    ${j}    IN RANGE    ${len}
        comment    把查询的字段和值建立成字典
        ${result}    Evaluate    round(${列表1[${j}]}-${列表2[${j}]},2)
        Append To List    ${new_list}    ${result}
    END
    log    ${new_list}
    [Return]    ${new_list}

sqltest用例名称转换为字典
    [Arguments]    ${接口类型}=${接口类型_全局变量}
    log    ${TEST_NAME}
    ${用例名称转换成List}    Split String    ${TEST_NAME}    _
    ${用例名称转换成字典}    Create Dictionary    交易板块=${用例名称转换成List[0]}    证券类别=${用例名称转换成List[1]}    业务行为=${用例名称转换成List[2]}    证券业务=${用例名称转换成List[3]}    用例编号=${用例名称转换成List[4]}    用例名称=${用例名称转换成List[5]}    用例状态=${用例名称转换成List[-1]}
    log    ${用例名称转换成字典}
    Set Global Variable    ${用例名称转换成字典}
    ${交易板块_全局变量}    Set Variable    ${用例名称转换成字典['交易板块']}
    ${证券类别_全局变量}    Set Variable    ${用例名称转换成字典['证券类别']}
    ${行为_全局变量}    Set Variable    ${用例名称转换成字典['业务行为']}
    ${业务行为_全局变量}    Set Variable    ${用例名称转换成字典['业务行为']}
    ${证券业务_全局变量}    Set Variable    ${用例名称转换成字典['证券业务']}
    ${订单状态_全局变量}    Set Variable    ${用例名称转换成字典['用例状态']}
    ${业务_全局变量}    Set Variable    ${用例名称转换成字典['证券业务']}
    Set Global Variable    ${证券类别_全局变量}
    Set Global Variable    ${行为_全局变量}
    Set Global Variable    ${证券业务_全局变量}
    Set Global Variable    ${订单状态_全局变量}
    Set Global Variable    ${交易板块_全局变量}
    Set Global Variable    ${业务_全局变量}
    Set Global Variable    ${业务行为_全局变量}

深市ETF申赎成分股回报数据处理11
    [Arguments]    ${result}
    ${result}    Evaluate    list(${result})
    ${new_list}    Evaluate    [dict({k: v for k, v in item.items() if k != 'order_array'}) for item in ${result}]
    Log    ${new_list}
    ${数据}    Set Variable
    ${order_array}    Evaluate    list(${result}[0][order_array])
    log    ${order_array}
    FOR    ${i}    IN    @{order_array}
        LOG    ${i}
        ${i}    evaluate    dict(${i})
        ${i}    Set Variable    [${i}]
        Set To Dictionary    ${new_list}[0]    order_array=${i}
        ${数据}    Catenate    SEPARATOR=,    ${new_list}    ${数据}
    END
    Log    ${数据}
    [Return]    ${数据}

深市ETF申赎成分股回报数据处理
    [Arguments]    ${result}
    ${result}    Evaluate    list(${result})
    ${new_list}    Evaluate    [dict({k: v for k, v in item.items() if k != 'order_array'}) for item in ${result}]
    ${new_list}    Set Variable    ${new_list}[0]
    Log    ${new_list}
    ${数据}    Set Variable
    ${order_array}    Evaluate    list(${result}[0][order_array])
    ${a}    Set Variable    0
    FOR    ${i}    IN    @{order_array}
        LOG    ${i}
        ${长度}    evaluate    len(${order_array})
        ${a}    evaluate    ${a}+1
        ${i}    evaluate    dict(${i})
        ${i}    Set Variable    [${i}]
        Set To Dictionary    ${new_list}    order_array=${i}
        ${new_list}    evaluate    str(${new_list})
        ${new_list}    Replace String    ${new_list}    "    ${EMPTY}
        log    ${new_list}
        ${new_list}    evaluate    dict(${new_list})
        ${数据}    Run KeyWord If    ${a}!=1    Catenate    SEPARATOR=,    ${new_list}    ${数据}
        ...    ELSE    Catenate    SEPARATOR=    ${new_list}    ${数据}
        log    ${数据}
    END
    ${数据}    evaluate    [${数据}]
    LOG    ${数据}
    [Return]    ${数据}
