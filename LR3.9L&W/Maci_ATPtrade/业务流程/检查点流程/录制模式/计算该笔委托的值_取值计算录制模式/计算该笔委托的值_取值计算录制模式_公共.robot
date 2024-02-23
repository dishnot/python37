*** Settings ***
Resource          ../../../../公共目录/通用操作/数据库操作.robot
Resource          ../../../../公共目录/通用操作/常用关键字.robot
Resource          ../../../../业务流程/检查点流程/录制模式/接口与表_录制模式/接口与表_录制模式_公共.robot
Resource          ../../../../业务流程/检查点流程/录制模式/接口与表_录制模式/接口与表_录制模式_普通.robot

*** Keywords ***
字段与值建立成字典_取值计算录制模式
    [Arguments]    ${委托字段}
    [Documentation]    1.20211123 chm 新增
    ${字段计算差值}    Create Dictionary
    ${字段无需计算}    Create Dictionary
    FOR    ${j}    IN    @{委托字段}
        log    ${j}
        comment    把查询的字段和值建立成字典
        Run Keyword If    '${委托字段["${j}"]}'!='无计算逻辑'    Set To Dictionary    ${字段计算差值}    ${j}=${委托字段["${j}"]}
        Run Keyword If    '${委托字段["${j}"]}'=='无计算逻辑'    Set To Dictionary    ${字段无需计算}    ${j}=${委托字段["${j}"]}
    END
    log    ${字段计算差值}
    log    ${字段无需计算}
    [Return]    ${字段计算差值}    ${字段无需计算}

接口与表计算_取值计算录制模式
    [Arguments]    ${接口或表名称}    ${委托前数据}    ${委托后数据}    ${无变化委托数据}    ${接口类型}=${接口类型_全局变量}
    [Documentation]    1.20211123 chm 新增
    log    ${字段提取_需计算_委托前_全局变量}
    ${委托前数据key}    ${委托前数据values}    ${字典}    类似字典类的字符串转换为字典    ${委托前数据}
    ${委托后数据key}    ${委托后数据values}    ${字典}    类似字典类的字符串转换为字典    ${委托后数据}
    log    ${委托前数据values}
    log    ${委托后数据values}
    log    ${无变化委托数据}
    log    ----对list中values进行相减
    ${交易数据}    列表相减    ${委托前数据values}    ${委托后数据values}
    log    ----转换为字典
    ${委托变化值}    列表转换为字典    ${委托前数据key}    ${交易数据}
    log    ----写入表中
    ${处理字符}    Create Dictionary    :==    '=${EMPTY}    ${SPACE}=${EMPTY}
    ${数据处理}    字符串处理    ${委托变化值},${无变化委托数据}    ${处理字符}
    ${比对结果}    数据写入表_录制模式    ${接口或表名称}    ${数据处理};
    ${执行结果}    Run Keyword If    '${比对结果}'=='0'    Set Variable    校验通过
    ...    ELSE IF    '${比对结果}'=='1'    Set Variable    核对${接口或表名称}表不正确，核对SQL：select * from ddxt_test_rfautotest_data_log where TESTCASE_ID='${TEST_NAME}' order by test_date desc
    ...    ELSE IF    '${比对结果}'=='2'    Set Variable    ${接口或表名称}字段有新增，基准数据需要增加新字段内容，请核查
    Run Keyword And Continue On Failure    Should Be Equal As Strings    ${比对结果}    0    ${执行结果}    #0校验通过，1表示校验不通过

数据写入表_录制模式
    [Arguments]    ${接口数据名称}    ${接口数据}
    [Documentation]    1.20211123 chm 新增
    数据库链接    ${EMPTY}
    ${list}    Create List    ${TEST_NAME}    ${客户代码_全局变量}    ${接口数据名称}    ${接口数据}    ;    #用例编号    #客户号
    log    ${list}
    ${ret}    Run Keyword And Continue On Failure    Call Stored Function    LRDD_RFTEST_DATA_LOG    ${list}    #写入表：LRDD_RFAUTOTEST_DATA_LOG    #多次执行记录的表LRDD_TEST_RFAUTOTEST_DATA_LOG
    ${ret}    Set Variable If    '${ret}'=='None'    2    ${ret}
    [Return]    ${ret}

字段与值建立成字典_取值计算录制模式中接口返回空数据处理
    [Arguments]    ${委托字段}
    ${字段计算差值}    Create Dictionary
    ${字段无需计算}    Create Dictionary
    FOR    ${j}    IN    @{委托字段}
        log    ${j}
        comment    把查询的字段和值建立成字典
        Run Keyword If    '${委托字段["${j}"]}'!='无计算逻辑'    Set To Dictionary    ${字段计算差值}    ${j}=0
        Run Keyword If    '${委托字段["${j}"]}'=='无计算逻辑'    Set To Dictionary    ${字段无需计算}    ${j}=${委托字段["${j}"]}
    END
    log    ${字段计算差值}
    log    ${字段无需计算}
    [Return]    ${字段计算差值}    ${字段无需计算}

总对总字段与值建立成字典_取值录制模式
    [Arguments]    ${委托字段}
    [Documentation]    1.20211123 chm 新增
    ${字段计算差值}    Create Dictionary
    ${字段无需计算}    Create Dictionary
    FOR    ${j}    IN    @{委托字段}
        log    ${j}
        comment    把查询的字段和值建立成字典
        Run Keyword If    '${委托字段["${j}"]}'!='无计算逻辑'    Set To Dictionary    ${字段计算差值}    ${j}=${委托字段["${j}"]}
        Run Keyword If    '${委托字段["${j}"]}'=='无计算逻辑'    Set To Dictionary    ${字段无需计算}    ${j}=${委托字段["${j}"]}
    END
    log    ${字段计算差值}
    log    ${字段无需计算}
    [Return]    ${字段计算差值}    ${字段无需计算}
