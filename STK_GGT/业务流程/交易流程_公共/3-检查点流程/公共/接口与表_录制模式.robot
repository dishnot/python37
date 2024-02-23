*** Settings ***
Resource          计算该笔委托的值_取值计算录制模式.robot
Resource          接口与表_比对模式.robot
Resource          ../../../../公共目录/配置信息/金证_字段信息.robot
Resource          ../../../../公共目录/通用操作/常用关键字.robot

*** Keywords ***
查询接口与表取值录制的通用流程
    [Arguments]    ${数据名称}    ${接口类型}=${接口类型_全局变量}
    [Documentation]    1.20211123 chm 新增
    FOR    ${i}    IN    @{数据名称}
        ${返回码}    ${返回信息}    Run Keyword If    '${i}'in ('当日委托查询_10303003')    委托撤单查询_多条数据_比对录制模式    ${i}
        ...    ELSE IF    '${i}'in ('当日成交查询_10303004','港股通汇率信息查询_10301053','港股通标的证券状态查询_10301059','港股通二级资金台账查询_10303027')    ${i}
        ${返回码数据类型}    Evaluate    isinstance($返回码, list)
        log    ${返回码数据类型}
        Set Global Variable    ${返回码数据类型}
        ${返回码替换值}    Create List
        ${返回码}    Run KeyWord If    ${返回码数据类型}!=False    Set Variable    ${返回码}
        ...    ELSE    Set Variable    ${返回码替换值}
        Comment    ${返回码}    ${返回信息}    Run Keyword If    '${i}'in ('当日委托查询_10303003','当日成交查询_10303004')    ${i}
        ${返回信息_条数}    Run Keyword If    '${i}' in ('当日委托查询_10303003','当日成交查询_10303004','港股通汇率信息查询_10301053','港股通标的证券状态查询_10301059','港股通二级资金台账查询_10303027')    Get Length    ${返回信息}
        ...    ELSE    Set Variable    1
        ${排序字段}    Run Keyword If    '${接口类型}'=='Stk' and '${i}' in ('当日委托查询_10303003','当日成交查询_10303004')    Set Variable    ORDER_STATUS
        ...    ELSE IF    '${i}' in ('港股通汇率信息查询_10301053')    Set Variable    STKBD
        ...    ELSE IF    '${i}' in ('港股通二级资金台账查询_10303027')    Set Variable    CUACCT_CODE
        ...    ELSE IF    '${i}' in ('港股通标的证券状态查询_10301059')    Set Variable    STK_CODE
        ...    ELSE    Set Variable    STK_CODE
        ${返回信息}    Run Keyword If    '${i}' in ('当日委托查询_10303003','当日成交查询_10303004','港股通汇率信息查询_10301053','港股通标的证券状态查询_10301059','港股通二级资金台账查询_10303027') and '${返回信息_条数}'>'0'    接口数据排序    ${返回信息}    ${排序字段}
        ...    ELSE    Set Variable    ${返回信息}
        log    ${返回信息}
        Run Keyword If    '${i}' in ('当日委托查询_10303003','当日成交查询_10303004','港股通汇率信息查询_10301053','港股通标的证券状态查询_10301059','港股通二级资金台账查询_10303027')    接口返回码_返回消息处理1    ${i}    ${返回码}
        ${返回信息}    Run KeyWord If    ${取值按钮}==1    表/接口取值精度处理    ${返回信息}
        ...    ELSE    Set Variable    ${返回信息}
        ${数据处理结果}    Run Keyword If    '${返回信息_条数}'>'0'    接口与表处理_录制模式    ${i}    ${返回信息}
        ...    ELSE IF    '${返回信息_条数}'=='0'    Set Variable    无查询结果;
        comment    #接口数据写入表中
        ${比对结果}    数据写入表_录制模式    ${i}    ${数据处理结果}
        ${执行结果}    Run Keyword If    '${比对结果}'=='0'    Set Variable    校验通过
        ...    ELSE IF    '${比对结果}'=='1'    Set Variable    核对${i}表不正确，核对SQL：select * from ddxt_test_rfautotest_data_log where TESTCASE_ID='${TEST_NAME}' order by test_date desc
        ...    ELSE IF    '${比对结果}'=='2'    Set Variable    ${i}字段有新增，基准数据需要增加新字段内容，请核查
        Run Keyword And Continue On Failure    Should Be Equal As Strings    ${比对结果}    0    ${执行结果}    #0校验通过，1表示校验不通过
        Run Keyword If    '${i}' in ('当日委托查询_10303003','当日成交查询_10303004','港股通汇率信息查询_10301053','港股通标的证券状态查询_10301059','港股通二级资金台账查询_10303027')    Run Keyword And Continue On Failure    接口返回码_取值计算录制模式    ${i}_code    ${返回码_无需计算}
    END

