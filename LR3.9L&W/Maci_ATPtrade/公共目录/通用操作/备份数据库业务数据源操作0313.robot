*** Settings ***
Resource          ../配置信息/环境配置信息.robot
Resource          常用关键字.robot
Resource          金证_数据库操作.robot

*** Keywords ***
现券还券
    [Arguments]    ${委托数量}    ${交易板块}=${交易板块_全局变量}    ${证券类别}=${证券类别_全局变量}
    @{委托数据}    query    declare @ORDER_QTY ot_account,@STK_CLS VARCHAR,@STKBD int,@date nvarchar(30) set @date = CONVERT(nvarchar(30),getdate(),112) SELECT @ORDER_QTY=${委托数量} SELECT @STKBD=${交易板块} SELECT @STK_CLS='${证券类别}' select TOP 1 B.CUST_CODE CUST_CODE, B.CUACCT_CODE CUACCT_CODE, B.STKBD STKBD, A.STK_CODE STK_CODE, A.PRICE ORDER_PRICE, A.ORDER_QTY ORDER_QTY, '710' STK_BIZ, '100' STK_BIZ_ACTION, B.STKPBU STKPBU, B.TRDACCT TRDACCT,'0' SECURITY_LEVEL FROM (SELECT FLOOR((a.STK_UPLMT_PRICE+a.STK_LWLMT_PRICE)/20000) AS PRICE, a.STKBD, @ORDER_QTY AS ORDER_QTY,a.STK_CODE FROM STK_INFO a INNER JOIN STK_MKTINFO b ON a.STK_CODE=b.STK_CODE WHERE a.STK_CLS=@STK_CLS AND a.STKBD = @STKBD and b.TRD_DATE=@date) A INNER JOIN (SELECT a.CUST_CODE, a.CUACCT_CODE, b.STKPBU, a.TRDACCT, a.STK_CODE, a.STKBD, b.STK_AVL, sum(a.SL_DEBTS_QTY) SL_DEBTS_QTY FROM FISL_CONTRACT a INNER JOIN STK_ASSET b ON a.CUST_CODE=b.CUST_CODE AND a.STK_CODE = b.STK_CODE \ WHERE a.CONTRACT_STATUS IN ('0','1') and a.CONTRACT_TYPE=1 AND a.STKBD = @STKBD AND b.STK_AVL > @ORDER_QTY GROUP BY a.STK_CODE,a.STKBD,a.CUST_CODE,a.CUACCT_CODE,b.STKPBU,a.TRDACCT,b.STK_AVL HAVING sum(a.SL_DEBTS_QTY) > @ORDER_QTY) B ON A.STK_CODE=B.STK_CODE
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

融资融券直接还款
    [Arguments]    ${委托金额}
    @{委托数据}    query    declare @AMT float SELECT @AMT=${委托金额} SELECT TOP 1 A.CUACCT_CODE CUACCT_CODE, '0' CURRENCY, '2' CASH_TYPE, @AMT REPAY_CONTRACT_AMT, '0' REPAY_TYPE FROM (SELECT a.CUACCT_CODE,a.CONTRACT_STATUS,b.FUND_AVL, sum(a.RLT_SETT_AMT) a.FI_DEBTS_AMT FROM FISL_CONTRACT a inner join CUACCT_FUND b WHERE a.CONTRACT_STATUS IN ('0','1') AND b.FUND_AVL> @AMT GROUP BY a.CUACCT_CODE,a.CONTRACT_STATUS,b.FUND_AVL HAVING sum(a.RLT_SETT_AMT) > @AMT) A
    log    ${委托数据}
    ${资金账户_全局变量}    Set Variable    ${委托数据}[0][0]
    ${货币代码_全局变量}    Set Variable    ${委托数据}[0][1]
    ${头寸类型_全局变量}    Set Variable    ${委托数据}[0][2]
    ${偿还金额_全局变量}    Set Variable    ${委托数据}[0][3]
    ${偿还类型_全局变量}    Set Variable    ${委托数据}[0][4]
    Set Global Variable    ${资金账户_全局变量}
    Set Global Variable    ${货币代码_全局变量}
    Set Global Variable    ${头寸类型_全局变量}
    Set Global Variable    ${偿还金额_全局变量}
    Set Global Variable    ${偿还类型_全局变量}
    [Return]    @{委托数据}

