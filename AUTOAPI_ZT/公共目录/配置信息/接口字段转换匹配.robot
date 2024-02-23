*** Setting ***
Resource          校验字段转换处理.robot

*** Variable ***
&{F400001中台-金证}    custCode=CUST_CODE    account=CUACCT_CODE    currency=CURRENCY    totalAsset=MARKET_VALUE    fundAsset=FUND_VALUE    fundAvailable=FUND_AVL    fundBalance=FUND_BLN    stockMarketValue=STK_VALUE
&{F900201中台-金证}    custCode=CUST_CODE    account=CUACCT_CODE    currency=CURRENCY    totalAsset=MARKET_VALUE    fundAsset=FUND_VALUE    fundAvailable=FUND_AVL    fundBalance=FUND_BLN    stockMarketValue=STK_VALUE
&{F900201中台-华锐}    custCode=cust_id    account=fund_account_id    fundAsset=leaves_value    fundAvailable=available_t1    totalAsset=total_asset    stockMarketValue=market_value
&{F900201中台-JZ}    custCode=user_code    account=account
&{F900202中台-金证}    custCode=CUST_CODE    account=CUACCT_CODE    currency=CURRENCY    fundAvailable=FUND_AVL
&{F400002中台-金证}    custCode=CUST_CODE    account=CUACCT_CODE    currency=CURRENCY    fundAvailable=FUND_AVL
&{F900202中台-华锐}    custCode=cust_id    account=fund_account_id    fundAvailable=available_t0
&{F900203中台-金证}    account=CUACCT_CODE    currency=CURRENCY    serialNo=SERIAL_NO    bizAmount=FUND_AVL_EFFECT
&{F400003中台-金证}    account=CUACCT_CODE    currency=CURRENCY    serialNo=SERIAL_NO    bizAmount=FUND_AVL_EFFECT
&{F900203中台-华锐}    account=fund_account_id    currency=currency    bizAmount=value
&{F900204中台-金证}    account=CUACCT_CODE    currency=CURRENCY    bizAmount=FUND_AVL
&{F400004中台-金证}    account=CUACCT_CODE    currency=CURRENCY    bizAmount=FUND_AVL
&{F900204中台-华锐}    account=fund_account_id    currency=currency    custCode=cust_id    bizAmount=transfer_value
&{F900000中台-金证}    custCode=CUST_CODE    custName=TRDACCT_NAME    account=CUACCT_CODE    isMultiNode=CUACCT_SYNC_FLAG    seat=STKPBU
&{F900000中台-华锐}    custCode=cust_id

*** KeyWords ***
STK_遍历字典并获取键和值
    [Arguments]    ${dictionary}    ${返回消息tsp}    ${返回消息测试系统}
    [Documentation]    ${keys.__len__()} 获取字典长度
    ${keys}    Get Dictionary Keys    ${dictionary}
    ${values}    Get Dictionary Values    ${dictionary}
    log    ${keys}
    log    ${values}
    FOR    ${index}    IN RANGE    ${keys.__len__()}
        ${key}    Set Variable    ${keys[${index}]}
        ${value}    Set Variable    ${values[${index}]}
        ${转换字段}    Run KeyWord If    '${接口名_全局变量}' in ('F900202','F400002') and ${划拨方向_全局变量}==2 and '${key}'=='fundAvailable'    字段转换    ${返回消息测试系统}
        ${value}    Run KeyWord If    '${接口名_全局变量}' in ('F900202','F400002') and ${划拨方向_全局变量}==2 and '${key}'=='fundAvailable'    Set Variable    ${转换字段}
        ...    ELSE    Set Variable    ${value}
        LOG    ${key}
        LOG    ${value}
        log    ${返回消息tsp}
        ${tsp字段}    Set Variable    ${返回消息tsp}[${key}]
        #${tsp字段}    Set Variable    ${tsp字段处理}[0]
        LOG    ${返回消息测试系统}
        LOG    ${返回消息测试系统[0]}[${value}]
        ${测试系统字段}    Run KeyWord If    '${接口名_全局变量}' in ('F900204','F400004') and '${key}'=='bizAmount'    Evaluate    ${划拨前资金}-${返回消息测试系统[0]}[${value}]
        ...    ELSE    Set Variable    ${返回消息测试系统[0]}[${value}]
        ${值是否是数字类型}=    Evaluate    isinstance(${tsp字段}, int)
        Run KeyWord If    '${值是否是数字类型}'=='True' and '${key}'!='serialNo'    Should Be Equal As Numbers    ${tsp字段}    ${测试系统字段}
        ...    ELSE    Should Be Equal As Strings    ${tsp字段}    ${测试系统字段}
        Log    TSP:${key}匹配测试系统的是:${value}
    END

ATP_遍历字典并获取键和值
    [Arguments]    ${dictionary}    ${返回消息tsp}    ${返回消息测试系统}
    [Documentation]    ${keys.__len__()} 获取字典长度
    ${keys}    Get Dictionary Keys    ${dictionary}
    ${values}    Get Dictionary Values    ${dictionary}
    log    ${keys}
    log    ${values}
    FOR    ${index}    IN RANGE    ${keys.__len__()}
        ${key}    Set Variable    ${keys[${index}]}
        ${value}    Set Variable    ${values[${index}]}
        LOG    ${key}
        LOG    ${value}
        log    ${返回消息tsp}
        ${tsp字段}    Set Variable    ${返回消息tsp}[${key}]
        #${tsp字段}    Set Variable    ${tsp字段处理}[0]
        LOG    ${返回消息测试系统}
        ${测试系统字段}    Set Variable    ${返回消息测试系统[0]}[${value}]
        ${值是否是数字类型}=    Evaluate    isinstance(${tsp字段}, int)
        Run KeyWord If    '${值是否是数字类型}'=='True' and '${key}'!='serialNo'    Should Be Equal As Numbers    ${tsp字段}    ${测试系统字段}
        ...    ELSE    Should Be Equal As Strings    ${tsp字段}    ${测试系统字段}
        Log    TSP:${key}匹配测试系统的是:${value}
    END

