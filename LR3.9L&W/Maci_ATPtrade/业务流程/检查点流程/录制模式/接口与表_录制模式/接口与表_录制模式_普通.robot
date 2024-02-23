*** Settings ***
Resource          ../../../../业务流程/检查点流程/录制模式/计算该笔委托的值_取值计算录制模式/计算该笔委托的值_取值计算录制模式_公共.robot
Resource          ../../../../业务流程/检查点流程/录制模式/计算该笔委托的值_取值计算录制模式/计算该笔委托的值_取值计算录制模式_普通.robot
Resource          ../../../../业务流程/检查点流程/录制模式/接口与表_比对模式/接口与表_比对模式_公共.robot
Resource          ../../../../业务流程/检查点流程/录制模式/接口与表_比对模式/接口与表_比对模式_普通.robot
Resource          ../../../../公共目录/配置信息/金证_字段信息.robot
Resource          ../../../../公共目录/通用操作/常用关键字.robot

*** Keywords ***
接口与表处理_录制模式
    [Arguments]    ${数据名称}    ${返回信息}    ${接口类型}=${接口类型_全局变量}
    [Documentation]    1.20211123 chm 新增
    ${委托字段}    Run Keyword If    '${接口类型}'=='Fis'    金证_录制字段    ${数据名称}
    log    ---接口数据处理---
    ${字段key}    ${字段values}    字段与值建立成字典_取值计算录制模式    ${委托字段}
    ${接口返回信息}    Run Keyword If    '${数据名称}' in ('当日委托查询_10303003','当日成交查询_10303004','融资融券合约_10323001','实时偿还明细_10321012')    查询接口与表数据进行格式处理_录制模式    ${返回信息}    ${字段key}    YES
    log    ---表数据---
    ${查询表结果}    Run Keyword If    '${数据名称}' in ('STK_ORDER','STK_MATCHING','FISL_CONTRACT','FISL_REPAY_DETAIL','FISL_FEE_SUM')    买卖交易委托后检查_表查询    ${数据名称}    ${字段key}
    ${len}    Run Keyword If    '${数据名称}' in ('STK_ORDER','STK_MATCHING','FISL_CONTRACT','FISL_REPAY_DETAIL','FISL_FEE_SUM')    Get Length    ${查询表结果}
    ${表结果处理}    Run Keyword If    '${数据名称}' in ('STK_ORDER','STK_MATCHING','FISL_CONTRACT','FISL_REPAY_DETAIL','FISL_FEE_SUM')    查询接口与表数据进行格式处理_录制模式    ${查询表结果}
    ${表结果}    Run Keyword If    '${len}'>'0'    Set Variable    ${表结果处理}
    ...    ELSE IF    '${len}'=='0'    Set Variable    无记录;
    log    ${表结果}
    ${数据处理结果}    Set Variable If    '${数据名称}' in ('当日委托查询_10303003','当日成交查询_10303004','融资融券合约_10323001','实时偿还明细_10321012')    ${接口返回信息}    ${表结果}
    log    ${数据处理结果}
    [Return]    ${数据处理结果}

接口与表处理_比对模式
    [Arguments]    ${查询接口名称}    ${返回信息}    ${接口类型}=${接口类型_全局变量}
    [Documentation]    1.20211123 chm 新增
    ${接口字典}    Run Keyword If    '${接口类型}'=='Fis'    金证_比对字段    ${查询接口名称}
    log    ${接口字典}
    ${接口结果}    Create List
    log    ---接口字段重新提取---
    log    ${返回信息}
    FOR    ${i}    IN    @{返回信息}
        ${接口字段}    字典重新提取成新字典    ${i}    ${接口字典}
        Append To List    ${接口结果}    ${接口字段}
        Exit For Loop If    '${查询接口名称}'=='当日成交查询_5555555'
    END
    log    ${接口结果}
    log    ---表字段提取并转换为字典---
    ${表结果}    买卖交易委托后检查_表查询    ${查询接口名称}    ${接口字典}
    log    ${表结果}
    [Return]    ${接口结果}    ${表结果}

