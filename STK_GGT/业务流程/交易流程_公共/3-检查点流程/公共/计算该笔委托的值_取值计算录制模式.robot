*** Settings ***
Resource          ../../../../公共目录/通用操作/数据库操作.robot
Resource          ../../../../公共目录/通用操作/常用关键字.robot
Resource          ../../../../业务流程/交易流程_公共/3-检查点流程/公共/接口与表_录制模式.robot

*** Keywords ***
查询接口与表取值计算录制的通用流程
    [Arguments]    ${变化数据}
    [Documentation]    1.20211123 chm 新增
    log    ${字段提取_需计算_委托前_全局变量}
    ${字段提取_需计算_委托后}    ${字段提取_无需计算_委托后}    接口/表取值流程_取值计算录制模式    ${变化数据}
    log    ${变化数据}
    ${len}    Get Length    ${字段提取_需计算_委托后}
    FOR    ${i}    IN RANGE    ${len}
        Run Keyword And Continue On Failure    接口与表计算_取值计算录制模式    ${变化数据[${i}]}    ${字段提取_需计算_委托前_全局变量[${i}]}    ${字段提取_需计算_委托后[${i}]}    ${字段提取_无需计算_委托后[${i}]}
        Run Keyword If    '${变化数据[${i}]}' in ('可用资金查询_10303001','可用股份查询_10303002')    Run Keyword And Continue On Failure    接口返回码_取值计算录制模式    ${变化数据[${i}]} _code    ${返回码_无需计算}
    END

接口/表取值流程_取值计算录制模式
    [Arguments]    ${变化数据名称}
    [Documentation]    1.20211123 chm 新增
    ${字段提取_需计算}    Set Variable
    ${字段提取_无需计算}    Set Variable
    log    ${变化数据名称}
    FOR    ${i}    IN    @{变化数据名称}
        log    ${i}
        LOG    -----接口    #ReqFundQuery_资金查询    ReqShareQuery_股份查询    basedb.t_fund_assets    basedb.t_stocks
        ${返回码}    ${返回信息}    Run Keyword If    '${i}' in ('可用资金查询_10303001','可用股份查询_10303002','ReqFundQuery_资金查询','ReqShareQuery_股份查询')    ${i}
        ${t}    Evaluate    type($返回码)
        log    ${t}
        ${返回码数据类型}    Evaluate    isinstance($返回码, list)
        Set Global Variable    ${返回码数据类型}
        log    ${返回码数据类型}
        ${返回码替换值}    Create List
        ${返回码}    Run KeyWord If    ${返回码数据类型}!=False    Set Variable    ${返回码}
        ...    ELSE    Set Variable    ${返回码替换值}
        ${字段计算差值_接口}    ${字段无需计算_接口}    Run Keyword If    ${返回信息} != [] and '${i}' in ('可用资金查询_10303001','可用股份查询_10303002','ReqFundQuery_资金查询','ReqShareQuery_股份查询')    提取接口字段_取值录制模式    ${i}    ${返回信息}
        ...    ELSE IF    ${返回信息} == [] and '${i}' in ('可用资金查询_10303001','可用股份查询_10303002','ReqFundQuery_资金查询','ReqShareQuery_股份查询')    提取接口字段_取值录制模式中接口返回空数据处理    ${i}    ${返回信息}
        LOG    -----表
        ${字段计算差值_表}    ${字段无需计算_表}    Run Keyword If    '${i}' in ('CUACCT_FUND','STK_ASSET','basedb.t_fund_assets','basedb.t_stocks')    提取表字段_取值录制模式    ${i}
        LOG    -----转换
        Run Keyword if    '${i}' in ('可用资金查询_10303001','可用股份查询_10303002')    接口返回码_返回消息处理    ${i}    ${返回码}
        ${计算}    Set Variable IF    '${i}' in ('可用资金查询_10303001','可用股份查询_10303002','ReqFundQuery_资金查询','ReqShareQuery_股份查询')    ${字段计算差值_接口}    ${字段计算差值_表}
        ${无计算}    Set Variable IF    '${i}' in ('可用资金查询_10303001','可用股份查询_10303002','ReqFundQuery_资金查询','ReqShareQuery_股份查询')    ${字段无需计算_接口}    ${字段无需计算_表}
        ${字段提取_需计算}    追加list转换为字符串    ${计算}    ${字段提取_需计算}
        ${字段提取_无需计算}    追加list转换为字符串    ${无计算}    ${字段提取_无需计算}
        log    ${字段提取_需计算}
        log    ${字段提取_无需计算}
    END
    ${字段提取_需计算}    字符串转换成list    ${字段提取_需计算}
    ${字段提取_无需计算}    字符串转换成list    ${字段提取_无需计算}
    log    ${字段提取_需计算}
    log    ${字段提取_无需计算}
    [Return]    ${字段提取_需计算}    ${字段提取_无需计算}

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

