*** Settings ***
Resource          ../配置信息/环境配置信息.robot
Resource          常用关键字.robot
Resource          金证_数据库操作.robot

*** Keywords ***
头寸_买卖交易委托后检查_表查询
    [Arguments]    ${接口或表名称}    ${字段名称}    ${接口类型}=${接口类型_全局变量}
    [Documentation]    1.20211123 chm 新增
    数据库链接
    log    ${接口或表名称}
    ${字段名称key}    ${字段名称values}    字典拆分为key和Values    ${字段名称}
    ${Status}    ${msg}    Run Keyword And Ignore Error    Dictionary Should Contain Value    ${字段名称}    无计算逻辑
    ${字段名称}    ${表名}    ${条件}    Run Keyword If    '${接口类型}'=='Fis'    金证_头寸买卖委托表数据查询    ${字段名称key}    ${字段名称values}    ${接口或表名称}    ${字段名称}    ${Status}
    # 查询
    log    select ${字段名称} from ${表名} where ${条件}
    ${字段值}    query    select ${字段名称} from ${表名} where ${条件}
    log    ${字段值}
    ${表结果}    Create List
    FOR    ${i}    IN    @{字段值}
        ${表_转换字典}    列表转换为字典    ${字段名称key}    ${i}
        Append To List    ${表结果}    ${表_转换字典}
    END
    log    ${表结果}
    [Return]    ${表结果}

买卖交易委托后检查_表查询
    [Arguments]    ${接口或表名称}    ${字段名称}    ${接口类型}=${接口类型_全局变量}
    [Documentation]    1.20211123 chm 新增
    数据库链接
    log    ${接口或表名称}
    ${字段名称key}    ${字段名称values}    字典拆分为key和Values    ${字段名称}
    ${Status}    ${msg}    Run Keyword And Ignore Error    Dictionary Should Contain Value    ${字段名称}    无计算逻辑
    ${字段名称}    ${表名}    ${条件}    Run Keyword If    '${接口类型}'=='Fis'    金证_买卖委托表数据查询    ${字段名称key}    ${字段名称values}    ${接口或表名称}    ${字段名称}    ${Status}
    # 查询
    log    select ${字段名称} from ${表名} where ${条件}
    ${字段值}    query    select ${字段名称} from ${表名} where ${条件}
    log    ${字段值}
    ${表结果}    Create List
    FOR    ${i}    IN    @{字段值}
        ${表_转换字典}    列表转换为字典    ${字段名称key}    ${i}
        Append To List    ${表结果}    ${表_转换字典}
    END
    log    ${表结果}
    [Return]    ${表结果}

查询证券信息
    #查询字段：证券交易所【0】，证券代码【1】，证券名称【2】，证券类别【3】，证券状态【4】，交易板块【5】，货币代码【6】，证券代码【7】，价差【8】，正股代码【9】，涨停价【10】，跌停价【11】，每手数量【12】，单位标志【13】，停牌标志【14】
    @{查询证券信息}    Query    SELECT STKEX,STK_CODE,STK_NAME,STK_CLS,STK_STATUS,STKBD,CURRENCY,STK_CODE,STK_SPREAD,STK_UNDL_CODE,STK_UPLMT_PRICE,STK_LWLMT_PRICE,STK_LOT_SIZE,STK_LOT_FLAG,STK_SUSPENDED FROM STK_INFO WHERE STK_CODE='${证券代码_全局变量}'    #查询证券信息表    #${交易市场_全局变量}    Set Variable    ${查询证券信息[0][0]}    #${板块_全局变量}    Set Variable    ${查询证券信息[0][1]}    #${证券类别_全局变量}    Set Variable    ${查询证券信息[0][2]}    #${货币_全局变量}    Run Keyword if    '${板块_全局变量}'!='3'    Set Variable
    ${货币代码_全局变量}    Set Variable    ${查询证券信息[0][6]}
    ${价位差_全局变量}    Set Variable    ${查询证券信息[0][8]}
    ${价位价差_全局变量}    Evaluate    ${价位差_全局变量}/1000
    ${正股代码_全局变量}    Set Variable    ${查询证券信息[0][9]}
    ${涨停价_全局变量}    Set Variable    ${查询证券信息[0][10]}
    ${跌停价_全局变量}    Set Variable    ${查询证券信息[0][11]}
    Set Global Variable    ${货币代码_全局变量}
    Set Global Variable    ${价位价差_全局变量}
    Set Global Variable    ${正股代码_全局变量}
    Set Global Variable    ${涨停价_全局变量}
    Set Global Variable    ${跌停价_全局变量}

查询科创板证券信息
    @{科创板证券信息}    Query    select *    from STK_INFO a inner join FISL_COLLAT_SPINFO b on a.STK_CODE = b.STK_CODE WHERE STK_CLS = 'j'

