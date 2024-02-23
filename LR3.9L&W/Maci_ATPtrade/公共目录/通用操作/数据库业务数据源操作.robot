*** Settings ***
Resource          ../配置信息/环境配置信息.robot
Resource          常用关键字.robot
Resource          金证_数据库操作.robot

*** Keywords ***
接口入参数据源
    [Arguments]    ${委托数量}    ${交易板块}=${交易板块_全局变量}    ${证券类别}=${证券类别_全局变量}    ${资金账户}=${资金账户_全局变量}    ${证券代码}=${证券代码_全局变量}    ${证券业务}=${证券业务_全局变量}
    @{委托数据}    query    declare @ORDER_QTY ot_account,@STK_CLS VARCHAR,@STKBD int,@date nvarchar(30),@CUACCT_CODE ot_account,@STK_CODE VARCHAR(8) set @date = CONVERT(nvarchar(30),getdate(),112) \ SELECT @ORDER_QTY=${委托数量} SELECT @STKBD=${交易板块} SELECT @STK_CLS='${证券类别}' SELECT @CUACCT_CODE=${资金账户} SELECT @STK_CODE=${证券代码} \ \ SELECT * FROM (select B.USER_CODE CUST_CODE, \ B.CUACCT_CODE CUACCT_CODE,B.STKBD STKBD,A.STK_CODE STK_CODE,A.PRICE ORDER_PRICE, A.ORDER_QTY ORDER_QTY,'${证券业务}' STK_BIZ,'100' STK_BIZ_ACTION,B.STKPBU STKPBU,B.TRDACCT TRDACCT,'0' SECURITY_LEVEL \ FROM (SELECT (FLOOR(a.STK_LWLMT_PRICE/10000)+1) AS PRICE,a.STKBD,@ORDER_QTY AS ORDER_QTY,b.TRD_DATE, a.STK_CLS,a.STK_LWLMT_PRICE,a.STK_UPLMT_PRICE,a.STK_CODE FROM STK_INFO a \ INNER JOIN STK_MKTINFO b ON a.STK_CODE=b.STK_CODE) A \ INNER JOIN (select A.USER_CODE,A.CUACCT_CODE,B.STKBD,B.STKPBU,B.TRDACCT FROM CUACCT_FUND A \ INNER JOIN (SELECT * FROM STK_TRDACCT WHERE TRDACCT_STATUS='0') B ON A.CUACCT_CODE=B.CUACCT_CODE ) B ON A.STKBD=B.STKBD ) T1 WHERE STKBD=@STKBD AND STK_CODE=@STK_CODE AND CUACCT_CODE=@CUACCT_CODE
    log    ${委托数据}
    ${客户代码_全局变量}    Set Variable    ${委托数据}[0][0]
    ${资金账户_全局变量}    Set Variable    ${委托数据}[0][1]
    ${交易板块_全局变量}    Set Variable    ${委托数据}[0][2]
    ${证券代码_全局变量}    Set Variable    ${委托数据}[0][3]
    ${委托价格_全局变量}    Set Variable    ${委托数据}[0][4]
    ${委托数量_全局变量}    Set Variable    ${委托数据}[0][5]
    ${证券业务_全局变量}    Set Variable    ${委托数据}[0][6]
    ${业务行为_全局变量}    Set Variable    ${委托数据}[0][7]
    ${交易单元_全局变量}    Set Variable    ${委托数据}[0][8]
    ${股东代码_全局变量}    Set Variable    ${委托数据}[0][9]
    Set Global Variable    ${客户代码_全局变量}
    Set Global Variable    ${资金账户_全局变量}
    Set Global Variable    ${交易板块_全局变量}
    Set Global Variable    ${证券代码_全局变量}
    Set Global Variable    ${委托价格_全局变量}
    Set Global Variable    ${委托数量_全局变量}
    Set Global Variable    ${证券业务_全局变量}
    Set Global Variable    ${业务行为_全局变量}
    Set Global Variable    ${交易单元_全局变量}
    Set Global Variable    ${股东代码_全局变量}
    [Return]    @{委托数据}
