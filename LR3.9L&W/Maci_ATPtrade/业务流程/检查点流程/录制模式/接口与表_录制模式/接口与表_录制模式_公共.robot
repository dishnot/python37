*** Settings ***
Resource          ../../../../业务流程/检查点流程/录制模式/计算该笔委托的值_取值计算录制模式/计算该笔委托的值_取值计算录制模式_公共.robot
Resource          ../../../../业务流程/检查点流程/录制模式/计算该笔委托的值_取值计算录制模式/计算该笔委托的值_取值计算录制模式_普通.robot
Resource          ../../../../业务流程/检查点流程/录制模式/接口与表_比对模式/接口与表_比对模式_公共.robot
Resource          ../../../../业务流程/检查点流程/录制模式/接口与表_比对模式/接口与表_比对模式_普通.robot
Resource          ../../../../公共目录/配置信息/金证_字段信息.robot
Resource          ../../../../公共目录/通用操作/数据库操作.robot
Resource          ../../../../公共目录/通用操作/常用关键字.robot

*** Keywords ***
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
    ${委托字段}    Run Keyword If    '${接口类型}'=='Fis'    金证_录制字段    ${接口名称}
    ${字段计算差值}    ${字段无需计算}    字段与值建立成字典_取值计算录制模式    ${委托字段}
    log    ${返回信息}
    log    ---重新建立新的字典
    FOR    ${i}    IN    @{返回信息}
        log    ${i}
        ${字段计算差值dic}    字典重新提取成新字典    ${i}    ${字段计算差值}
        Append To List    ${字段计算差值dic}
        log    ----无需计算
        ${字段无需计算dic}    字典重新提取成新字典    ${i}    ${字段无需计算}
        Append To List    ${字段无需计算dic}
    END
    log    ${字段计算差值dic}
    log    ${字段无需计算dic}
    [Return]    ${字段计算差值dic}    ${字段无需计算dic}

提取接口字段_取值录制模式中接口返回空数据处理
    [Arguments]    ${接口名称}    ${返回信息}    ${接口类型}=${接口类型_全局变量}
    ${委托字段}    Run Keyword If    '${接口类型}'=='Fis'    金证_录制字段    ${接口名称}
    ${字段计算差值}    ${字段无需计算}    Run Keyword If    ${返回信息}!=[]    字段与值建立成字典_取值计算录制模式    ${委托字段}
    ...    ELSE    字段与值建立成字典_取值计算录制模式中接口返回空数据处理    ${委托字段}
    log    ${返回信息}
    log    ---重新建立新的字典
    ${字段计算差值dic}    Set Variable    ${字段计算差值}
    ${字段无需计算dic}    Set Variable    ${字段无需计算}
    log    ${字段计算差值dic}
    log    ${字段无需计算dic}
    [Return]    ${字段计算差值dic}    ${字段无需计算dic}

