declare @ORDER_QTY ot_account,@date nvarchar(30),@no int,@len INT
set @date = CONVERT(nvarchar(30),getdate(),112)
set @ORDER_QTY=1000
set @no = 1
set @len = 10000 --取证券类别代码数量
;
WITH CTE_Cuacct AS (SELECT C.USER_CODE AS CUST_CODE,  --查符合条件账户
				           C.CUACCT_CODE,
				           C.FUND_STATUS,
				           D.STKPBU,
				           C.FUND_AVL,
				           E.CUST_AGMT_TYPE,
				           D.TRDACCT,
				           D.STKBD
				  	FROM (SELECT * FROM CUACCT_FUND WHERE FUND_AVL/1000>100 AND CUACCT_CODE  not IN (SELECT CUACCT_CODE  FROM CUACCT_CHANNEL_CFG )) C
					INNER JOIN (SELECT * FROM STK_TRDACCT WHERE STKBD ='03'  AND TRDACCT_STATUS = '0' AND  TRDACCT_EXCLS in ('0','1') AND STKPBU <> ' ' 	
					) D 
				    ON C.CUACCT_CODE = D.CUACCT_CODE
					INNER JOIN (SELECT * FROM CUST_AGREEMENT WHERE EXP_DATE>@date AND CUST_AGMT_TYPE <>' ' AND CUST_AGMT_TYPE='h') E  
					ON D.CUST_CODE = E.CUST_CODE
					)
,
CTE_Stk_Code AS (SELECT A.STK_CODE,A.STKBD,A.STK_CLS,A.STK_SUB_CLS,A.STK_LEVEL,A.STK_LOT_SIZE,--(查符合条件代码)增加每手数量
		            		case when  B.CURRENT_PRICE <> 0 AND  B.CURRENT_PRICE <> '' then   ROUND(B.CURRENT_PRICE/10000.000,3,1) 
								when (B.CURRENT_PRICE = 0 or B.CURRENT_PRICE = '') AND B.CLOSING_PRICE <>  0   AND B.CLOSING_PRICE  <> '' then  ROUND(B.CLOSING_PRICE/10000.000,3,1)
							ELSE ROUND(A.STK_LWLMT_PRICE/10000.000,3,1)END as PRICE,	-- 委托价格
			                A.STK_LWLMT_PRICE/10000.00 AS STK_LWLMT_PRICE,
					        A.STK_UPLMT_PRICE/10000.00 AS STK_UPLMT_PRICE,
						 	CASE WHEN isnull(@ORDER_QTY,0) = 0 THEN 
							    CASE WHEN STK_LWLMT_QTY>STK_LOT_SIZE THEN STK_LWLMT_QTY  -- 比较最小委托单位和步长取大为委托数量
							    ELSE STK_LOT_SIZE END
							ELSE @ORDER_QTY END AS ORDER_QTY  -- 委托数量
							FROM 
								(SELECT * FROM STK_INFO WHERE STK_CLS IN ('A') AND --证券种类
					      		STK_SUB_CLS IN ('*','0','f','g','h') AND --证券子类
			                	STK_BIZES LIKE '%130%' AND --证券业务
			                	STK_SUSPENDED = '0'  AND --停牌标志
                                UPD_DATE = @date 
			                	) A   --证券信息表 
								INNER JOIN (SELECT *  FROM HGT_STK_TRD_STATUS WHERE LOT_TRD_STATUS in ('A','B','S')  AND OBJECT_FLAG = '1' ) E ON A.STK_CODE=E.STK_CODE
                                INNER JOIN (SELECT STKBD,STK_CLS FROM STK_CLS_TRD_CFG WHERE STK_BIZ='130' GROUP BY STKBD,STK_CLS) D ON A.STKBD=D.STKBD AND A.STK_CLS=D.STK_CLS  -- 取130支持的证券类别
								INNER  JOIN (SELECT * FROM STK_MKTINFO 
								) B 
								ON B.STK_CODE=A.STK_CODE AND B.STKBD=A.STKBD   -- 行情表
                                )