查询接口与表数据进行格式处理_录制模式
    [Arguments]    ${数据}    ${删除的keys}=${EMPTY}    ${剔除字段}=NO
    [Documentation]    1.20211123 chm 新增
    ${results}    Set Variable
    log    ${数据}
    FOR    ${i}    IN    @{数据}
        log    ${i}
        ${更新后字典}    Run Keyword If    '${剔除字段}'=='YES'    删除字典部分字段    ${i}    ${删除的keys}
        ...    ELSE    Set Variable    ${i}
        ${处理字符}    Create Dictionary    :==    '=${EMPTY}    ${SPACE}=${EMPTY}
        ${数据处理}    字符串处理    ${更新后字典}    ${处理字符}
        ${results}    Catenate    SEPARATOR=;    ${数据处理}    ${results}
    END
    log    ${results}
    [Return]    ${results}

提取接口字段_取值录制模式
    [Arguments]    ${接口名称}    ${返回信息}    ${接口类型}=${接口类型_全局变量}
    ${委托字段}    Run Keyword If    '${接口类型}'=='Stk'    金证_录制字段    ${接口名称}
    ${字段计算差值}    ${字段无需计算}    字段与值建立成字典_取值计算录制模式    ${委托字段}
    log    ${返回信息}
    log    ---重新建立新的字典
    ${字段计算差值dic}    ${字段无需计算dic}    Run KeyWord If    ${返回码数据类型}!=False    字段提取重新转换为字典处理    ${字段计算差值}    ${字段无需计算}    ${返回信息}
    ...    ELSE    Set Variable    None    None
    log    ${字段无需计算dic}
    [Return]    ${字段计算差值dic}    ${字段无需计算dic}

提取表字段_取值录制模式
    [Arguments]    ${接口名称}    ${接口类型}=${接口类型_全局变量}
    ${委托字段}    Run Keyword If    '${接口类型}'=='Stk'    金证_录制字段    ${接口名称}
    ${字段计算差值}    ${字段无需计算}    字段与值建立成字典_取值计算录制模式    ${委托字段}
    log    ---查询数据并建立成字典
    ${表_需计算值}    买卖交易委托后检查_表查询    ${接口名称}    ${字段计算差值}
    ${表_无需计算值}    买卖交易委托后检查_表查询    ${接口名称}    ${字段无需计算}
    ${len}    Get Length    ${表_需计算值}
    ${表_需计算值}    Set Variable if    '${len}'=='1'    ${表_需计算值[0]}    ${表_需计算值}
    ${表_无需计算值}    Set Variable if    '${len}'=='1'    ${表_无需计算值[0]}    ${表_无需计算值}
    [Return]    ${表_需计算值}    ${表_无需计算值}

接口与表处理_录制模式
    [Arguments]    ${数据名称}    ${返回信息}    ${接口类型}=${接口类型_全局变量}
    [Documentation]    1.20211123 chm 新增
    ${委托字段}    Run Keyword If    '${接口类型}'=='Stk'    金证_录制字段    ${数据名称}
    log    ---接口数据处理---
    ${字段key}    ${字段values}    字段与值建立成字典_取值计算录制模式    ${委托字段}
    ${接口返回信息}    Run Keyword If    '${数据名称}' in ('当日委托查询_10303003','当日成交查询_10303004','港股通汇率信息查询_10301053','港股通标的证券状态查询_10301059','港股通二级资金台账查询_10303027')    查询接口与表数据进行格式处理_录制模式    ${返回信息}    ${字段key}    YES
    log    ---表数据---
    ${查询表结果}    Run Keyword If    '${数据名称}' in ('STK_ORDER','STK_MATCHING','STK_ORDER_DETAIL','CUACCT_FUND_DETAIL','CUACCT_FUND_BORROW')    买卖交易委托后检查_表查询    ${数据名称}    ${字段key}
    ${查询表结果}    Run KeyWord If    ${取值按钮}==1    表/接口取值精度处理    ${查询表结果}
    ...    ELSE    Set Variable    ${查询表结果}
    ${len}    Run Keyword If    '${数据名称}' in ('STK_ORDER','STK_MATCHING','STK_ORDER_DETAIL','CUACCT_FUND_DETAIL','CUACCT_FUND_BORROW')    Get Length    ${查询表结果}
    ${表结果处理}    Run Keyword If    '${数据名称}' in ('STK_ORDER','STK_MATCHING','STK_ORDER_DETAIL','CUACCT_FUND_DETAIL','CUACCT_FUND_BORROW')    查询接口与表数据进行格式处理_录制模式    ${查询表结果}
    ${表结果}    Run Keyword If    '${len}'>'0'    Set Variable    ${表结果处理}
    ...    ELSE IF    '${len}'=='0'    Set Variable    无记录;
    log    ${表结果}
    ${数据处理结果}    Set Variable If    '${数据名称}' in ('当日委托查询_10303003','当日成交查询_10303004','港股通汇率信息查询_10301053','港股通标的证券状态查询_10301059','港股通二级资金台账查询_10303027')    ${接口返回信息}    ${表结果}
    log    ${数据处理结果}
    [Return]    ${数据处理结果}