委托前总对总接口与表处理_录制模式
    [Arguments]    ${数据名称}    ${返回信息}    ${接口类型}=${接口类型_全局变量}
    [Documentation]    1.2023
    log    ${数据名称}
    ${数据名称A}    Run Keyword If    '${数据名称}'=='委托前_融券合约汇总信息_10323031_全字段'    Set Variable    融券合约汇总信息_10323031_全字段
    ...    ELSE IF    '${数据名称}'=='委托前_融资合约汇总信息_10323030_全字段'    Set Variable    融资合约汇总信息_10323030_全字段
    ...    ELSE IF    '${数据名称}'=='委托前_融资融券协议信息_10321004_全字段'    Set Variable    融资融券协议信息_10321004_全字段
    ...    ELSE IF    '${数据名称}'=='委托前_FISL_FINANCE_SUM_融资合约汇总信息_全字段'    Set Variable    FISL_FINANCE_SUM_融资合约汇总信息_全字段
    ...    ELSE IF    '${数据名称}'=='委托前_FISL_AGREEMENT_融资融券协议信息_全字段'    Set Variable    FISL_AGREEMENT_融资融券协议信息_全字段
    ...    ELSE IF    '${数据名称}'=='委托前_可用资金_10303001_全接口字段'    Set Variable    可用资金_10303001_全接口字段
    ...    ELSE IF    '${数据名称}'=='委托前_可用股份_10303002_全接口字段'    Set Variable    可用股份_10303002_全接口字段
    ...    ELSE IF    '${数据名称}'=='委托前_CUACCT_FUND全表字段'    Set Variable    CUACCT_FUND全表字段
    ...    ELSE IF    '${数据名称}'=='委托前_STK_ASSET全表字段'    Set Variable    STK_ASSET全表字段
    ...    ELSE IF    '${数据名称}'=='委托前_客户负债查询_10323006_全字段'    Set Variable    客户负债查询_10323006_全字段
    ...    ELSE IF    '${数据名称}'=='委托前_资金头寸查询_10323008_全字段'    Set Variable    资金头寸查询_10323008_全字段
    ...    ELSE IF    '${数据名称}'=='委托前_股份头寸查询_10323009_全字段'    Set Variable    股份头寸查询_10323009_全字段
    ...    ELSE IF    '${数据名称}'=='委托前_FISL_CORP_CASH_全字段'    Set Variable    FISL_CORP_CASH_全字段
    ...    ELSE IF    '${数据名称}'=='委托前_FISL_CORP_ASSET_全字段'    Set Variable    FISL_CORP_ASSET_全字段
    ...    ELSE IF    '${数据名称}'=='委托前_FISL_REPAY_DETAIL'    Set Variable    FISL_REPAY_DETAIL
    ...    ELSE IF    '${数据名称}'=='委托前_FISL_FEE_SUM_全字段'    Set Variable    FISL_FEE_SUM_全字段
    ...    ELSE IF    '${数据名称}'=='委托前_实时偿还明细_10321012'    Set Variable    实时偿还明细_10321012
    ${委托字段}    Run Keyword If    '${接口类型}'=='Fis'    金证_录制字段    ${数据名称A}
    log    ---接口数据处理---
    log    ${委托字段}
    ${字段key}    ${字段values}    总对总字段与值建立成字典_取值录制模式    ${委托字段}
    ${接口返回信息}    Run Keyword If    '${数据名称}' in ('委托前_实时偿还明细_10321012','委托前_股份头寸查询_10323009_全字段','委托前_资金头寸查询_10323008_全字段','委托前_客户负债查询_10323006_全字段','委托前_可用股份_10303002_全接口字段','委托前_融资融券协议信息_10321004_全字段','委托前_可用资金_10303001_全接口字段','委托前_融券合约汇总信息_10323031_全字段','委托前_融资合约汇总信息_10323030_全字段')    查询接口与表数据进行格式处理_录制模式    ${返回信息}    ${字段key}    YES
    log    ---表数据---
    log    ${数据名称}
    ${查询表结果}    Run Keyword If    '${数据名称}' in ('委托前_FISL_FEE_SUM_全字段','委托前_FISL_REPAY_DETAIL','委托前_FISL_CORP_ASSET_全字段','委托前_FISL_CORP_CASH_全字段','委托前_STK_ASSET全表字段','委托前_CUACCT_FUND全表字段','委托前_FISL_FINANCE_SUM_融资合约汇总信息_全字段','委托前_FISL_AGREEMENT_融资融券协议信息_全字段')    总对总检查_表查询    ${数据名称}    ${委托字段}
    ${type}    Evaluate    isinstance($查询表结果, list)
    ${按精度处理数据}    Run Keyword If    '${type}'=='True'    取值录制精度处理    ${查询表结果}
    ${查询表结果}    Run Keyword If    '${type}'=='True'and '${int}'=='1'    Set Variable    ${按精度处理数据}
    ...    ELSE IF    '${type}'!='True'or '${int}'=='0'    Set Variable    ${查询表结果}
    log    ${数据名称}
    ${len}    Run Keyword If    '${数据名称}' in ('委托前_FISL_FEE_SUM_全字段','委托前_FISL_REPAY_DETAIL','委托前_FISL_CORP_ASSET_全字段','委托前_FISL_CORP_CASH_全字段','委托前_STK_ASSET全表字段','委托前_CUACCT_FUND全表字段','委托前_FISL_FINANCE_SUM_融资合约汇总信息_全字段','委托前_FISL_AGREEMENT_融资融券协议信息_全字段')    Get Length    ${查询表结果}
    log    ${数据名称}
    ${表结果处理}    Run Keyword If    '${数据名称}'in ('委托前_FISL_FEE_SUM_全字段','委托前_FISL_REPAY_DETAIL','委托前_FISL_CORP_ASSET_全字段','委托前_FISL_CORP_CASH_全字段','委托前_STK_ASSET全表字段','委托前_CUACCT_FUND全表字段','委托前_FISL_FINANCE_SUM_融资合约汇总信息_全字段','委托前_FISL_AGREEMENT_融资融券协议信息_全字段')    查询接口与表数据进行格式处理_录制模式    ${查询表结果}
    ${表结果}    Run Keyword If    '${len}'>'0'    Set Variable    ${表结果处理}
    ...    ELSE IF    '${len}'=='0'    Set Variable    无记录;
    log    ${表结果}
    ${数据处理结果}    Set Variable If    '${数据名称}' in ('委托前_实时偿还明细_10321012','委托前_股份头寸查询_10323009_全字段','委托前_资金头寸查询_10323008_全字段','委托前_客户负债查询_10323006_全字段','委托前_可用股份_10303002_全接口字段','委托前_融资融券协议信息_10321004_全字段','委托前_可用资金_10303001_全接口字段','委托前_融券合约汇总信息_10323031_全字段','委托前_融资合约汇总信息_10323030_全字段')    ${接口返回信息}    ${表结果}
    log    ${数据处理结果}
    [Return]    ${数据处理结果}

