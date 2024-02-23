*** Settings ***
Resource          ../../公共目录/通用操作/数据库操作.robot
Resource          ../../公共目录/通用操作/固定参数设置.robot
Resource          ../../公共目录/通用操作/数据库业务数据源操作.robot
Resource          ../../公共目录/通用操作/证券参数设置.robot

*** Keywords ***
业务数据源
    [Arguments]    ${委托数量}
    用例名称转换为字典
    交易单元参数
    #账户代码参数
    证券代码参数
    ${账户数据}    Run Keyword    接口入参数据源    ${委托数量}
    log    ${账户数据}

还款数据源
    [Arguments]    ${委托金额}
    直接还款用例名称转换为字典
    时间戳设置
    ${偿还金额_全局变量}    Set Variable    ${委托金额}
    Set Global Variable    ${偿还金额_全局变量}
    ${合约类型_全局变量}    Run KeyWord If    '${偿还类型_全局变量}'=='0'    Set Variable    0','1
    ...    ELSE IF    '${偿还类型_全局变量}'=='1'    Set Variable    1
    ...    ELSE IF    '${偿还类型_全局变量}'=='3'    Set Variable    0
    Set Global Variable    ${合约类型_全局变量}
