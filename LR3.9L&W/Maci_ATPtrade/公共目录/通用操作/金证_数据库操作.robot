*** Settings ***
Resource          常用关键字.robot

*** Keywords ***
金证_买卖委托表数据查询
    [Arguments]    ${字段名称key}    ${字段名称values}    ${接口或表名称}    ${字段名称}    ${Status}    ${客户信息}=${客户信息_全局变量}    ${证券业务}=${证券业务_全局变量}
    ${处理字符}    Create Dictionary    [=${EMPTY}    ]=${EMPTY}    '=${EMPTY}    :=${EMPTY}
    ${字段名称}    Run Keyword If    '${接口或表名称}'not in ('CUACCT_FUND','STK_ASSET','STK_ORDER','STK_MATCHING','FISL_CORP_CASH','FISL_CORP_ASSET','FISL_CONTRACT','FISL_SECULOAN_SUM','FISL_FINANCE_SUM','FISL_FEE_SUM') and'${Status}'=='FAIL'    Set Variable    ${字段名称values}
    ...    ELSE    Set Variable    ${字段名称key}
    ${字段名称}    字符串处理    ${字段名称}    ${处理字符}
    #查询条件
    log    ${客户信息['STKPBU']}
    ${条件}    Run Keyword If    '${接口或表名称}'in ('可用资金查询_10303001','CUACCT_FUND')    Set Variable    CUACCT_CODE='${资金账户_全局变量}' and CURRENCY='${货币代码_全局变量}' ORDER BY CURRENCY
    ...    ELSE IF    '${接口或表名称}' in ('可用股份查询_10303002','STK_ASSET')    Set Variable    CUACCT_CODE='${资金账户_全局变量}' and CURRENCY='${货币代码_全局变量}' and STK_CODE ='${证券代码_全局变量}' and \ STKPBU = '${客户信息['STKPBU']}' ORDER BY STK_CODE
    ...    ELSE IF    '${接口或表名称}'in ('当日委托查询_10303003','STK_ORDER')    Set Variable    CUACCT_CODE='${资金账户_全局变量}' and ORDER_ID='${合同序号_全局变量}'or RAW_ORDER_ID='${合同序号_全局变量}' ORDER BY STK_CODE
    ...    ELSE IF    '${接口或表名称}' in ('当日成交查询_10303004','STK_MATCHING')    Set Variable    CUACCT_CODE='${资金账户_全局变量}' and ORDER_ID='${合同序号_全局变量}' \ ORDER BY QUERY_POS
    ...    ELSE IF    '${接口或表名称}' in ('资金头寸查询_10323008','FISL_CORP_CASH')    Set Variable    CASH_NO='${头寸编号_全局变量}' and CURRENCY='${货币代码_全局变量}' ORDER BY CURRENCY
    ...    ELSE IF    '${接口或表名称}' in ('股份头寸查询_10323009','FISL_CORP_ASSET')    Set Variable    CASH_NO='${头寸编号_全局变量}' and STK_CODE ='${证券代码_全局变量}' ORDER BY STK_CODE
    ...    ELSE IF    '${接口或表名称}' in ('融资融券合约_10323001','FISL_CONTRACT') and '${证券业务}' in('702','703','直接还款')    Set Variable    CUACCT_CODE='${资金账户_全局变量}' and CONTRACT_TYPE in ('${合约类型_全局变量}') and ORDER_ID='${合同序号_全局变量}' ORDER BY ORDER_ID
    ...    ELSE IF    '${接口或表名称}' in ('融资融券合约_10323001','FISL_CONTRACT') and '${证券业务}' in('704','705','710')    Set Variable    CUACCT_CODE='${资金账户_全局变量}' and CONTRACT_TYPE='${合约类型_全局变量}' and STK_CODE ='${证券代码_全局变量}' ORDER BY ORDER_ID
    ...    ELSE IF    '${接口或表名称}' in ('融券合约汇总查询_10323031','FISL_SECULOAN_SUM')    Set Variable    CUACCT_CODE='${资金账户_全局变量}' and STK_CODE ='${证券代码_全局变量}' ORDER BY STK_CODE
    ...    ELSE IF    '${接口或表名称}' in ('融资合约汇总查询_10323030','FISL_FINANCE_SUM')    Set Variable    CUACCT_CODE='${资金账户_全局变量}' and STK_CODE ='${证券代码_全局变量}' ORDER BY STK_CODE
    ...    ELSE IF    '${接口或表名称}' in ('FISL_FEE_SUM')    Set Variable    CUACCT_CODE='${资金账户_全局变量}'
    ...    ELSE IF    '${接口或表名称}' in ('委托后_FISL_REPAY_DETAIL','委托前_FISL_REPAY_DETAIL','实时偿还明细_10321012','FISL_REPAY_DETAIL')    Set Variable    CUACCT_CODE='${资金账户_全局变量}' and TRD_DATE='${交易时间_全局变量}' ORDER BY TRD_DATE
    #表
    ${表名}    Run Keyword If    '${接口或表名称}'=='可用资金查询_10303001'    Set Variable    CUACCT_FUND
    ...    ELSE IF    '${接口或表名称}' =='可用股份查询_10303002'    Set Variable    STK_ASSET
    ...    ELSE IF    '${接口或表名称}' =='当日委托查询_10303003'    Set Variable    STK_ORDER
    ...    ELSE IF    '${接口或表名称}' =='当日成交查询_10303004'    Set Variable    STK_MATCHING
    ...    ELSE IF    '${接口或表名称}' =='资金头寸查询_10323008'    Set Variable    FISL_CORP_CASH
    ...    ELSE IF    '${接口或表名称}' =='股份头寸查询_10323009'    Set Variable    FISL_CORP_ASSET
    ...    ELSE IF    '${接口或表名称}' =='融资融券合约_10323001'    Set Variable    FISL_CONTRACT
    ...    ELSE IF    '${接口或表名称}' =='融券合约汇总查询_10323031'    Set Variable    FISL_SECULOAN_SUM
    ...    ELSE IF    '${接口或表名称}' =='融资合约汇总查询_10323030'    Set Variable    FISL_FINANCE_SUM
    ...    ELSE IF    '${接口或表名称}' =='实时偿还明细_10321012'    Set Variable    FISL_REPAY_DETAIL
    ...    ELSE    Set Variable    ${接口或表名称}
    [Return]    ${字段名称}    ${表名}    ${条件}

