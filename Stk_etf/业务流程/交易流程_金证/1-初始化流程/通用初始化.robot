*** Settings ***
Resource          ../../../接口定义/金证/3.实时查询.robot
Resource          ../../../接口定义/金证/4.辅助功能.robot
Resource          ../../../接口定义/金证/初始化接口.robot

*** Keywords ***
金证_客户与证券信息查询
    [Documentation]    1.20211123 chm 新增
    用户登录API_10301105
    证券信息查询_10301001

交易初始化_权限
    [Arguments]    ${权限}
    [Documentation]    1.20211123 chm 新增
    ...
    ...    规则：1.多个协议，多个协议用“|”隔开，单个无需用隔开
    ...    2.某个协议只签署，另外一个不签署，在协议后加“=”，条件为以下几种情况
    ...    权限未开通写法为：权限未开通
    ...    3.无需签署协议用${EMPTY}表示，如果是单个无需入参，以给默认值
    ...    4.协议开通，无需添加“=条件“
    ...
    ...    以下为目前考虑到场景的列子
    ...    1.单个协议开通：”2k“，多个协议开通”2h|2k"
    ...    2.多个协议开通一个："2k=权限开通|2h=权限未开通"
    ${权限_list}    Split String    ${权限}    |
    FOR    ${权限}    IN    @{权限_list}
        ${Status}    Run Keyword And Return Status    Should Contain    ${权限}    =
        ${签署权限}    Run Keyword If    ${Status}    Fetch From Left    ${权限}    =
        ...    ELSE    Set Variable    ${权限}
        comment    #查询权限
        ${是否存在权限}    交易协议临时查询_10304103    ${签署权限}
        ${用例场景}    Run Keyword If    ${Status}    Fetch From Right    ${权限}    =
        ...    ELSE IF    '${权限}'=='${EMPTY}'    Set Variable    权限未开通
        ...    ELSE    Set Variable    权限开通
        ${修改类型}    Run Keyword If    '${用例场景}'=='权限开通'and '${是否存在权限}'=='False'    Set Variable    0
        ...    ELSE IF    '${用例场景}'=='权限开通'and '${是否存在权限}'=='True'    Set Variable    1
        ...    ELSE IF    '${用例场景}'=='权限未开通'    Set Variable    2
        ${MSG}    ${MSG_LEVEL}    ${MSG_TEXT}    交易协议临时设置_10304104    ${签署权限}    ${修改类型}
    END

金证_买蓝客户与证券信息查询
    用户登录API_10301105
    证券信息查询_10301001
    ${ETF_MODE}    Run Keyword If    '${交易板块_全局变量}'=='00'and '${证券业务_全局变量}'in('825','826')    Set Variable    2
    ...    ELSE    Set Variable    0
    ${ETF_MODE_全局变量}    Set Variable    ${ETF_MODE}
    Set Global Variable    ${ETF_MODE_全局变量}
    ETF信息查询_10301016