查询接口与表全录制的通用流程
    [Arguments]    ${数据名称}    ${接口类型}=${接口类型_全局变量}
    [Documentation]    1.20211123 chm 新增
    FOR    ${i}    IN    @{数据名称}
        ${名称}    Set Variable    ${i}
        ${i}    Run Keyword If    '${i}'=='委托后_融券合约汇总信息_10323031_全字段'    Set Variable    融券合约汇总查询_10323031
        ...    ELSE IF    '${i}'=='委托后_融资合约汇总信息_10323030_全字段'    Set Variable    融资合约汇总查询_10323030
        ...    ELSE IF    '${i}'=='委托后_融资融券协议信息_10321004_全字段'    Set Variable    融资融券协议查询_10321004
        ...    ELSE IF    '${i}'=='委托后_可用资金_10303001_全接口字段'    Set Variable    可用资金查询_10303001
        ...    ELSE IF    '${i}'=='委托后_可用股份_10303002_全接口字段'    Set Variable    可用股份查询_10303002
        ...    ELSE IF    '${i}'=='委托后_客户负债查询_10323006_全字段'    Set Variable    客户负债查询_10323006
        ...    ELSE IF    '${i}'=='委托后_资金头寸查询_10323008_全字段'    Set Variable    资金头寸查询_10323008
        ...    ELSE IF    '${i}'=='委托后_股份头寸查询_10323009_全字段'    Set Variable    股份头寸查询_10323009
        ...    ELSE IF    '${i}'=='委托后_实时偿还明细_10321012'    Set Variable    实时偿还明细_10321012
        ...    ELSE    Set Variable    ${i}
        ${返回码}    ${返回信息}    Run Keyword If    '${i}'in ('实时偿还明细_10321012','股份头寸查询_10323009','资金头寸查询_10323008','客户负债查询_10323006','融资融券协议查询_10321004','融资合约汇总查询_10323030','融券合约汇总查询_10323031','可用资金查询_10303001','可用股份查询_10303002')    ${i}
        ${返回信息_条数}    Run Keyword If    '${i}' in ('实时偿还明细_10321012','股份头寸查询_10323009','资金头寸查询_10323008','客户负债查询_10323006','融资融券协议查询_10321004','融资合约汇总查询_10323030','融券合约汇总查询_10323031','可用资金查询_10303001')    Get Length    ${返回信息}
        ...    ELSE    Set Variable    1
        ${排序字段}    Run Keyword If    '${i}' in ('客户负债查询_10323006','融资融券协议查询_10321004','融资合约汇总查询_10323030','融券合约汇总查询_10323031','可用资金查询_10303001','可用股份查询_10303002')    Set Variable    CUACCT_CODE
        ...    ELSE IF    '${i}' in ('可用股份查询_10303002','股份头寸查询_10323009')    Set Variable    STK_CODE
        ...    ELSE IF    '${i}' in ('资金头寸查询_10323008')    Set Variable    CURRENCY
        ...    ELSE IF    '${i}' in ('实时偿还明细_10321012')    Set Variable    SNO
        ${返回信息}    Run Keyword If    '${i}' in ('实时偿还明细_10321012','股份头寸查询_10323009','资金头寸查询_10323008','客户负债查询_10323006','融资融券协议查询_10321004','融资合约汇总查询_10323030','融券合约汇总查询_10323031','可用资金查询_10303001','可用股份查询_10303002') and '${返回信息_条数}'>'0'    接口数据排序    ${返回信息}    ${排序字段}
        ...    ELSE    Set Variable    ${返回信息}
        ${type}    Evaluate    isinstance($返回信息, list)
        ${按精度处理数据}    Run Keyword If    '${type}'=='True'    取值录制精度处理    ${返回信息}
        ${返回信息}    Run Keyword If    '${type}'=='True'and '${int}'=='1'    Set Variable    ${按精度处理数据}
        ...    ELSE IF    '${type}'!='True'or '${int}'=='0'    Set Variable    ${返回信息}
        log    ${返回信息}
        LOG    ${i}
        ${i}    Set Variable    ${名称}
        ${数据处理结果}    Run Keyword If    '${返回信息_条数}'>'0'    委托后总对总接口与表处理_录制模式    ${i}    ${返回信息}
        ...    ELSE IF    '${返回信息_条数}'=='0'    Set Variable    无查询结果;
        comment    #接口数据写入表中
        ${比对结果}    数据写入表_录制模式    ${i}    ${数据处理结果}
        ${执行结果}    Run Keyword If    '${比对结果}'=='0'    Set Variable    校验通过
        ...    ELSE IF    '${比对结果}'=='1'    Set Variable    核对${i}表不正确，核对SQL：select * from ddxt_test_rfautotest_data_log where TESTCASE_ID='${TEST_NAME}' order by test_date desc
        ...    ELSE IF    '${比对结果}'=='2'    Set Variable    ${i}字段有新增，基准数据需要增加新字段内容，请核查
        Run Keyword And Continue On Failure    Should Be Equal As Strings    ${比对结果}    0    ${执行结果}    #0校验通过，1表示校验不通过
    END