接口与表处理_比对模式
    [Arguments]    ${查询接口名称}    ${返回信息}    ${接口类型}=${接口类型_全局变量}
    [Documentation]    1.20211123 chm 新增
    ${接口字典}    Run Keyword If    '${接口类型}'=='Stk'    金证_比对字段    ${查询接口名称}
    ${接口结果}    Create List
    log    ---接口字段重新提取---
    FOR    ${i}    IN    @{返回信息}
        ${接口字段}    字典重新提取成新字典    ${i}    ${接口字典}
        Append To List    ${接口结果}    ${接口字段}
        Exit For Loop If    '${查询接口名称}'=='循环到尽头'
    END
    log    ${接口结果}
    log    ---表字段提取并转换为字典---
    ${表结果}    买卖交易委托后检查_表查询    ${查询接口名称}    ${接口字典}
    log    ${表结果}
    [Return]    ${接口结果}    ${表结果}

提取接口字段_取值录制模式中接口返回空数据处理
    [Arguments]    ${接口名称}    ${返回信息}    ${接口类型}=${接口类型_全局变量}
    ${委托字段}    Run Keyword If    '${接口类型}'=='Stk'    金证_录制字段    ${接口名称}
    ${字段计算差值}    ${字段无需计算}    Run Keyword If    ${返回信息}!=[]    字段与值建立成字典_取值计算录制模式    ${委托字段}
    ...    ELSE    字段与值建立成字典_取值计算录制模式中接口返回空数据处理    ${委托字段}
    log    ${返回信息}
    log    ---重新建立新的字典
    ${字段计算差值dic}    Set Variable    ${字段计算差值}
    ${字段无需计算dic}    Set Variable    ${字段无需计算}
    log    ${字段计算差值dic}
    log    ${字段无需计算dic}
    [Return]    ${字段计算差值dic}    ${字段无需计算dic}

接口返回码_返回消息处理1
    [Arguments]    ${i}    ${返回码}
    ${字段提取_无需计算}    Set Variable
    ${字段计算差值_返回码_返回信息}    ${字段无需计算_返回码_返回信息}    Run Keyword If    '${i}' in ('当日委托查询_10303003','当日成交查询_10303004','港股通汇率信息查询_10301053','港股通标的证券状态查询_10301059','港股通二级资金台账查询_10303027')    提取接口字段_取值录制模式    委托状态码_委托信息    ${返回码}
    ${返回码_无计算}    Set Variable    ${字段无需计算_返回码_返回信息}
    ${返回码_无需计算}    Run KeyWord If    ${返回码数据类型}!=False    追加list转换为字符串    ${返回码_无计算}    ${字段提取_无需计算}
    ...    ELSE    Set Variable    []
    Set Global Variable    ${返回码_无需计算}

字段提取重新转换为字典处理
    [Arguments]    ${字段计算差值}    ${字段无需计算}    ${返回信息}
    FOR    ${i}    IN    @{返回信息}
        log    ${i}
        ${字段计算差值dic}    字典重新提取成新字典    ${i}    ${字段计算差值}
        Append To List    ${字段计算差值dic}
        log    ----无需计算
        ${字段无需计算dic}    字典重新提取成新字典    ${i}    ${字段无需计算}
        Append To List    ${字段无需计算dic}
    END
    [Return]    ${字段计算差值dic}    ${字段无需计算dic}
