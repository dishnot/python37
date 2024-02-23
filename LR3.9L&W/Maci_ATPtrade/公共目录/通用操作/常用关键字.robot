*** Settings ***
Library           String
Library           Collections
Library           DatabaseLibrary
Library           DateTime
Resource          ../../公共目录/通用操作/数据库操作.robot

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
    ${业务行为_全局变量}    Run Keyword If    '${接口类型}'=='Fis'    Set Variable    ${用例名称转换成字典['业务行为']}
    ${证券业务_全局变量}    Run Keyword If    '${接口类型}'=='Fis'    Set Variable    ${用例名称转换成字典['证券业务']}
    ${订单状态_全局变量}    Set Variable    ${用例名称转换成字典['用例状态']}
    Set Global Variable    ${证券类别_全局变量}
    Set Global Variable    ${业务行为_全局变量}
    Set Global Variable    ${证券业务_全局变量}
    Set Global Variable    ${订单状态_全局变量}
    Set Global Variable    ${交易板块_全局变量}

直接还款用例名称转换为字典
    [Arguments]    ${接口类型}=${接口类型_全局变量}
    log    ${TEST_NAME}
    ${用例名称转换成List}    Split String    ${TEST_NAME}    _
    ${用例名称转换成字典}    Create Dictionary    货币代码=${用例名称转换成List[0]}    头寸类型=${用例名称转换成List[1]}    证券业务=${用例名称转换成List[2]}    偿还类型=${用例名称转换成List[3]}    偿还金额类别=${用例名称转换成List[4]}    交易板块=${用例名称转换成List[5]}
    log    ${用例名称转换成字典}
    Set Global Variable    ${用例名称转换成字典}
    ${货币代码_全局变量}    Set Variable    ${用例名称转换成字典['货币代码']}
    ${头寸类型_全局变量}    Set Variable    ${用例名称转换成字典['头寸类型']}
    ${证券业务_全局变量}    Set Variable    ${用例名称转换成字典['证券业务']}
    ${偿还类型_全局变量}    Set Variable    ${用例名称转换成字典['偿还类型']}
    ${偿还金额类别_全局变量}    Set Variable    ${用例名称转换成字典['偿还金额类别']}
    ${交易板块_全局变量}    Set Variable    ${用例名称转换成字典['交易板块']}
    Set Global Variable    ${货币代码_全局变量}
    Set Global Variable    ${头寸类型_全局变量}
    Set Global Variable    ${证券业务_全局变量}
    Set Global Variable    ${偿还类型_全局变量}
    Set Global Variable    ${偿还金额类别_全局变量}
    Set Global Variable    ${交易板块_全局变量}

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

查询模拟撮合是否成功
    [Arguments]    ${订单状态}=${订单状态_临时修改}    ${资金账户}=${资金账户_全局变量}    ${合同序号}=${合同序号_全局变量}    ${证券代码}=${证券代码_全局变量}    ${交易板块}=${交易板块_全局变量}
    [Documentation]    1.20211123 chm 新增
    log    ${订单状态}
    FOR    ${i}    IN RANGE    40
        ${委托预期}    Run Keyword If    '${订单状态}'=='全成'    Set Variable    8
        ...    ELSE IF    '${订单状态}'in('部成','部撤')    Set Variable    7
        ...    ELSE IF    '${订单状态}'in('已报','全撤')    Set Variable    2
        ...    ELSE IF    '${订单状态}'=='废单'    Set Variable    9
        ${撮合是否正常}    Run Keyword And Return Status    Run Keyword If    '${交易板块}' not in('03','13')    Check If Exists In Database    SELECT \ ORDER_STATUS,MATCHED_QTY,WITHDRAWN_QTY,OFFER_RET_MSG FROM STK_ORDER WHERE CUACCT_CODE='${资金账户}'AND ORDER_ID='${合同序号}' and ORDER_STATUS='${委托预期}'
        Run Keyword If    '${撮合是否正常}'=='False'    sleep    0.5
        Run Keyword If    '${撮合是否正常}'=='False'    Continue For Loop
        Exit For Loop If    '${撮合是否正常}'=='True'
    END
    ${委托预期}    Run Keyword If    '${订单状态}'=='全成'    Set Variable    8
    ...    ELSE IF    '${订单状态}'in('部成','部撤')    Set Variable    7
    ...    ELSE IF    '${订单状态}'in('已报','全撤')    Set Variable    2
    ...    ELSE IF    '${订单状态}'=='废单'    Set Variable    9
    ${取委托状态}    Query    SELECT ORDER_STATUS FROM STK_ORDER WHERE CUACCT_CODE='${资金账户}'AND ORDER_ID='${合同序号}' ORDER BY ORDER_DATE
    log    ${取委托状态}[0]
    ${委托状态}    Get From LIST    ${取委托状态[0]}    0
    ${委托状态}    Convert To String    ${委托状态}
    Run Keyword If    '${委托预期}'=='${委托状态}'    LOG    撮合正确
    ...    ELSE    LOG    撮合失败，请检查环境！！！
    Should Be Equal As Strings    ${委托预期}    ${委托状态}