卖券还款
    [Arguments]    ${委托数量}    ${交易板块}=${交易板块_全局变量}    ${证券类别}=${证券类别_全局变量}    ${资金账户}=${资金账户_全局变量}
    @{委托数据}    Query    declare @ORDER_QTY ot_account,@CUACCT_CODE ot_account, @STK_CLS VARCHAR,@STKBD int,@date nvarchar(30) set @date = CONVERT(nvarchar(30),getdate(),112) \ SELECT @ORDER_QTY=${委托数量} SELECT @STKBD=${交易板块} SELECT @STK_CLS='${证券类别}' \ SELECT @CUACCT_CODE=${资金账户} select TOP 100 B.CUST_CODE CUST_CODE, B.CUACCT_CODE CUACCT_CODE,B.STKBD STKBD,A.STK_CODE STK_CODE,A.PRICE ORDER_PRICE, A.ORDER_QTY ORDER_QTY, '705' STK_BIZ, '100' STK_BIZ_ACTION, B.STKPBU STKPBU, B.TRDACCT TRDACCT, '0' SECURITY_LEVEL FROM (SELECT (FLOOR(a.STK_LWLMT_PRICE/10000)+1) AS PRICE, a.STKBD, @ORDER_QTY AS ORDER_QTY, c.CREDIT_FUND_CTL, a.STK_CODE FROM STK_INFO \ a \ INNER JOIN STK_MKTINFO b ON a.STK_CODE=b.STK_CODE INNER JOIN FISL_STK_SPINFO c ON a.STK_CODE=c.STK_CODE WHERE a.STKBD=@STKBD ) \ A INNER JOIN \ (SELECT a.CUST_CODE, a.CUACCT_CODE, b.STKPBU, a.TRDACCT, a.STK_CODE, b.STK_CLS,a.STKBD, b.STK_AVL, sum(a.FI_DEBTS_AMT) FI_DEBTS_AMT FROM FISL_CONTRACT a INNER JOIN STK_ASSET b ON a.CUST_CODE=b.CUST_CODE AND a.STK_CODE = b.STK_CODE \ WHERE a.CONTRACT_STATUS IN ('0','1') \ and a.CONTRACT_TYPE=0 \ AND a.STKBD = @STKBD \ AND b.STK_AVL > @ORDER_QTY AND \ b.STK_CODE IN \ (SELECT MIN(STK_CODE) AS STK_CODE FROM STK_INFO WHERE (FLOOR(STK_UPLMT_PRICE)-FLOOR(STK_LWLMT_PRICE))>1 AND UPD_DATE=@date AND STKBD =10 AND \ STK_CLS \ IN ('D','d','M','0','H','r','j','A','L','e') GROUP BY \ STK_CLS UNION ALL SELECT MIN(STK_CODE) AS STK_CODE FROM STK_INFO WHERE (FLOOR(STK_UPLMT_PRICE)-FLOOR(STK_LWLMT_PRICE))>1 AND UPD_DATE=@date AND STKBD =00 AND \ STK_CLS \ IN ('D','J','M','y','0','H','A','L','e') GROUP BY \ STK_CLS) GROUP BY \ b.STK_CLS,a.STK_CODE,a.STKBD,a.CUST_CODE,a.CUACCT_CODE,b.STKPBU,a.TRDACCT,b.STK_AVL HAVING sum(a.FI_DEBTS_AMT) > 0) B \ \ ON A.STK_CODE=B.STK_CODE where \ A.CREDIT_FUND_CTL in ('0','2') AND B.STK_CLS=@STK_CLS AND B.CUACCT_CODE=@CUACCT_CODE
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