提取表字段_取值录制模式
    [Arguments]    ${接口名称}    ${接口类型}=${接口类型_全局变量}
    ${委托字段}    Run Keyword If    '${接口类型}'=='Fis'    金证_录制字段    ${接口名称}
    ${字段计算差值}    ${字段无需计算}    字段与值建立成字典_取值计算录制模式    ${委托字段}
    log    ---查询数据并建立成字典
    ${表_需计算值}    买卖交易委托后检查_表查询    ${接口名称}    ${字段计算差值}
    ${表_无需计算值}    买卖交易委托后检查_表查询    ${接口名称}    ${字段无需计算}
    ${len}    Get Length    ${表_需计算值}
    ${表_需计算值}    Set Variable if    '${len}'=='1'    ${表_需计算值[0]}    ${表_需计算值}
    ${表_无需计算值}    Set Variable if    '${len}'=='1'    ${表_无需计算值[0]}    ${表_无需计算值}
    [Return]    ${表_需计算值}    ${表_无需计算值}

查询接口与表取值录制的通用流程
    [Arguments]    ${数据名称}    ${接口类型}=${接口类型_全局变量}
    [Documentation]    1.20211123 chm 新增
    FOR    ${i}    IN    @{数据名称}
        ${返回码}    ${返回信息}    Run Keyword If    '${i}'=='当日委托查询_10303003'    委托撤单查询_多条数据_比对录制模式    ${i}
        ...    ELSE IF    '${i}'=='当日成交查询_10303004'    ${i}
        ...    ELSE IF    '${i}'=='融资融券合约_10323001'    ${i}
        ...    ELSE IF    '${i}'=='实时偿还明细_10321012'    ${i}
        Comment    ${返回码}    ${返回信息}    Run Keyword If    '${i}'in ('当日委托查询_10303003','当日成交查询_10303004','融资融券合约_10323001','实时偿还明细_10321012')    ${i}
        ${返回信息_条数}    Run Keyword If    '${i}' in ('当日委托查询_10303003','当日成交查询_10303004','融资融券合约_10323001','实时偿还明细_10321012')    Get Length    ${返回信息}
        ...    ELSE    Set Variable    1
        ${排序字段}    Run Keyword If    '${接口类型}'=='Fis' and '${i}' in ('当日委托查询_10303003','当日成交查询_10303004')    Set Variable    ORDER_STATUS
        ...    ELSE    Set Variable    STK_CODE
        ${返回信息}    Run Keyword If    '${i}' in ('当日委托查询_10303003','当日成交查询_10303004','融资融券合约_10323001','实时偿还明细_10321012') and '${返回信息_条数}'>'0'    接口数据排序    ${返回信息}    ${排序字段}
        ...    ELSE    Set Variable    ${返回信息}
        log    ${返回信息}
        ${type}    Evaluate    isinstance($返回信息, list)
        ${按精度处理数据}    Run Keyword If    '${type}'=='True'    取值录制精度处理    ${返回信息}
        ${返回信息}    Run Keyword If    '${type}'=='True'and '${int}'=='1'    Set Variable    ${按精度处理数据}
        ...    ELSE IF    '${type}'!='True'or '${int}'=='0'    Set Variable    ${返回信息}
        ${数据处理结果}    Run Keyword If    '${返回信息_条数}'>'0'    接口与表处理_录制模式    ${i}    ${返回信息}
        ...    ELSE IF    '${返回信息_条数}'=='0'    Set Variable    无查询结果;
        comment    #接口数据写入表中
        ${比对结果}    数据写入表_录制模式    ${i}    ${数据处理结果}
        ${执行结果}    Run Keyword If    '${比对结果}'=='0'    Set Variable    校验通过
        ...    ELSE IF    '${比对结果}'=='1'    Set Variable    核对${i}表不正确，核对SQL：select * from LRDD_TEST_RFAUTOTEST_DATA_LOG where TESTCASE_ID='${TEST_NAME}' order by test_date desc
        ...    ELSE IF    '${比对结果}'=='2'    Set Variable    ${i}字段有新增，基准数据需要增加新字段内容，请核查
        Run Keyword And Continue On Failure    Should Be Equal As Strings    ${比对结果}    0    ${执行结果}    #0校验通过，1表示校验不通过
    END