查询模拟撮合撤单是否成功
    [Arguments]    ${订单状态}=${订单状态_临时修改}    ${资金账户}=${资金账户_全局变量}    ${合同序号}=${合同序号_全局变量}    ${证券代码}=${证券代码_全局变量}    ${交易板块}=${交易板块_全局变量}
    [Documentation]    1.20211123 chm 新增
    log    ${订单状态}
    FOR    ${i}    IN RANGE    20
        ${委托预期}    Run Keyword If    '${订单状态}'=='全成'    Set Variable    8
        ...    ELSE IF    '${订单状态}'=='部撤'    Set Variable    5
        ...    ELSE IF    '${订单状态}'=='部成'    Set Variable    7
        ...    ELSE IF    '${订单状态}'=='已报'    Set Variable    2
        ...    ELSE IF    '${订单状态}'=='全撤'    Set Variable    6
        ...    ELSE IF    '${订单状态}'=='废单'    Set Variable    9
        ${撮合是否正常}    Run Keyword And Return Status    Run Keyword If    '${交易板块}' not in('03','13')    Check If Exists In Database    SELECT \ ORDER_STATUS,MATCHED_QTY,WITHDRAWN_QTY,OFFER_RET_MSG FROM STK_ORDER WHERE CUACCT_CODE='${资金账户}'AND ORDER_ID='${合同序号}' and ORDER_STATUS='${委托预期}'
        Run Keyword If    '${撮合是否正常}'=='False'    sleep    0.5
        Run Keyword If    '${撮合是否正常}'=='False'    Continue For Loop
        Exit For Loop If    '${撮合是否正常}'=='True'
    END
    ${委托预期}    Run Keyword If    '${订单状态}'=='全成'    Set Variable    8
    ...    ELSE IF    '${订单状态}'=='部撤'    Set Variable    5
    ...    ELSE IF    '${订单状态}'=='部成'    Set Variable    7
    ...    ELSE IF    '${订单状态}'=='已报'    Set Variable    2
    ...    ELSE IF    '${订单状态}'=='全撤'    Set Variable    6
    ...    ELSE IF    '${订单状态}'=='废单'    Set Variable    9
    ${取委托状态}    Query    SELECT ORDER_STATUS FROM STK_ORDER WHERE CUACCT_CODE='${资金账户}'AND ORDER_ID='${合同序号}' ORDER BY ORDER_DATE
    log    ${取委托状态}[0]
    ${委托状态}    Get From LIST    ${取委托状态[0]}    0
    ${委托状态}    Convert To String    ${委托状态}
    Run Keyword If    '${委托预期}'=='${委托状态}'    LOG    撮合正确
    ...    ELSE    LOG    撮合失败，请检查环境！！！
    Should Be Equal As Strings    ${委托预期}    ${委托状态}

