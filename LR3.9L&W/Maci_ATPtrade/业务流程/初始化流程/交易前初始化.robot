*** Settings ***
Resource          ../../公共目录/配置信息/环境连接.robot
Resource          ../../公共目录/配置信息/业务数据获取.robot
Resource          ../../订单接口/3.实时查询.robot
Resource          ../../订单接口/1.参数管理.robot
Resource          ../../订单接口/2.实时交易.robot
Resource          ../../订单接口/4.辅助功能.robot
Resource          ../../订单接口/LBM查询接口.robot
Resource          ../检查点流程/交易前表的录制流程.robot
Resource          ../../公共目录/通用操作/价格撮合操作.robot
Resource          ../../公共目录/通用操作/接口查询操作.robot
Resource          ../../公共目录/通用操作/固定参数设置.robot

*** Keywords ***
交易前初始化
    用户登录_10301105
    货币代码参数
    Run KeyWord IF    '${证券业务_全局变量}'in ('701','700','708','709','982','983')    担保品证券信息查询_10321010
    证券市值额度查询_10301034
    股东账户查询_10303005
    Run KeyWord If    '${证券业务_全局变量}'in ('702','703','704','705','710')    头寸查询
    Run KeyWord If    '${证券业务_全局变量}'in ('702','703','704','705','710')    合约查询
    Run KeyWord If    '${证券业务_全局变量}'in ('702','703','704','705','710')    合约类型参数
    Run KeyWord If    '${证券业务_全局变量}'!='直接还款'    查询证券信息
    Run KeyWord If    '${证券业务_全局变量}'!='直接还款'    委托价格_设置全局变量
    Run KeyWord If    '${证券业务_全局变量}'!='直接还款'and '${证券业务_全局变量}'in ('702','703','704','705','710')    买卖_交易前表A录制
    ...    ELSE IF    '${证券业务_全局变量}'!='直接还款'and '${证券业务_全局变量}'in ('700','701','708','709','982','983')    担保品买卖_交易前表A录制
    ${委托前录制数据}    Run KeyWord If    '${证券业务_全局变量}'in ('702','703','704','705','710')    Create List    委托前_融券合约汇总信息_10323031_全字段    委托前_融资合约汇总信息_10323030_全字段    委托前_融资融券协议信息_10321004_全字段    委托前_FISL_FINANCE_SUM_融资合约汇总信息_全字段    委托前_FISL_AGREEMENT_融资融券协议信息_全字段    委托前_可用资金_10303001_全接口字段    委托前_可用股份_10303002_全接口字段    委托前_CUACCT_FUND全表字段    委托前_STK_ASSET全表字段    委托前_客户负债查询_10323006_全字段    委托前_资金头寸查询_10323008_全字段    委托前_股份头寸查询_10323009_全字段    委托前_FISL_CORP_CASH_全字段
    ...    委托前_FISL_CORP_ASSET_全字段
    ...    ELSE IF    '${证券业务_全局变量}'in ('700','701','708','709','982','983')    Create List    委托前_融券合约汇总信息_10323031_全字段    委托前_融资合约汇总信息_10323030_全字段    委托前_融资融券协议信息_10321004_全字段    委托前_FISL_FINANCE_SUM_融资合约汇总信息_全字段    委托前_FISL_AGREEMENT_融资融券协议信息_全字段    委托前_可用资金_10303001_全接口字段    委托前_可用股份_10303002_全接口字段    委托前_CUACCT_FUND全表字段    委托前_STK_ASSET全表字段    委托前_客户负债查询_10323006_全字段
    Run Keyword And Continue On Failure    查询接口与表委托前全录制的通用    ${委托前录制数据}

头寸查询
    run KeyWord and continue on failure    信用客户头寸信息查询
    run KeyWord and continue on failure    资金头寸信息查询
    run KeyWord and continue on failure    股份头寸信息查询
    ${变化数据}    create list    资金头寸查询_10323008    股份头寸查询_10323009    FISL_CORP_CASH    FISL_CORP_ASSET
    ${字段提取_需计算_委托前_全局变量}    ${字段提取_无需计算_委托前}    接口/表取值流程_取值计算录制模式    ${变化数据}
    #Set Global Variable    ${字段提取_需计算_委托前_全局变量}
    log    ${字段提取_需计算_委托前_全局变量}

合约查询
    run KeyWord and continue on failure    融券合约汇总查询
    run KeyWord and continue on failure    融资合约汇总查询
    ${变化数据}    create list    融券合约汇总查询_10323031    融资合约汇总查询_10323030    FISL_SECULOAN_SUM    FISL_FINANCE_SUM
    ${字段提取_需计算_委托前_全局变量}    ${字段提取_无需计算_委托前}    接口/表取值流程_取值计算录制模式    ${变化数据}
    #Set Global Variable    ${字段提取_需计算_委托前_全局变量}
    log    ${字段提取_需计算_委托前_全局变量}

直接还款交易前初始化
    用户登录_10301105
    直接还款_交易前表A录制
    ${委托前录制数据}    Create List    委托前_CUACCT_FUND全表字段    委托前_可用资金_10303001_全接口字段    委托前_FISL_REPAY_DETAIL    委托前_FISL_FEE_SUM_全字段    委托前_实时偿还明细_10321012
    Run Keyword And Continue On Failure    查询接口与表委托前全录制的通用    ${委托前录制数据}