,
CTE_TJ1 AS --筛选无控制权限账户
(                                
SELECT CUST_CODE,CUACCT_CODE,FUND_STATUS,STKPBU,FUND_AVL,CUST_AGMT_TYPE,TRDACCT,A.STKBD,
STK_CODE,STK_CLS,STK_SUB_CLS,STK_LEVEL,STK_LOT_SIZE,PRICE,ORDER_QTY,STK_LWLMT_PRICE,STK_UPLMT_PRICE --增加每手数量
				             FROM  CTE_Cuacct A,CTE_Stk_Code B WHERE A.STKBD=B.STKBD AND   NOT EXISTS 
			( SELECT STK_CODE,CUACCT_CODE FROM CUST_STK_TRD_CTRL T1 
				WHERE   
				(
				(STK_BIZCS = '' AND STK_CODE = '' AND STK_CLSES = '')  --账户级
				OR (T1.STK_BIZCS LIKE '%130%' AND T1.STK_CODE = '' AND T1.STK_CLSES = '') --证券业务级
				OR (T1.STK_BIZCS LIKE '%130%' AND T1.STK_CODE = '' AND T1.STK_CLSES = STK_CLS) --证券类别级 
				OR (T1.STK_BIZCS LIKE '%130%' AND T1.STK_CODE = STK_CODE AND T1.STK_CLSES = STK_CLS) --证券代码级 
				) 
				AND CUACCT_CODE=T1.CUACCT_CODE) --客户证券交易限制                         
)
,
CTE_TJ2 AS  --取证券代码数量
(SELECT * FROM    (SELECT ROW_NUMBER() OVER (PARTITION BY STK_CLS,STK_SUB_CLS,STKBD,CUACCT_CODE ORDER BY STK_CODE ASC) AS ID,*  FROM    CTE_TJ1) A WHERE ID between @no and @no+@len --同种类证券代码需要数量
)  

,
CTE_Zero1_131_141 AS  --临时表定义零股全部卖出场景
(
SELECT ID, 
STK_LWLMT_PRICE, 
STK_UPLMT_PRICE, 
A.CUST_CODE, 
A.CUACCT_CODE, 
A.STKBD, A.STKPBU, 
A.TRDACCT, 
131 STK_BIZ, 
'141' STK_BIZ_ACTION, 
A.STK_CODE, 
A.STK_CLS, 
(C.STK_AVL % A.STK_LOT_SIZE) AS ORDER_QTY,
A.STK_LOT_SIZE,
C.STK_AVL,
STK_SUB_CLS, 
'0' SECURITY_LEVEL,
(A.PRICE+ ROUND(B.STK_SPREAD/10000.000,3,1)) AS ORDER_PRICE 
FROM CTE_TJ2  A,  STK_PRICE_UNIT B, STK_ASSET C  
WHERE A.CUACCT_CODE = C.CUACCT_CODE AND A.STK_CODE=C.STK_CODE AND  A.STKBD = B.STKBD  AND A.STK_CLS=B.STK_CLS  AND B.STKBD=C.STKBD AND B.STK_CLS=C.STK_CLS AND C.STK_AVL>0 
AND (C.STK_AVL<A.STK_LOT_SIZE or(C.STK_AVL>A.STK_LOT_SIZE and C.STK_AVL % A.STK_LOT_SIZE<>0) )  AND B.STK_CLS = 'A'  AND A.PRICE BETWEEN B.BGN_PRICE/10000 AND B.END_PRICE/10000   --价格+价差逻辑处理                           
)
,
CTE_Zero2_131_141 AS  --临时表定义零股部分卖出场景
(
SELECT ID, 
STK_LWLMT_PRICE, 
STK_UPLMT_PRICE, 
A.CUST_CODE, 
A.CUACCT_CODE, 
A.STKBD, A.STKPBU, 
A.TRDACCT, 
131 STK_BIZ, 
'141' STK_BIZ_ACTION, 
A.STK_CODE, 
A.STK_CLS, 
FLOOR((C.STK_AVL % A.STK_LOT_SIZE)/2) AS ORDER_QTY,
A.STK_LOT_SIZE,
C.STK_AVL,
STK_SUB_CLS, 
'0' SECURITY_LEVEL,
(A.PRICE+ ROUND(B.STK_SPREAD/10000.000,3,1)) AS ORDER_PRICE 
FROM CTE_TJ2  A, STK_PRICE_UNIT B, STK_ASSET C
WHERE A.CUACCT_CODE = C.CUACCT_CODE AND A.STK_CODE=C.STK_CODE AND  A.STKBD = B.STKBD  AND A.STK_CLS=B.STK_CLS  AND B.STKBD=C.STKBD AND B.STK_CLS=C.STK_CLS  AND C.STK_AVL>0 AND (C.STK_AVL<A.STK_LOT_SIZE or(C.STK_AVL>A.STK_LOT_SIZE and C.STK_AVL % A.STK_LOT_SIZE<>0) )  AND B.STK_CLS = 'A'  AND A.PRICE BETWEEN B.BGN_PRICE/10000 AND B.END_PRICE/10000   --价格+价差逻辑处理                           
)--当 C.STK_AVL大于  A.STK_LOT_SIZE为TRUE： (C.STK_AVL > A.STK_LOT_SIZE and C.STK_AVL % A.STK_LOT_SIZE <> 0) 为TRUE，
--所以只有当 C.STK_AVL 不能整除 A.STK_LOT_SIZE 时，查询记录才返回


--深港通委托零股

SELECT TOP 1 '深港通全部卖出零股成功' AS name,'订单成功' AS result,A.*  FROM CTE_Zero1_131_141 A
UNION
SELECT TOP 1 '深港通部分卖出零股成功' AS name,'订单成功' AS result,A.*  FROM CTE_Zero2_131_141 A