校验模拟撮合
    [Arguments]    ${订单状态}=${订单状态_临时修改}    ${资金账户}=${资金账户_全局变量}    ${合同序号}=${合同序号_全局变量}    ${证券代码}=${证券代码_全局变量}    ${交易板块}=${交易板块_全局变量}
    [Documentation]    1.20211123 chm 新增
    log    ${订单状态}
    ${委托预期}    Run Keyword If    '${订单状态}'=='全成'    Set Variable    8
    ...    ELSE IF    '${订单状态}'in('部成','部撤')    Set Variable    7
    ...    ELSE IF    '${订单状态}'in('已报','全撤')    Set Variable    2
    ...    ELSE IF    '${订单状态}'=='废单'    Set Variable    9
    ${取委托状态}    Query    SELECT ORDER_STATUS FROM STK_ORDER WHERE CUACCT_CODE='${资金账户}'AND ORDER_ID='${合同序号}' ORDER BY ORDER_DATE
    log    ${取委托状态}[0]
    ${委托状态}    Get From LIST    ${取委托状态[0]}    0
    ${委托状态}    Convert To String    ${委托状态}
    Run Keyword If    '${委托预期}'=='${委托状态}'    LOG    撮合正确
    ...    ELSE    LOG    撮合失败，请检查环境！！！
    Should Be Equal As Strings    ${委托预期}    ${委托状态}

校验撤单模拟撮合
    [Arguments]    ${订单状态}=${订单状态_临时修改}    ${资金账户}=${资金账户_全局变量}    ${合同序号}=${合同序号_全局变量}    ${证券代码}=${证券代码_全局变量}    ${交易板块}=${交易板块_全局变量}
    [Documentation]    1.20211123 chm 新增
    log    ${订单状态}
    ${委托预期}    Run Keyword If    '${订单状态}'=='全成'    Set Variable    8
    ...    ELSE IF    '${订单状态}'=='部撤'    Set Variable    5
    ...    ELSE IF    '${订单状态}'=='部成'    Set Variable    7
    ...    ELSE IF    '${订单状态}'=='已报'    Set Variable    2
    ...    ELSE IF    '${订单状态}'=='全撤'    Set Variable    6
    ...    ELSE IF    '${订单状态}'=='废单'    Set Variable    9
    ${取委托状态}    Query    SELECT ORDER_STATUS FROM STK_ORDER WHERE CUACCT_CODE='${资金账户}'AND ORDER_ID='${合同序号}' ORDER BY ORDER_DATE
    log    ${取委托状态}[0]
    ${委托状态}    Get From LIST    ${取委托状态[0]}    0
    ${委托状态}    Convert To String    ${委托状态}
    Run Keyword If    '${委托预期}'=='${委托状态}'    LOG    撮合正确
    ...    ELSE    LOG    撮合失败，请检查环境！！！
    Should Be Equal As Strings    ${委托预期}    ${委托状态}

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
    ${成交数量_预期}    Run Keyword If    '${订单状态}'=='全成'    evaluate    $委托数量
    ...    ELSE IF    '${订单状态}'in ('部成','部撤')    Evaluate    $委托数量/2
    ...    ELSE IF    '${订单状态}' in ('已报','全撤','废单')    Evaluate    0
    ${成交数量_预期}    Evaluate    int(${成交数量_预期})
    ${撤单数量_预期}    Run Keyword If    '${订单状态}'in ('部成','全成','已报')    evaluate    0
    ...    ELSE IF    '${订单状态}'in ('部撤')    Evaluate    $委托数量/2
    ...    ELSE    Evaluate    $委托数量
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
    ${转换单引号为双引号}    Replace String    ${去掉第一位}    '    "
    &{字典}=    Evaluate    eval('{${转换单引号为双引号}}')
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
    # 使用itemgetter, 进行排序
    ${msgbody}    Evaluate    sorted(${msgbody},key=operator.itemgetter(*${list}))    operator
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