接口返回码_取值计算录制模式
    [Arguments]    ${code}    ${返回码_无需计算}    ${接口类型}=${接口类型_全局变量}
    ${code_date}    Set Variable    ${返回码_无需计算}
    ${type}    Evaluate    type($code_date)
    ${处理字符}    Create Dictionary    :==    '=${EMPTY}    ${SPACE}=${EMPTY}
    ${数据处理2}    字符串处理    ${code_date}    ${处理字符}
    ${比对结果2}    返回码数据写入表_录制模式    ${code}    ${数据处理2};
    ${执行结果2}    Run Keyword If    '${比对结果2}'=='0'    Set Variable    校验通过
    ...    ELSE IF    '${比对结果2}'=='1'    Set Variable    核对${接口或表名称}表不正确，核对SQL：select * from ddxt_test_rfautotest_data_log where TESTCASE_ID='${TEST_NAME}' order by test_date desc
    ...    ELSE IF    '${比对结果2}'=='2'    Set Variable    ${接口或表名称}字段有新增，基准数据需要增加新字段内容，请核查
    Run Keyword And Continue On Failure    Should Be Equal As Strings    ${比对结果2}    0    ${执行结果2}    #0校验通过，1表示校验不通过

数据写入表_录制模式
    [Arguments]    ${接口数据名称}    ${接口数据}
    [Documentation]    1.20211123 chm 新增 2.20230825 ch 修改
    LOG    ${接口数据}
    数据库链接    ${EMPTY}
    ${list}    Run KeyWord If    '${用例首字段}' in {'13','03'}    Create List    ${TEST_NAME}    ${客户代码_全局变量}    ${接口数据名称}    ${接口数据}    ;
    ...    ELSE    Create List    ${TEST_NAME}    ${客户代码_全局变量}    ${接口数据名称}    ${接口数据}    ;    #用例编号    #客户号
    log    ${list}
    ${ret}    Run Keyword And Continue On Failure    Call Stored Function    DDXT_RFTEST_DATA_LOG    ${list}    #写入表：DDXT_RFAUTOTEST_DATA_LOG    #多次执行记录的表DDXT_TEST_RFAUTOTEST_DATA_LOG
    ${ret}    Set Variable If    '${ret}'=='None'    2    ${ret}
    [Return]    ${ret}

返回码数据写入表_录制模式
    [Arguments]    ${code}    ${code_date}
    ${list2}    Run KeyWord If    '${用例首字段}' in {'13','03'}    Create List    ${TEST_NAME}    ${客户代码_全局变量}    ${code}    ${code_date}    ;
    ...    ELSE    Create List    ${TEST_NAME}    ${客户代码_全局变量}    ${code}    ${code_date}    ;    #用例编号    #客户号
    ${ret2}    Run Keyword And Continue On Failure    Call Stored Function    DDXT_RFTEST_DATA_LOG    ${list2}    #写入表：DDXT_RFAUTOTEST_DATA_LOG    #多次执行记录的表DDXT_TEST_RFAUTOTEST_DATA_LOG
    ${ret2}    Set Variable If    '${ret2}'=='None'    2    ${ret2}
    [Return]    ${ret2}

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

接口返回码_返回消息处理
    [Arguments]    ${i}    ${返回码}
    ${字段提取_无需计算}    Set Variable
    ${字段计算差值_返回码_返回信息}    ${字段无需计算_返回码_返回信息}    Run Keyword If    '${i}' in ('可用资金查询_10303001','可用股份查询_10303002')    提取接口字段_取值录制模式    委托状态码_委托信息    ${返回码}
    ${返回码_无计算}    Set Variable    ${字段无需计算_返回码_返回信息}
    ${返回码_无需计算}    追加list转换为字符串    ${返回码_无计算}    ${字段提取_无需计算}
    Set Global Variable    ${返回码_无需计算}