买券还券
    [Arguments]    ${委托数量}    ${交易板块}=${交易板块_全局变量}    ${证券类别}=${证券类别_全局变量}    ${资金账户}=${资金账户_全局变量}
    @{委托数据}    Query    declare @ORDER_QTY ot_account,@CUACCT_CODE ot_account, @STK_CLS VARCHAR,@STKBD int,@date nvarchar(30) set @date = CONVERT(nvarchar(30),getdate(),112) \ SELECT @ORDER_QTY=${委托数量} SELECT @STKBD=${交易板块} SELECT @STK_CLS='${证券类别}' \ SELECT @CUACCT_CODE=${资金账户} select TOP 100 B.CUST_CODE CUST_CODE, B.CUACCT_CODE CUACCT_CODE, B.STKBD STKBD, A.STK_CODE STK_CODE, A.PRICE ORDER_PRICE, A.ORDER_QTY ORDER_QTY, '704' STK_BIZ, '100' STK_BIZ_ACTION, B.STKPBU STKPBU, B.TRDACCT TRDACCT, '0' SECURITY_LEVEL FROM (SELECT (FLOOR(a.STK_LWLMT_PRICE/10000)+1) AS PRICE, a.STKBD, @ORDER_QTY AS ORDER_QTY, c.CREDIT_STK_CTL, a.STK_CODE FROM STK_INFO \ a \ INNER JOIN STK_MKTINFO b ON a.STK_CODE=b.STK_CODE INNER JOIN FISL_STK_SPINFO c ON a.STK_CODE=c.STK_CODE WHERE c.STK_CODE IN \ (SELECT MIN(STK_CODE) AS STK_CODE FROM STK_INFO WHERE (FLOOR(STK_UPLMT_PRICE)-FLOOR(STK_LWLMT_PRICE))>1 AND UPD_DATE=@date AND STKBD =10 AND \ STK_CLS \ IN ('D','d','M','0','H','r','j','A','L','e') GROUP BY \ STK_CLS UNION ALL SELECT MIN(STK_CODE) AS STK_CODE FROM STK_INFO WHERE (FLOOR(STK_UPLMT_PRICE)-FLOOR(STK_LWLMT_PRICE))>1 AND UPD_DATE=@date AND STKBD =00 AND \ STK_CLS \ IN ('D','J','M','y','0','H','A','L','e') GROUP BY \ STK_CLS)) \ A INNER JOIN \ (SELECT a.CUST_CODE, a.CUACCT_CODE, b.STKPBU, a.TRDACCT, a.STK_CODE, a.CONTRACT_STATUS, a.CONTRACT_TYPE, a.STKBD, sum(a.SL_DEBTS_QTY) SL_DEBTS_QTY FROM FISL_CONTRACT a INNER JOIN STK_TRDACCT b ON a.CUST_CODE=b.CUST_CODE GROUP BY a.STK_CODE,a.STKBD,a.CUST_CODE,a.CUACCT_CODE,b.STKPBU,a.TRDACCT,a.CONTRACT_STATUS,a.CONTRACT_TYPE \ HAVING \ \ sum(a.SL_DEBTS_QTY) > @ORDER_QTY)B ON A.STKBD=B.STKBD \ \ WHERE B.CONTRACT_STATUS IN ('0','1') \ AND B.CONTRACT_TYPE=1 \ --有开仓未还的融券合约 AND A.STKBD=@STKBD AND \ A.CREDIT_STK_CTL IN ('0','2') AND B.CUACCT_CODE=@CUACCT_CODE AND A.STK_CLS=@STK_CLS GROUP BY \ B.CUST_CODE,B.STKBD,B.STKBD,A.STK_CODE,A.PRICE,A.ORDER_QTY,B.STKPBU,B.TRDACCT,B.CUACCT_CODE
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