资金头寸信息_头寸编号查询
    [Arguments]    ${头寸编号}=${头寸编号_全局变量}
    @{资金头寸信息}    Query    SELECT * FROM FISL_CORP_CASH WHERE CASH_NO = ${头寸编号}
    #Should Not Be Equal As Strings    ${头寸编号}    ${None}

增加持仓头寸合约
    [Arguments]    ${客户信息}=${客户信息_全局变量}
    log    ${客户信息}
    Execute Sql String    SELECT * FROM FISL_AGREEMENT ORDER BY CASH_FI_NO ASC;use kbss_stds;declare @CUACCT_CODE VARCHAR(12) ,@USER_CODE VARCHAR(12) ,@STKPBU_SH VARCHAR(5) ,@STKPBU_SZ VARCHAR(6) ,@ORG VARCHAR(4) ,@TRDACCT_SH VARCHAR(12) ,@TRDACCT_SZ VARCHAR(12) , @CASH_FI_NO VARCHAR(64) ,@CASH_SL_NO VARCHAR(64),@SUBSYS_SN VARCHAR(16);select @CUACCT_CODE='${客户信息}[CUACCT_CODE]';select @USER_CODE = (select USER_CODE from CUACCT where CUACCT_CODE = @CUACCT_CODE) select @ORG = (select INT_ORG from CUACCT where CUACCT_CODE = @CUACCT_CODE) select @STKPBU_SH = (select STKPBU from STK_TRDACCT where CUACCT_CODE = @CUACCT_CODE and STKBD = '10') select @STKPBU_SZ = (select STKPBU from STK_TRDACCT where CUACCT_CODE = @CUACCT_CODE and STKBD = '00') select @TRDACCT_SH = (select TRDACCT from STK_TRDACCT where CUACCT_CODE = @CUACCT_CODE and STKBD = '10') select @TRDACCT_SZ = (select TRDACCT from STK_TRDACCT where CUACCT_CODE = @CUACCT_CODE and STKBD = '00') select @CASH_FI_NO = (select CASH_FI_NO from FISL_AGREEMENT where CUACCT_CODE = @CUACCT_CODE) select @CASH_SL_NO = (select CASH_SL_NO from FISL_AGREEMENT where CUACCT_CODE = @CUACCT_CODE) select @SUBSYS_SN = (select SUBSYS_SN from CUACCT_FUND where CUACCT_CODE = @CUACCT_CODE);delete from FISL_CONTRACT where \ CASH_NO in (@CASH_FI_NO,@CASH_SL_NO) \ insert into FISL_CONTRACT select @CASH_FI_NO , 20151204, '0', @USER_CODE, @CUACCT_CODE, '0', @ORG, @TRDACCT_SZ, STKEX, STKBD, 20151203, STK_CODE, 'A0'+STKBD+STK_CODE, 1000, 12000, 12000000, 12036000, 0, 1000, 12000000, 12036000, 12036000, 0, 0, 0, 0, 0, 0, 0, 20151204, 0, 0, 0, '0', 20160604, 55000000, 6600000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100000, 0, 0, 0, 0, '0','0','0','0','0','0','0','0','0', 0, 0, @ORG, 0, '0', 0, '2015-12-04 10:55:45.451','0','0','0','0','','0','0','0' from STK_INFO where STK_CODE in (select STK_CODE from FISL_STK_SPINFO where STKBD = 00) \ insert into FISL_CONTRACT \ select @CASH_SL_NO , 20151204, '1', @USER_CODE, @CUACCT_CODE, '0', @ORG, @TRDACCT_SZ, STKEX, STKBD, 20151203, STK_CODE, 'A1'+STKBD+STK_CODE, 1000, 12000, 12000000, 12036000, 0, 1000, 12000000, 12036000, 0, 1000, 0, 0, 0, 0, 0, 0, 20151204, 0, 0, 0, '0', 20160604, 55000000, 6600000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100000, 0, 0, 0, 0, '0','0','0','0','0','0','0','0','0', 0, 0, @ORG, 0, '0', 0, '2015-12-04 10:55:45.451','0','0','0','0','','0','0','0' from STK_INFO where STK_CODE in (select STK_CODE from FISL_STK_SPINFO where STKBD = 00) \ insert into FISL_CONTRACT \ select @CASH_FI_NO , 20151204, '0', @USER_CODE, @CUACCT_CODE, '0', @ORG, @TRDACCT_SH, STKEX, STKBD, 20151203, STK_CODE, 'A0'+STKBD+STK_CODE, 1000, 12000, 12000000, 12036000, 0, 1000, 12000000, 12036000, 12036000, 0, 0, 0, 0, 0, 0, 0, 20151204, 0, 0, 0, '0', 20160604, 55000000, 6600000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100000, 0, 0, 0, 0, '0','0','0','0','0','0','0','0','0', 0, 0, @ORG, 0, '0', 0, '2015-12-04 10:55:45.451','0','0','0','0','','0','0','0' from STK_INFO where STK_CODE in (select STK_CODE from FISL_STK_SPINFO where STKBD = 10) \ insert into FISL_CONTRACT \ select @CASH_SL_NO , 20151204, '1', @USER_CODE, @CUACCT_CODE, '0', @ORG, @TRDACCT_SH, STKEX, STKBD, 20151203, STK_CODE, 'A1'+STKBD+STK_CODE, 1000, 12000, 12000000, 12036000, 0, 1000, 12000000, 12036000, 0, 1000, 0, 0, 0, 0, 0,0, 20151204, 0, 0, 0, '0', 20160604, 55000000, 6600000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100000, 0, 0, 0, 0, '0','0','0','0','0','0','0','0','0', 0, 0, @ORG, 0, '0', 0, '2015-12-04 10:55:45.451','0','0','0','0','','0','0','0' from STK_INFO where STK_CODE in (select STK_CODE from FISL_STK_SPINFO where STKBD = 10);delete from STK_ASSET where CUACCT_CODE = @CUACCT_CODE insert into STK_ASSET \ select @USER_CODE, @CUACCT_CODE, '1', '0', '0', '0', @ORG, STKEX, STKBD , @STKPBU_SH, @TRDACCT_SH, '0', STK_CODE, 'A', 100000, 100000, 100000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1049940, 0, '2014-04-16 10:43:40.228', ' ', @SUBSYS_SN, 0, 0,'', 0, 0, 0 from STK_INFO where STKBD = '10' and STK_CODE in (select STK_CODE from FISL_STK_SPINFO) \ insert into STK_ASSET \ select @USER_CODE, @CUACCT_CODE, '1', '0', '0', '0', @ORG, STKEX, STKBD , @STKPBU_SZ, @TRDACCT_SZ, '0', STK_CODE, 'A', 100000, 100000, 100000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1049940, 0, '2014-04-16 10:43:40.228', ' ', @SUBSYS_SN, 0, 0,'', 0, 0, 0 from STK_INFO where STKBD = '00' and STK_CODE in (select STK_CODE from FISL_STK_SPINFO);update FISL_CORP_CASH set CASH_BLN = 1000000000 ,CASH_AVL = 1000000000 \ where CASH_NO = @CASH_FI_NO;delete from FISL_CORP_ASSET where CASH_NO = @CASH_SL_NO insert into FISL_CORP_ASSET \ select @CASH_SL_NO, ' ', STKEX, STKBD ,STK_CODE, 100000, 100000,2,@SUBSYS_SN,0 ,0 from STK_INFO where STKBD = '00' and STK_CODE in (select STK_CODE from FISL_STK_SPINFO);insert into FISL_CORP_ASSET \ select @CASH_SL_NO, ' ', STKEX, STKBD ,STK_CODE, 100000, 100000,2,@SUBSYS_SN,0 ,0 from STK_INFO where STKBD = '10' and STK_CODE in (select STK_CODE from FISL_STK_SPINFO)