账户遍历登入
    ${资金账户}    登录账户获取
    FOR    ${i}    IN    @{资金账户}
        ${处理字符}    Create Dictionary    [=${EMPTY}    ]=${EMPTY}    (=${EMPTY}    ,=${EMPTY}    )=${EMPTY}
        ${数据处理后}    字符串处理    ${i}    ${处理字符}
        ${数据处理前}    EVALUATE    $数据处理后.replace(' ','')
        ${资金账户}    Set Variable    ${数据处理前}
        Run keyword and continue on failure    用户登录_10301105    ${资金账户}
        ${账户匹配session}    Set Variable    ${资金账户_全局变量}    ${session_全局变量}
    END
    LOG    ${账户匹配session}

账户遍历调试
    ${接口类型_全局变量}    Run Keyword If    '${TEST_ENV}'in \ ('69')    Set Variable    Fis
    Set Global Variable    ${接口类型_全局变量}
    ${接口类型}    Set Variable    ${接口类型_全局变量}
    环境信息查询与连接
    @{资金账户}    登录账户获取
    用例名称转换为字典
    FOR    ${i}    IN    @{资金账户}
        ${资金账户}    Set Variable    ${i}
        ${返回码}    ${返回信息}    用户登录_10301105    ${资金账户}
        log    ${返回码}
        log    ${返回信息}
        Should Be Equal As Strings    ${返回码[0]}[code]    ${0}
        ${账户匹配session}    Set Variable    ${资金账户_全局变量}+ ${session_全局变量}    \    #Run Keyword And Ignore
    END
    LOG    ${账户匹配session}

77
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

两融查询模拟成交
    [Arguments]    ${订单状态}=${订单状态_临时修改}    ${资金账户}=${资金账户_全局变量}    ${合同序号}=${合同序号_全局变量}    ${证券代码}=${证券代码_全局变量}    ${交易板块}=${交易板块_全局变量}
    数据库链接
    log    ${订单状态}
    FOR    ${i}    IN RANGE    20
        ${数据是否落表}    Run Keyword And Return Status    Run Keyword If    '${交易板块}' not in('03','13')    Check If Exists In Database    SELECT \ MATCHED_QTY,WITHDRAWN_QTY,OFFER_RET_MSG FROM STK_ORDER WHERE CUACCT_CODE='${资金账户}'AND ORDER_ID='${合同序号}' ORDER BY ORDER_DATE
        Run Keyword If    '${数据是否落表}'=='False'    sleep    0.5
        Run Keyword If    '${数据是否落表}'=='False'    Continue For Loop
        @{查询委托表中成交数量_撤单数量_合法信息}    Run Keyword If    '${交易板块}' not in('03','13')    Query    SELECT \ MATCHED_QTY,WITHDRAWN_QTY,OFFER_RET_MSG,ORDER_STATUS FROM STK_ORDER WHERE CUACCT_CODE='${资金账户}'AND ORDER_ID='${合同序号}' ORDER BY ORDER_DATE \
        ${len}    Get Length    ${查询委托表中成交数量_撤单数量_合法信息}
        ${成交数量}    Set Variable    ${查询委托表中成交数量_撤单数量_合法信息[0][0]}
        ${撤单数量}    Set Variable    ${查询委托表中成交数量_撤单数量_合法信息[0][1]}
        ${合法信息}    Set Variable    ${查询委托表中成交数量_撤单数量_合法信息[0][2]}
        ${委托状态}    Set Variable    ${查询委托表中成交数量_撤单数量_合法信息[0][3]}
        ${是否存在交易冻结}    Run Keyword And Return Status    Check If Exists In Database    select STK_TRD_FRZ from STK_ASSET where CUACCT_CODE=${资金账户} and STK_CODE =${证券代码}and STKBD=${交易板块}
        @{交易股份冻结数量}    Query    select STK_TRD_FRZ from STK_ASSET where CUACCT_CODE=${资金账户} and STK_CODE =${证券代码}and STKBD=${交易板块}
        ${交易股份冻结数量}    Run Keyword If    '${是否存在交易冻结}'=='True'    Set Variable    ${交易股份冻结数量[0][0]}
        ...    ELSE    Set Variable    NULL
        Run Keyword If    '${订单状态}'in ('全成','部成') and '${成交数量}'=='0' or '${订单状态}'in ('废单','全撤') and '${撤单数量}'=='0' or '${订单状态}'=='部撤' and '${成交数量}'=='0' and '${撤单数量}'=='0' or '${订单状态}'=='已报' and '${成交数量}'=='0' and '${撤单数量}'!='0'    sleep    1
        ${是否终止循环}    Run Keyword If    '${订单状态}'in ('全成','部成') and '${成交数量}'>'0' or '${订单状态}'=='废单' and '${成交数量}'=='0' and '${撤单数量}'>'0' or '${订单状态}'=='部撤' and '${成交数量}'>'0' and '${撤单数量}'>'0' or '${订单状态}'=='全撤' and '${成交数量}'=='0' and '${撤单数量}'>'0' or '${订单状态}'=='已报' and '${成交数量}'=='0' and '${撤单数量}'=='0'    Set Variable    Status
        Exit For Loop If    '${是否终止循环}'=='Status'
    END
    log    ${委托状态}