委托后总对总接口与表处理_录制模式
    [Arguments]    ${数据名称}    ${返回信息}    ${接口类型}=${接口类型_全局变量}
    [Documentation]    1.20211123 chm 新增
    log    ${数据名称}
    ${i}    Set Variable    ${数据名称}
    ${数据名称}    Run Keyword If    '${i}'=='委托后_融券合约汇总信息_10323031_全字段'    Set Variable    融券合约汇总信息_10323031_全字段
    ...    ELSE IF    '${i}'=='委托后_融资合约汇总信息_10323030_全字段'    Set Variable    融资合约汇总信息_10323030_全字段
    ...    ELSE IF    '${i}'=='委托后_融资融券协议信息_10321004_全字段'    Set Variable    融资融券协议信息_10321004_全字段
    ...    ELSE IF    '${i}'=='委托后_可用资金_10303001_全接口字段'    Set Variable    可用资金_10303001_全接口字段
    ...    ELSE IF    '${i}'=='委托后_可用股份_10303002_全接口字段'    Set Variable    可用股份_10303002_全接口字段
    ...    ELSE IF    '${i}'=='委托后_客户负债查询_10323006_全字段'    Set Variable    客户负债查询_10323006_全字段
    ...    ELSE IF    '${i}'=='委托后_资金头寸查询_10323008_全字段'    Set Variable    资金头寸查询_10323008_全字段
    ...    ELSE IF    '${i}'=='委托后_股份头寸查询_10323009_全字段'    Set Variable    股份头寸查询_10323009_全字段
    ...    ELSE IF    '${i}'=='委托后_FISL_FINANCE_SUM_融资合约汇总信息_全字段'    Set Variable    FISL_FINANCE_SUM_融资合约汇总信息_全字段
    ...    ELSE IF    '${i}'=='委托后_FISL_AGREEMENT_融资融券协议信息_全字段'    Set Variable    FISL_AGREEMENT_融资融券协议信息_全字段
    ...    ELSE IF    '${i}'=='委托后_CUACCT_FUND全表字段'    Set Variable    CUACCT_FUND全表字段
    ...    ELSE IF    '${i}'=='委托后_STK_ASSET全表字段'    Set Variable    STK_ASSET全表字段
    ...    ELSE IF    '${i}'=='委托后_FISL_CORP_CASH_全字段'    Set Variable    FISL_CORP_CASH_全字段
    ...    ELSE IF    '${i}'=='委托后_FISL_CORP_ASSET_全字段'    Set Variable    FISL_CORP_ASSET_全字段
    ...    ELSE IF    '${i}'=='委托后_FISL_REPAY_DETAIL'    Set Variable    FISL_REPAY_DETAIL
    ...    ELSE IF    '${i}'=='委托后_FISL_FEE_SUM_全字段'    Set Variable    FISL_FEE_SUM_全字段
    ...    ELSE IF    '${i}'=='委托后_实时偿还明细_10321012'    Set Variable    实时偿还明细_10321012
    ${委托字段}    Run Keyword If    '${接口类型}'=='Fis'    金证_录制字段    ${数据名称}
    log    ---接口数据处理---
    ${字段key}    ${字段values}    字段与值建立成字典_取值计算录制模式    ${委托字段}
    ${接口返回信息}    Run Keyword If    '${i}' in ('委托后_实时偿还明细_10321012','委托后_融券合约汇总信息_10323031_全字段','委托后_融资合约汇总信息_10323030_全字段','委托后_融资融券协议信息_10321004_全字段','委托后_可用资金_10303001_全接口字段','委托后_可用股份_10303002_全接口字段','委托后_客户负债查询_10323006_全字段','委托后_资金头寸查询_10323008_全字段','委托后_股份头寸查询_10323009_全字段')    查询接口与表数据进行格式处理_录制模式    ${返回信息}    ${字段key}    YES
    log    ---表数据---
    ${查询表结果}    Run Keyword If    '${i}' in ('委托后_FISL_FEE_SUM_全字段','委托后_FISL_REPAY_DETAIL','委托后_FISL_FINANCE_SUM_融资合约汇总信息_全字段','委托后_FISL_AGREEMENT_融资融券协议信息_全字段','委托后_CUACCT_FUND全表字段','委托后_STK_ASSET全表字段','委托后_FISL_CORP_CASH_全字段','委托后_FISL_CORP_ASSET_全字段')    总对总检查_表查询    ${数据名称}    ${委托字段}
    ${type}    Evaluate    isinstance($查询表结果, list)
    ${按精度处理数据}    Run Keyword If    '${type}'=='True'    取值录制精度处理    ${查询表结果}
    ${查询表结果}    Run Keyword If    '${type}'=='True'and '${int}'=='1'    Set Variable    ${按精度处理数据}
    ...    ELSE IF    '${type}'!='True'or '${int}'=='0'    Set Variable    ${查询表结果}
    ${len}    Run Keyword If    '${i}' in ('委托后_FISL_FEE_SUM_全字段','委托后_FISL_REPAY_DETAIL','委托后_FISL_FINANCE_SUM_融资合约汇总信息_全字段','委托后_FISL_AGREEMENT_融资融券协议信息_全字段','委托后_CUACCT_FUND全表字段','委托后_STK_ASSET全表字段','委托后_FISL_CORP_CASH_全字段','委托后_FISL_CORP_ASSET_全字段')    Get Length    ${查询表结果}
    ${表结果处理}    Run Keyword If    '${i}' in ('委托后_FISL_FEE_SUM_全字段','委托后_FISL_REPAY_DETAIL','委托后_FISL_FINANCE_SUM_融资合约汇总信息_全字段','委托后_FISL_AGREEMENT_融资融券协议信息_全字段','委托后_CUACCT_FUND全表字段','委托后_STK_ASSET全表字段','委托后_FISL_CORP_CASH_全字段','委托后_FISL_CORP_ASSET_全字段')    查询接口与表数据进行格式处理_录制模式    ${查询表结果}
    ${表结果}    Run Keyword If    '${len}'>'0'    Set Variable    ${表结果处理}
    ...    ELSE IF    '${len}'=='0'    Set Variable    无记录;
    log    ${表结果}
    ${数据处理结果}    Set Variable If    '${数据名称}' in ('实时偿还明细_10321012','委托后_FISL_FEE_SUM_全字段','委托后_FISL_REPAY_DETAIL','融券合约汇总信息_10323031_全字段','融资合约汇总信息_10323030_全字段','融资融券协议信息_10321004_全字段','可用资金_10303001_全接口字段','可用股份_10303002_全接口字段','客户负债查询_10323006_全字段','资金头寸查询_10323008_全字段','股份头寸查询_10323009_全字段','委托后_FISL_FINANCE_SUM_融资合约汇总信息_全字段','委托后_FISL_AGREEMENT_融资融券协议信息_全字段','委托后_CUACCT_FUND全表字段','委托后_STK_ASSET全表字段','委托后_FISL_CORP_CASH_全字段','委托后_FISL_CORP_ASSET_全字段')    ${接口返回信息}    ${表结果}
    log    ${数据处理结果}
    [Return]    ${数据处理结果}