登录账户获取
    @{资金账户}    Query    SELECT CUACCT_CODE FROM STK_TRDACCT WHERE CUACCT_CODE IN ('12988680','79197132','79197318')
    [Return]    @{资金账户}

直接还款合同序号
    [Arguments]    ${表名}    ${条件}
    ${合同序号}    query    select ORDER_ID from ${表名} where ${条件}
    ${合同序号_全局变量}    Set Variable    ${合同序号}[0][0]
    Set Global Variable    ${合同序号_全局变量}

总对总检查_表查询
    [Arguments]    ${接口或表名称}    ${字段名称}    ${接口类型}=${接口类型_全局变量}
    [Documentation]    1.20211123 chm 新增
    数据库链接
    log    ${接口或表名称}
    ${字段名称key}    ${字段名称values}    字典拆分为key和Values    ${字段名称}
    ${Status}    ${msg}    Run Keyword And Ignore Error    Dictionary Should Contain Value    ${字段名称}    无计算逻辑
    ${字段名称}    ${表名}    ${条件}    Run Keyword If    '${接口类型}'=='Fis'    总对总表数据查询    ${字段名称key}    ${字段名称values}    ${接口或表名称}    ${字段名称}    ${Status}
    # 查询
    log    select ${字段名称} from ${表名} where ${条件}
    ${字段值}    query    select ${字段名称} from ${表名} where ${条件}
    Run Keyword If    '${表名}'=='FISL_REPAY_DETAIL'    直接还款合同序号    ${表名}    ${条件}
    log    ${字段值}
    ${表结果}    Create List
    FOR    ${i}    IN    @{字段值}
        ${表_转换字典}    列表转换为字典    ${字段名称key}    ${i}
        Append To List    ${表结果}    ${表_转换字典}
    END
    log    ${表结果}
    [Return]    ${表结果}