融券卖出
    [Arguments]    ${委托数量}    ${交易板块}=${交易板块_全局变量}    ${证券类别}=${证券类别_全局变量}    ${资金账户}=${资金账户_全局变量}
    @{委托数据}    Query    declare @ORDER_QTY ot_account,@CUACCT_CODE ot_account, @STK_CLS VARCHAR,@STKBD int,@date nvarchar(30) set @date = CONVERT(nvarchar(30),getdate(),112) \ SELECT @ORDER_QTY=${委托数量} SELECT @STKBD=${交易板块} SELECT @STK_CLS='${证券类别}' \ SELECT @CUACCT_CODE=${资金账户} select B.CUST_CODE CUST_CODE, B.CUACCT_CODE CUACCT_CODE,B.STKBD STKBD, A.STK_CODE STK_CODE, A.PRICE ORDER_PRICE,A.ORDER_QTY ORDER_QTY, '703' STK_BIZ,'100' STK_BIZ_ACTION,B.STKPBU STKPBU, B.TRDACCT TRDACCT, '0' SECURITY_LEVEL FROM (SELECT (FLOOR(a.STK_LWLMT_PRICE/10000)+1) AS PRICE, c.STKBD, @ORDER_QTY AS ORDER_QTY, c.CREDIT_STK_CTL, a.STK_CLS, c.STK_CODE FROM STK_INFO \ a \ INNER JOIN \ STK_MKTINFO b ON a.STK_CODE=b.STK_CODE \ INNER JOIN FISL_STK_SPINFO c ON a.STK_CODE=c.STK_CODE \ INNER JOIN FISL_CORP_ASSET d ON c.STK_CODE=d.STK_CODE) A INNER JOIN \ (select d.CUST_CODE, d.CUACCT_CODE, d.STKBD,d.STKPBU, d.TRDACCT, b.SL_CREDIT,a.STK_CODE, a.ASSET_AVL FROM FISL_CORP_ASSET a \ INNER JOIN FISL_AGREEMENT b ON a.CASH_NO=b.CASH_FI_NO INNER JOIN FISL_CONTRACT c ON b.CASH_FI_NO=c.CASH_NO INNER JOIN STK_TRDACCT d ON c.CUST_CODE=d.CUST_CODE WHERE a.STK_CODE IN \ (SELECT MIN(STK_CODE) AS STK_CODE FROM STK_INFO WHERE (FLOOR(STK_UPLMT_PRICE)-FLOOR(STK_LWLMT_PRICE))>1 AND UPD_DATE=@date AND STKBD =10 AND \ STK_CLS \ IN ('D','d','M','0','H','r','j','A','L','e') GROUP BY \ STK_CLS UNION ALL SELECT MIN(STK_CODE) AS STK_CODE FROM STK_INFO WHERE (FLOOR(STK_UPLMT_PRICE)-FLOOR(STK_LWLMT_PRICE))>1 AND UPD_DATE=@date AND STKBD =00 AND \ STK_CLS \ IN ('D','J','M','y','0','H','A','L','e') GROUP BY \ STK_CLS)) B \ ON A.STK_CODE = B.STK_CODE \ WHERE B.ASSET_AVL > @ORDER_QTY \ AND B.SL_CREDIT > @ORDER_QTY \ AND A.CREDIT_STK_CTL in ('0','2') AND A.STK_CLS=@STK_CLS AND A.STKBD=@STKBD AND B.CUACCT_CODE=@CUACCT_CODE GROUP BY \ B.CUST_CODE,B.STKBD,B.STKBD,A.STK_CODE,A.PRICE,A.ORDER_QTY,B.STKPBU,B.TRDACCT,B.CUACCT_CODE
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

