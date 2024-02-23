*** Settings ***
Resource          ../../业务流程/检查点流程/录制模式/计算该笔委托的值_取值计算录制模式/计算该笔委托的值_取值计算录制模式_公共.robot
Resource          ../../业务流程/检查点流程/录制模式/计算该笔委托的值_取值计算录制模式/计算该笔委托的值_取值计算录制模式_普通.robot
Resource          ../../业务流程/检查点流程/录制模式/接口与表_比对模式/接口与表_比对模式_公共.robot
Resource          ../../业务流程/检查点流程/录制模式/接口与表_比对模式/接口与表_比对模式_普通.robot
Resource          ../../业务流程/检查点流程/录制模式/接口与表_录制模式/接口与表_录制模式_公共.robot
Resource          ../../业务流程/检查点流程/录制模式/接口与表_录制模式/接口与表_录制模式_普通.robot

*** Keywords ***
普通买卖检查流程
    Run KeyWord If    '${证券业务_全局变量}'in ('702','703','704','705','710')    SLEEP    3
    log    ----------比对
    ${变化数据}    Run KeyWord If    '${证券业务_全局变量}'in ('702','703','704','705','710')    Create List    可用资金查询_10303001    可用股份查询_10303002    资金头寸查询_10323008    股份头寸查询_10323009    融券合约汇总查询_10323031    融资合约汇总查询_10323030    客户负债查询_10323006    CUACCT_FUND    STK_ASSET    FISL_CORP_CASH    FISL_CORP_ASSET    FISL_SECULOAN_SUM    FISL_FINANCE_SUM
    ...    ELSE IF    '${证券业务_全局变量}'in ('700','701','708','709','982','983')    Create List    可用资金查询_10303001    可用股份查询_10303002    客户负债查询_10323006    CUACCT_FUND    STK_ASSET
    Run Keyword And Continue On Failure    查询接口与表取值计算录制的通用流程    ${变化数据}
    log    ----------取值录制
    ${录制数据}    Run KeyWord If    '${证券业务_全局变量}'in ('702','703','704','705','710')    Create List    当日委托查询_10303003    当日成交查询_10303004    融资融券合约_10323001    STK_ORDER    STK_MATCHING    FISL_CONTRACT
    ...    ELSE IF    '${证券业务_全局变量}'in ('700','701','708','709','982','983')    Create List    当日委托查询_10303003    当日成交查询_10303004    STK_ORDER    STK_MATCHING
    Run Keyword And Continue On Failure    查询接口与表取值录制的通用流程    ${录制数据}
    ${录制全数据}    Run KeyWord If    '${证券业务_全局变量}'in ('702','703','704','705','710')    Create List    委托后_融券合约汇总信息_10323031_全字段    委托后_融资合约汇总信息_10323030_全字段    委托后_融资融券协议信息_10321004_全字段    委托后_FISL_FINANCE_SUM_融资合约汇总信息_全字段    委托后_FISL_AGREEMENT_融资融券协议信息_全字段    委托后_可用资金_10303001_全接口字段    委托后_可用股份_10303002_全接口字段    委托后_CUACCT_FUND全表字段    委托后_STK_ASSET全表字段    委托后_客户负债查询_10323006_全字段    委托后_资金头寸查询_10323008_全字段    委托后_股份头寸查询_10323009_全字段    委托后_FISL_CORP_CASH_全字段
    ...    委托后_FISL_CORP_ASSET_全字段
    ...    ELSE IF    '${证券业务_全局变量}'in ('700','701','708','709','982','983')    Create List    委托后_融券合约汇总信息_10323031_全字段    委托后_融资合约汇总信息_10323030_全字段    委托后_融资融券协议信息_10321004_全字段    委托后_FISL_FINANCE_SUM_融资合约汇总信息_全字段    委托后_FISL_AGREEMENT_融资融券协议信息_全字段    委托后_可用资金_10303001_全接口字段    委托后_可用股份_10303002_全接口字段    委托后_CUACCT_FUND全表字段    委托后_STK_ASSET全表字段    委托后_客户负债查询_10323006_全字段
    Run Keyword And Continue On Failure    查询接口与表全录制的通用流程    ${录制全数据}

直接还款检查流程
    ${变化数据}    Create List    可用资金查询_10303001    CUACCT_FUND    FISL_FEE_SUM
    Run Keyword And Continue On Failure    查询接口与表取值计算录制的通用流程    ${变化数据}
    ${录制全数据}    Create List    委托后_可用资金_10303001_全接口字段    委托后_CUACCT_FUND全表字段    委托后_FISL_FEE_SUM_全字段    委托后_FISL_REPAY_DETAIL    委托后_实时偿还明细_10321012
    Run Keyword And Continue On Failure    查询接口与表全录制的通用流程    ${录制全数据}
    ${录制偿还明细数据}    Create List    FISL_CONTRACT
    Run Keyword And Continue On Failure    查询接口与表取值录制的通用流程    ${录制偿还明细数据}
