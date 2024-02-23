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
    END

接口/表取值流程_取值计算录制模式_备份
    [Arguments]    ${变化数据名称}
    [Documentation]    1.20211123 chm 新增
    ${字段提取_需计算}    Set Variable
    ${字段提取_无需计算}    Set Variable
    log    ${变化数据名称}
    FOR    ${i}    IN    @{变化数据名称}
        log    ${i}
        LOG    -----接口    #ReqFundQuery_资金查询    ReqShareQuery_股份查询    basedb.t_fund_assets    basedb.t_stocks
        ${返回码}    ${返回信息}    Run Keyword If    '${i}' in ('可用资金查询_10303001','可用股份查询_10303002','ReqFundQuery_资金查询','ReqShareQuery_股份查询')    ${i}
        ${字段计算差值_接口}    ${字段无需计算_接口}    Run Keyword If    '${i}' in ('可用资金查询_10303001','可用股份查询_10303002','ReqFundQuery_资金查询','ReqShareQuery_股份查询')    提取接口字段_取值录制模式    ${i}    ${返回信息}
        LOG    -----表
        ${字段计算差值_表}    ${字段无需计算_表}    Run Keyword If    '${i}' in ('CUACCT_FUND','STK_ASSET','basedb.t_fund_assets','basedb.t_stocks')    提取表字段_取值录制模式    ${i}
        LOG    -----转换
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
        ${字段计算差值_接口}    ${字段无需计算_接口}    Run Keyword If    ${返回信息} != [] and '${i}' in ('可用资金查询_10303001','可用股份查询_10303002','ReqFundQuery_资金查询','ReqShareQuery_股份查询')    提取接口字段_取值录制模式    ${i}    ${返回信息}
        ...    ELSE IF    ${返回信息} == [] and '${i}' in ('可用资金查询_10303001','可用股份查询_10303002','ReqFundQuery_资金查询','ReqShareQuery_股份查询')    提取接口字段_取值录制模式中接口返回空数据处理    ${i}    ${返回信息}
        LOG    -----表
        ${字段计算差值_表}    ${字段无需计算_表}    Run Keyword If    '${i}' in ('CUACCT_FUND','STK_ASSET','basedb.t_fund_assets','basedb.t_stocks')    提取表字段_取值录制模式    ${i}
        LOG    -----转换
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

数据写入表_录制模式_备份
    [Arguments]    ${接口数据名称}    ${接口数据}
    [Documentation]    1.20211123 chm 新增
    数据库链接    ${EMPTY}
    ${接口数据名称}    Run Keyword If    '${模式_全局变量}'=='软加速'    Set Variable    ${接口数据名称}_${模式_全局变量}
    ...    ELSE    Set Variable    ${接口数据名称}
    ${list}    Create List    ${TEST_NAME}    ${客户代码_全局变量}    ${接口数据名称}    ${接口数据}    ;    #用例编号    #客户号
    log    ${list}
    ${ret}    Run Keyword And Continue On Failure    Call Stored Function    DDXT_RFTEST_DATA_LOG    ${list}    #写入表：DDXT_RFAUTOTEST_DATA_LOG    #多次执行记录的表DDXT_TEST_RFAUTOTEST_DATA_LOG
    ${ret}    Set Variable If    '${ret}'=='None'    2    ${ret}
    [Return]    ${ret}

数据写入表_录制模式
    [Arguments]    ${接口数据名称}    ${接口数据}
    [Documentation]    1.20211123 chm 新增
    数据库链接    ${EMPTY}
    ${list}    Create List    ${TEST_NAME}    ${客户代码_全局变量}    ${接口数据名称}    ${接口数据}    ;    #用例编号    #客户号
    log    ${list}
    ${ret}    Run Keyword And Continue On Failure    Call Stored Function    DDXT_RFTEST_DATA_LOG    ${list}    #写入表：DDXT_RFAUTOTEST_DATA_LOG    #多次执行记录的表DDXT_TEST_RFAUTOTEST_DATA_LOG
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