融资买入
    [Arguments]    ${委托数量}    ${交易板块}=${交易板块_全局变量}    ${证券类别}=${证券类别_全局变量}    ${资金账户}=${资金账户_全局变量}
    @{委托数据}    Query    declare @ORDER_QTY ot_account,@CUACCT_CODE ot_account, @STK_CLS VARCHAR,@STKBD int,@date nvarchar(30) set @date = CONVERT(nvarchar(30),getdate(),112) \ SELECT @ORDER_QTY=${委托数量} SELECT @STKBD=${交易板块} SELECT @STK_CLS='${证券类别}' \ SELECT @CUACCT_CODE=${资金账户} SELECT B.CUST_CODE CUST_CODE, B.CUACCT_CODE CUACCT_CODE, B.STKBD STKBD, A.STK_CODE STK_CODE, A.PRICE ORDER_PRICE, A.ORDER_QTY ORDER_QTY, '702' STK_BIZ, '100' STK_BIZ_ACTION, B.STKPBU STKPBU, B.TRDACCT TRDACCT, '0' SECURITY_LEVEL FROM (SELECT (FLOOR(a.STK_LWLMT_PRICE/10000)+1) AS PRICE, c.STKBD, a.STK_CLS, @ORDER_QTY AS ORDER_QTY, c.CREDIT_FUND_CTL, c.STK_CODE FROM STK_INFO \ a \ INNER JOIN \ STK_MKTINFO b ON a.STK_CODE=b.STK_CODE \ INNER JOIN FISL_STK_SPINFO c ON a.STK_CODE=c.STK_CODE WHERE c.STK_CODE IN \ (SELECT MIN(STK_CODE) AS STK_CODE FROM STK_INFO WHERE (FLOOR(STK_UPLMT_PRICE)-FLOOR(STK_LWLMT_PRICE))>1 AND UPD_DATE=@date AND STKBD =10 AND \ STK_CLS \ IN ('D','d','M','0','H','r','j','A','L','e') GROUP BY \ STK_CLS UNION ALL SELECT MIN(STK_CODE) AS STK_CODE FROM STK_INFO WHERE (FLOOR(STK_UPLMT_PRICE)-FLOOR(STK_LWLMT_PRICE))>1 AND UPD_DATE=@date AND STKBD =00 AND \ STK_CLS \ IN ('D','J','M','y','0','H','A','L','e') GROUP BY \ STK_CLS)) A INNER JOIN \ (select c.CUST_CODE, c.CUACCT_CODE, d.STKBD, d.STKPBU, d.TRDACCT, b.FI_CREDIT, a.CASH_AVL FROM FISL_CORP_CASH a \ INNER JOIN FISL_AGREEMENT b ON a.CASH_NO=b.CASH_FI_NO INNER JOIN FISL_CONTRACT c ON a.CASH_NO=c.CASH_NO INNER JOIN STK_TRDACCT d ON c.CUST_CODE=d.CUST_CODE) B \ ON A.STKBD=B.STKBD WHERE \ B.FI_CREDIT/1000>(@ORDER_QTY*A.PRICE) \ AND B.CASH_AVL/1000>(@ORDER_QTY*A.PRICE) AND A.CREDIT_FUND_CTL in ('0','2') AND A.STKBD=@STKBD \ AND A.STK_CLS=@STK_CLS AND B.CUACCT_CODE=@CUACCT_CODE GROUP BY \ B.CUST_CODE,B.STKBD,B.STKBD,A.STK_CODE,A.PRICE,A.ORDER_QTY,B.STKPBU,B.TRDACCT,B.CUACCT_CODE
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

担保品卖出
    [Arguments]    ${委托数量}    ${交易板块}=${交易板块_全局变量}    ${证券类别}=${证券类别_全局变量}    ${资金账户}=${资金账户_全局变量}
    @{委托数据}    Query    declare @ORDER_QTY ot_account,@CUACCT_CODE ot_account, @STK_CLS VARCHAR,@STKBD int,@date nvarchar(30) set @date = CONVERT(nvarchar(30),getdate(),112) \ SELECT @ORDER_QTY=${委托数量} SELECT @STKBD=${交易板块} SELECT @STK_CLS='${证券类别}' \ SELECT @CUACCT_CODE=${资金账户} select B.CUST_CODE CUST_CODE, B.CUACCT_CODE CUACCT_CODE, B.STKBD STKBD, A.STK_CODE STK_CODE, A.PRICE ORDER_PRICE, A.ORDER_QTY ORDER_QTY, '701' STK_BIZ, '100' STK_BIZ_ACTION, B.STKPBU STKPBU, B.TRDACCT TRDACCT, '0' SECURITY_LEVEL FROM (SELECT (FLOOR(a.STK_LWLMT_PRICE/10000)+1) AS PRICE, @ORDER_QTY AS ORDER_QTY, c.STK_CODE, b.TRD_DATE FROM STK_INFO \ a \ INNER JOIN \ STK_MKTINFO b ON a.STK_CODE=b.STK_CODE INNER JOIN FISL_COLLAT_SPINFO c ON b.STK_CODE=c.STK_CODE \ \ INNER JOIN STK_ASSET d ON c.STK_CODE=d.STK_CODE) A INNER JOIN \ (select CUST_CODE, CUACCT_CODE, STKBD, STKPBU, STK_CODE, STK_CLS, TRDACCT FROM STK_ASSET WHERE STK_CODE IN \ (SELECT MIN(STK_CODE) AS STK_CODE FROM STK_INFO WHERE (FLOOR(STK_UPLMT_PRICE)-FLOOR(STK_LWLMT_PRICE))>1 AND UPD_DATE=@date AND STKBD =10 AND \ STK_CLS \ IN ('D','J','d','M','0','H','r','j','A','c','L','e') GROUP BY \ STK_CLS UNION ALL SELECT MIN(STK_CODE) AS STK_CODE FROM STK_INFO WHERE (FLOOR(STK_UPLMT_PRICE)-FLOOR(STK_LWLMT_PRICE))>1 AND UPD_DATE=@date AND STKBD =00 AND \ STK_CLS \ IN ('D','J','d','M','0','H','r','y','A','c','L','e','E') GROUP BY \ STK_CLS) AND STK_AVL>@ORDER_QTY)B \ ON A.STK_CODE=B.STK_CODE \ WHERE B.STK_CLS=@STK_CLS AND B.STKBD=@STKBD AND B.CUACCT_CODE=@CUACCT_CODE
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

