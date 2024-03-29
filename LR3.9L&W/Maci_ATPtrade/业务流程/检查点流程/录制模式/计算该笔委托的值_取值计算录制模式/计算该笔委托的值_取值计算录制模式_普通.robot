*** Settings ***
Resource          ../../../../公共目录/通用操作/数据库操作.robot
Resource          ../../../../公共目录/通用操作/常用关键字.robot
Resource          ../../../../业务流程/检查点流程/录制模式/接口与表_录制模式/接口与表_录制模式_公共.robot
Resource          ../../../../业务流程/检查点流程/录制模式/接口与表_录制模式/接口与表_录制模式_普通.robot

*** Keywords ***
接口/表取值流程_取值计算录制模式
    [Arguments]    ${变化数据名称}
    [Documentation]    1.20211123 chm 新增
    ${字段提取_需计算}    Set Variable
    ${字段提取_无需计算}    Set Variable
    log    ${变化数据名称}
    FOR    ${i}    IN    @{变化数据名称}
        log    ${i}
        LOG    -----接口    #ReqFundQuery_资金查询    ReqShareQuery_股份查询
        ${返回码}    ${返回信息}    Run Keyword If    '${i}' in ('可用资金查询_10303001','可用资金查询_10303001','可用股份查询_10303002','资金头寸查询_10323008','股份头寸查询_10323009','融券合约汇总查询_10323031','融资合约汇总查询_10323030','客户负债查询_10323006')    ${i}
        ${字段计算差值_接口}    ${字段无需计算_接口}    Run Keyword If    ${返回信息} != [] and '${i}' in ('可用资金查询_10303001','可用股份查询_10303002','资金头寸查询_10323008','股份头寸查询_10323009','融券合约汇总查询_10323031','融资合约汇总查询_10323030','客户负债查询_10323006')    提取接口字段_取值录制模式    ${i}    ${返回信息}
        ...    ELSE IF    ${返回信息} == [] and'${i}' in ('可用资金查询_10303001','可用股份查询_10303002','资金头寸查询_10323008','股份头寸查询_10323009','融券合约汇总查询_10323031','融资合约汇总查询_10323030','客户负债查询_10323006')    提取接口字段_取值录制模式中接口返回空数据处理    ${i}    ${返回信息}
        ${字段计算差值_表}    ${字段无需计算_表}    Run Keyword If    '${i}' in ('CUACCT_FUND','FISL_FEE_SUM','STK_ASSET','FISL_CORP_CASH','FISL_CORP_ASSET','FISL_SECULOAN_SUM','FISL_FINANCE_SUM')    提取表字段_取值录制模式    ${i}
        LOG    -----转换
        ${计算}    Set Variable IF    '${i}' in ('可用资金查询_10303001','可用股份查询_10303002','资金头寸查询_10323008','股份头寸查询_10323009','融券合约汇总查询_10323031','融资合约汇总查询_10323030','客户负债查询_10323006')    ${字段计算差值_接口}    ${字段计算差值_表}
        ${无计算}    Set Variable IF    '${i}' in ('可用资金查询_10303001','可用股份查询_10303002','资金头寸查询_10323008','股份头寸查询_10323009','融券合约汇总查询_10323031','融资合约汇总查询_10323030','客户负债查询_10323006')    ${字段无需计算_接口}    ${字段无需计算_表}
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