总对总表数据查询
    [Arguments]    ${字段名称key}    ${字段名称values}    ${接口或表名称}    ${字段名称}    ${Status}    ${客户信息}=${客户信息_全局变量}    ${证券业务}=${证券业务_全局变量}
    ${处理字符}    Create Dictionary    [=${EMPTY}    ]=${EMPTY}    '=${EMPTY}    :=${EMPTY}
    ${字段名称}    Run Keyword If    '${接口或表名称}'not in ('CUACCT_FUND','STK_ASSET','STK_ORDER','STK_MATCHING','FISL_CORP_CASH','FISL_CORP_ASSET','FISL_CONTRACT','FISL_SECULOAN_SUM','FISL_FINANCE_SUM') and'${Status}'=='FAIL'    Set Variable    ${字段名称values}
    ...    ELSE    Set Variable    ${字段名称key}
    ${字段名称}    字符串处理    ${字段名称}    ${处理字符}
    #查询条件
    log    ${客户信息['STKPBU']}
    ${条件}    Run Keyword If    '${接口或表名称}'in ('可用资金查询_10303001','CUACCT_FUND','委托前_CUACCT_FUND全表字段','CUACCT_FUND全表字段')    Set Variable    CUACCT_CODE='${资金账户_全局变量}' and CURRENCY='${货币代码_全局变量}' ORDER BY CURRENCY
    ...    ELSE IF    '${接口或表名称}' in ('可用股份查询_10303002','STK_ASSET','委托前_STK_ASSET全表字段','STK_ASSET全表字段')    Set Variable    CUACCT_CODE='${资金账户_全局变量}' and CURRENCY='${货币代码_全局变量}' and STK_CODE ='${证券代码_全局变量}' and \ STKPBU = '${客户信息['STKPBU']}' ORDER BY STK_CODE
    ...    ELSE IF    '${接口或表名称}' in ('当日委托查询_10303003','STK_ORDER')    Set Variable    CUACCT_CODE='${资金账户_全局变量}' and ORDER_ID='${合同序号_全局变量}'or RAW_ORDER_ID='${合同序号_全局变量}' ORDER BY STK_CODE
    ...    ELSE IF    '${接口或表名称}' in ('当日成交查询_10303004','STK_MATCHING')    Set Variable    CUACCT_CODE='${资金账户_全局变量}' and ORDER_ID='${合同序号_全局变量}' \ ORDER BY QUERY_POS
    ...    ELSE IF    '${接口或表名称}' in ('资金头寸查询_10323008','FISL_CORP_CASH','FISL_CORP_CASH_全字段','委托前_FISL_CORP_CASH_全字段')    Set Variable    CASH_NO='${头寸编号_全局变量}' and CURRENCY='${货币代码_全局变量}' ORDER BY CURRENCY
    ...    ELSE IF    '${接口或表名称}' in ('股份头寸查询_10323009','FISL_CORP_ASSET','FISL_CORP_ASSET_全字段','委托前_FISL_CORP_ASSET_全字段')    Set Variable    CASH_NO='${头寸编号_全局变量}' and STK_CODE ='${证券代码_全局变量}' ORDER BY STK_CODE
    ...    ELSE IF    '${接口或表名称}' in ('融资融券合约_10323001','FISL_CONTRACT') and '${证券业务}' in('702','703','直接还款')    Set Variable    CUACCT_CODE='${资金账户_全局变量}' and CONTRACT_TYPE='${合约类型_全局变量}' and ORDER_ID='${合同序号_全局变量}' ORDER BY ORDER_ID
    ...    ELSE IF    '${接口或表名称}' in ('融资融券合约_10323001','FISL_CONTRACT') and '${证券业务}' in('704','705','710')    Set Variable    CUACCT_CODE='${资金账户_全局变量}' and STK_CODE ='${证券代码_全局变量}' and CONTRACT_TYPE='${合约类型_全局变量}' ORDER BY ORDER_ID
    ...    ELSE IF    '${接口或表名称}' in ('融券合约汇总查询_10323031','FISL_SECULOAN_SUM')    Set Variable    CUACCT_CODE='${资金账户_全局变量}' and STK_CODE ='${证券代码_全局变量}' ORDER BY STK_CODE
    ...    ELSE IF    '${接口或表名称}' in ('融资合约汇总查询_10323030','FISL_FINANCE_SUM','委托前_FISL_FINANCE_SUM_融资合约汇总信息_全字段','FISL_FINANCE_SUM_融资合约汇总信息_全字段')    Set Variable    CUACCT_CODE='${资金账户_全局变量}' and STK_CODE ='${证券代码_全局变量}' ORDER BY STK_CODE
    ...    ELSE IF    '${接口或表名称}' in ('委托前_FISL_AGREEMENT_融资融券协议信息_全字段','FISL_AGREEMENT_融资融券协议信息_全字段')    Set Variable    CUACCT_CODE='${资金账户_全局变量}' ORDER BY AGT_BGN_DATE
    ...    ELSE IF    '${接口或表名称}' in ('委托前_FISL_FEE_SUM_全字段','委托后_FISL_FEE_SUM_全字段','FISL_FEE_SUM_全字段')    Set Variable    CUACCT_CODE='${资金账户_全局变量}'
    ...    ELSE IF    '${接口或表名称}' in ('委托后_FISL_REPAY_DETAIL','委托前_FISL_REPAY_DETAIL','实时偿还明细_10321012','FISL_REPAY_DETAIL')    Set Variable    CUACCT_CODE='${资金账户_全局变量}' and TRD_DATE='${交易时间_全局变量}' ORDER BY TRD_DATE
    #表
    ${表名}    Run Keyword If    '${接口或表名称}' in ('可用资金查询_10303001','委托前_CUACCT_FUND全表字段','CUACCT_FUND全表字段')    Set Variable    CUACCT_FUND
    ...    ELSE IF    '${接口或表名称}' in ('可用股份查询_10303002','委托前_STK_ASSET全表字段','STK_ASSET全表字段')    Set Variable    STK_ASSET
    ...    ELSE IF    '${接口或表名称}' =='当日委托查询_10303003'    Set Variable    STK_ORDER
    ...    ELSE IF    '${接口或表名称}' =='当日成交查询_10303004'    Set Variable    STK_MATCHING
    ...    ELSE IF    '${接口或表名称}' in ('资金头寸查询_10323008','FISL_CORP_CASH_全字段','委托前_FISL_CORP_CASH_全字段')    Set Variable    FISL_CORP_CASH
    ...    ELSE IF    '${接口或表名称}' in ('股份头寸查询_10323009','FISL_CORP_ASSET_全字段','委托前_FISL_CORP_ASSET_全字段')    Set Variable    FISL_CORP_ASSET
    ...    ELSE IF    '${接口或表名称}' =='融资融券合约_10323001'    Set Variable    FISL_CONTRACT
    ...    ELSE IF    '${接口或表名称}' =='融券合约汇总查询_10323031'    Set Variable    FISL_SECULOAN_SUM
    ...    ELSE IF    '${接口或表名称}' in ('融资合约汇总查询_10323030','委托前_FISL_FINANCE_SUM_融资合约汇总信息_全字段','FISL_FINANCE_SUM_融资合约汇总信息_全字段')    Set Variable    FISL_FINANCE_SUM
    ...    ELSE IF    '${接口或表名称}' in ('委托前_FISL_AGREEMENT_融资融券协议信息_全字段','FISL_AGREEMENT_融资融券协议信息_全字段')    Set Variable    FISL_AGREEMENT
    ...    ELSE IF    '${接口或表名称}' in ('委托前_FISL_FEE_SUM_全字段','委托后_FISL_FEE_SUM_全字段','FISL_FEE_SUM_全字段')    Set Variable    FISL_FEE_SUM
    ...    ELSE IF    '${接口或表名称}' in ('实时偿还明细_10321012','委托前_FISL_REPAY_DETAIL','委托后_FISL_REPAY_DETAIL')    Set Variable    FISL_REPAY_DETAIL
    ...    ELSE    Set Variable    ${接口或表名称}
    [Return]    ${字段名称}    ${表名}    ${条件}