担保品买入
    [Arguments]    ${委托数量}    ${交易板块}=${交易板块_全局变量}    ${证券类别}=${证券类别_全局变量}    ${资金账户}=${资金账户_全局变量}
    @{委托数据}    Query    declare @ORDER_QTY ot_account,@STK_CLS VARCHAR,@STKBD int,@date nvarchar(30),@CUACCT_CODE ot_account,@STK_CODE VARCHAR(8) set @date = CONVERT(nvarchar(30),getdate(),112) SELECT @ORDER_QTY=${委托数量} SELECT @STKBD=${交易板块} SELECT @STK_CLS='${证券类别}' SELECT @CUACCT_CODE=${资金账户} SELECT @STK_CODE=${证券代码} \ select B.USER_CODE CUST_CODE, B.CUACCT_CODE CUACCT_CODE,B.STKBD STKBD,A.STK_CODE STK_CODE,A.PRICE ORDER_PRICE, A.ORDER_QTY ORDER_QTY,'700' STK_BIZ,'100' STK_BIZ_ACTION,B.STKPBU STKPBU,B.TRDACCT TRDACCT,'0' SECURITY_LEVEL FROM (SELECT (FLOOR(a.STK_LWLMT_PRICE/10000)+1) AS PRICE,c.STKBD,@ORDER_QTY AS ORDER_QTY,b.TRD_DATE, a.STK_CLS,a.STK_LWLMT_PRICE,a.STK_UPLMT_PRICE,c.STK_CODE FROM STK_INFO a INNER JOIN STK_MKTINFO b ON a.STK_CODE=b.STK_CODE \ INNER JOIN FISL_COLLAT_SPINFO c ON b.STK_CODE=c.STK_CODE WHERE a.STK_CODE IN (SELECT MIN(STK_CODE) AS STK_CODE FROM STK_INFO WHERE (FLOOR(STK_UPLMT_PRICE)-FLOOR(STK_LWLMT_PRICE))>1 AND UPD_DATE=@date AND STKBD =10 AND STK_CLS IN ('D','J','d','M','0','H','r','j','A','c','L','e') GROUP BY STK_CLS UNION ALL SELECT MIN(STK_CODE) AS STK_CODE FROM STK_INFO \ WHERE (FLOOR(STK_UPLMT_PRICE)-FLOOR(STK_LWLMT_PRICE))>1 \ AND UPD_DATE=@date AND STKBD =00 AND STK_CLS IN ('D','J','d','M','0','H','r','y','A','c','L','e','E') GROUP BY STK_CLS)) A \ INNER JOIN (select A.USER_CODE, A.CUACCT_CODE, B.STKBD,B.STKPBU,FUND_AVL,B.TRDACCT FROM CUACCT_FUND A \ INNER JOIN STK_TRDACCT B ON A.CUACCT_CODE=B.CUACCT_CODE ) B ON A.STKBD=B.STKBD \ WHERE B.FUND_AVL> (A.ORDER_QTY*A.PRICE) AND A.STK_CLS = @STK_CLS AND A.STKBD = @STKBD AND B.CUACCT_CODE=@CUACCT_CODE AND A.STK_CODE=@STK_CODE \ GROUP BY B.USER_CODE,B.STKBD,B.STKBD,A.STK_CODE,A.PRICE,A.ORDER_QTY,B.STKPBU,B.TRDACCT,B.CUACCT_CODE
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