WFW_遍历字典并获取键和值
    [Arguments]    ${dictionary}    ${返回消息tsp}    ${返回消息测试系统}
    [Documentation]    ${keys.__len__()} 获取字典长度
    ${keys}    Get Dictionary Keys    ${dictionary}
    ${values}    Get Dictionary Values    ${dictionary}
    log    ${keys}
    log    ${values}
    FOR    ${index}    IN RANGE    ${keys.__len__()}
        ${key}    Set Variable    ${keys[${index}]}
        ${value}    Set Variable    ${values[${index}]}
        LOG    ${key}
        LOG    ${value}
        log    ${返回消息tsp}
        ${tsp字段}    Set Variable    ${返回消息tsp}[${key}]
        #${tsp字段}    Set Variable    ${tsp字段处理}[0]
        LOG    ${返回消息测试系统}
        ${测试系统字段}    Run KeyWord If    '${测试系统_全局变量}'=='WFW'    Set Variable    ${返回消息测试系统}[${value}]
        ${值是否是数字类型}=    Evaluate    isinstance(${tsp字段}, int)
        Run KeyWord If    '${值是否是数字类型}'=='True' and '${key}'!='serialNo'    Should Be Equal As Numbers    ${tsp字段}    ${测试系统字段}
        ...    ELSE    Should Be Equal As Strings    ${tsp字段}    ${测试系统字段}
        Log    TSP:${key}匹配测试系统的是:${value}
    END

转换字段遍历校验
    [Arguments]    ${返回消息tsp}    ${返回消息_测试系统}
    Run KeyWord If    '${接口名_全局变量}'=='F400001' and '${测试系统_全局变量}'=='STK'    STK_遍历字典并获取键和值    ${F400001中台-金证}    ${返回消息tsp}    ${返回消息_测试系统}
    ...    ELSE IF    '${接口名_全局变量}'=='F900201' and '${测试系统_全局变量}'=='STK'    STK_遍历字典并获取键和值    ${F900201中台-金证}    ${返回消息tsp}    ${返回消息_测试系统}
    ...    ELSE IF    '${接口名_全局变量}'=='F900202' and '${测试系统_全局变量}'=='STK'    STK_遍历字典并获取键和值    ${F900202中台-金证}    ${返回消息tsp}    ${返回消息_测试系统}
    ...    ELSE IF    '${接口名_全局变量}'=='F400002' and '${测试系统_全局变量}'=='STK'    STK_遍历字典并获取键和值    ${F400002中台-金证}    ${返回消息tsp}    ${返回消息_测试系统}
    ...    ELSE IF    '${接口名_全局变量}'=='F900203' and '${测试系统_全局变量}'=='STK'    STK_遍历字典并获取键和值    ${F900203中台-金证}    ${返回消息tsp}    ${返回消息_测试系统}
    ...    ELSE IF    '${接口名_全局变量}'=='F400003' and '${测试系统_全局变量}'=='STK'    STK_遍历字典并获取键和值    ${F400003中台-金证}    ${返回消息tsp}    ${返回消息_测试系统}
    ...    ELSE IF    '${接口名_全局变量}'=='F900204' and '${测试系统_全局变量}'=='STK'    STK_遍历字典并获取键和值    ${F900204中台-金证}    ${返回消息tsp}    ${返回消息_测试系统}
    ...    ELSE IF    '${接口名_全局变量}'=='F400004' and '${测试系统_全局变量}'=='STK'    STK_遍历字典并获取键和值    ${F400004中台-金证}    ${返回消息tsp}    ${返回消息_测试系统}
    ...    ELSE IF    '${接口名_全局变量}'=='F900202' and '${测试系统_全局变量}'=='ATP'    ATP_遍历字典并获取键和值    ${F900202中台-华锐}    ${返回消息tsp}    ${返回消息_测试系统}
    ...    ELSE IF    '${接口名_全局变量}'=='F900203' and '${测试系统_全局变量}'=='ATP'    ATP_遍历字典并获取键和值    ${F900202中台-华锐}    ${返回消息tsp}    ${返回消息_测试系统}
    ...    ELSE IF    '${接口名_全局变量}'=='F900204' and '${测试系统_全局变量}'=='ATP'    ATP_遍历字典并获取键和值    ${F900202中台-华锐}    ${返回消息tsp}    ${返回消息_测试系统}
    ...    ELSE IF    '${接口名_全局变量}'=='F900201' and '${测试系统_全局变量}'=='ATP'    ATP_遍历字典并获取键和值    ${F900201中台-华锐}    ${返回消息tsp}    ${返回消息_测试系统}
    ...    ELSE IF    '${接口名_全局变量}'=='F900201' and '${测试系统_全局变量}'=='WFW'    WFW_遍历字典并获取键和值    ${F900201中台-JZ}    ${返回消息tsp}    ${返回消息_测试系统}
    ...    ELSE IF    '${接口名_全局变量}'=='F900000' and '${测试系统_全局变量}'=='STK'    STK_遍历字典并获取键和值    ${F900000中台-金证}    ${返回消息tsp}    ${返回消息_测试系统}
    ...    ELSE IF    '${接口名_全局变量}'=='F900000' and '${测试系统_全局变量}'=='ATP'    ATP_遍历字典并获取键和值    ${F900000中台-华锐}    ${返回消息tsp}    ${返回消息_测试系统}