时间戳设置
    ${交易时间_全局变量}    Get Current Date    result_format=%Y%m%d
    Set Global Variable    ${交易时间_全局变量}
    Log    ${交易时间_全局变量}

大宗交易部分入参字段处理
    ${扩展字段_全局变量}    Run KeyWord If    '${证券业务_全局变量}' in ('982','983')    Set Variable    REDUCT_FLAG=0
    ...    ELSE    Set Variable    ${EMPTY}
    ${约定号_全局变量}    Run KeyWord If    '${证券业务_全局变量}' in ('982','983')    Set Variable    ${证券代码_全局变量}
    ...    ELSE    Set Variable    ${EMPTY}
    ${对手方席位_全局变量}    Run KeyWord If    '${证券业务_全局变量}' in ('982','983')    Set Variable    ${交易单元_全局变量}
    ...    ELSE    Set Variable    ${EMPTY}
    Set Global Variable    ${扩展字段_全局变量}
    Set Global Variable    ${约定号_全局变量}
    Set Global Variable    ${对手方席位_全局变量}

字典数据精度处理
    [Arguments]    ${数据}
    ${dict}    Create Dictionary
    FOR    ${key}    ${value}    IN    @{数据}
        LOG    ${key}
        LOG    ${value}
        ${is_string}=    Evaluate    isinstance($value, str)
        #${保留一位小数的值}    Run Keyword If    '${is_string}' != 'True'    Evaluate    "%.1f" % float(${value})
        ${保留一位小数的值}    Run Keyword If    '${is_string}' != 'True'    Evaluate    "%.1f" % ${value}
        ...    ELSE    Set Variable    ${value}
        Set To Dictionary    ${dict}    ${key}    ${保留一位小数的值}
        log    ${dict}
    END
    [Return]    ${dict}

取值录制精度处理
    [Arguments]    ${数据处理结果}
    ${保留一位小数的数据}    Create List
    FOR    ${字典数据}    IN    @{数据处理结果}
        LOG    ${字典数据}
        ${键值对数据}    Get Dictionary Items    ${字典数据}
        ${保留一位小数的字典数据}    字典数据精度处理    ${键值对数据}
        Append To List    ${保留一位小数的数据}    ${保留一位小数的字典数据}
        log    ${保留一位小数的数据}
    END
    [Return]    ${保留一位小数的数据}

字典值数据精度处理
    [Arguments]    ${values}
    ${保留一位小数后的数据}    Create List
    FOR    ${value}    IN    @{values}
        ${保留一位小数的值}    Evaluate    round(${value}, 1)    #保留一位小数，会进行四舍五入处理
        #${保留一位小数的值}    Evaluate    "%.1f" % ${value}    #强制保留一位小数，且不进行四舍五入处理
        Append To List    ${保留一位小数后的数据}    ${保留一位小数的值}
    END
    Log    ${保留一位小数后的数据}
    ${values}    Set Variable    ${保留一位小数后的数据}
    [Return]    ${values}
