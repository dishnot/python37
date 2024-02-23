*** Settings ***
Resource          ../公共目录/通用操作/常用关键字.robot
Resource          ../公共目录/配置信息/TSP环境配置信息.robot
Resource          ../公共目录/配置信息/POST接口调用.robot
Resource          ../公共目录/数据配置/账户信息.robot
Resource          ../接口定义/中台/F1接口.robot
Resource          ../接口定义/中台/F4接口.robot
Resource          ../接口定义/中台/F9接口.robot
Resource          ../公共目录/通用操作/数据库查询.robot
Resource          ../公共目录/配置信息/环境连接.robot
Resource          ../接口定义/金证/3.实时查询.robot
Resource          ../接口定义/金证/4.辅助功能.robot
Resource          ../接口定义/华锐/初始化接口.robot
Resource          ../接口定义/华锐/查询接口.robot
Resource          ../公共目录/配置信息/接口入参数据.robot
Resource          检查点流程.robot
Resource          中台初始化流程.robot

*** Keywords ***
入参逻辑数据初始化
    ${url}    Run KeyWord    通过接口名取环境路径    ${接口属性_全局变量}
    Set Global Variable    ${url}
    ${资金账户}    Run KeyWord    账户信息_全局变量
    Set Global Variable    ${资金账户}
    ${TSP客户号}    Run KeyWord    通过账户获取对应客户号
    Set Global Variable    ${TSP客户号}
    ${操作机构_全局变量}    Run KeyWord    通过账户获取对应机构号
    Set Global Variable    ${操作机构_全局变量}
    ${账户类别_全局变量}    Run KeyWord    通过账户获取对应账户类别
    Set Global Variable    ${账户类别_全局变量}
    Run KeyWord If    '${接口属性_全局变量}'=='F9'    F900000_客户登录    1    2
    Run KeyWord    固参逻辑取值
    ${单双中心标志}    Run KeyWord    通过账户获取对应双中心标志
    ${单双中心标志}    Convert To Integer    ${单双中心标志}
    Set Global Variable    ${单双中心标志}
    ${单中心节点}    Run KeyWord If    ${单双中心标志}==0    通过账户获取对应节点
    ${双中心节点_上海}    Run KeyWord If    ${单双中心标志}==1    上海账户对应节点
    ${双中心节点_深圳}    Run KeyWord If    ${单双中心标志}==1    深圳账户对应节点
    ${TEST_ENV}    Run KeyWord If    ${单双中心标志}==0    Set Variable    ${单中心节点}
    Set Global Variable    ${TEST_ENV}
    ${TEST_ENV_SH}    Run KeyWord If    ${单双中心标志}==1    Set Variable    ${双中心节点_上海}
    Set Global Variable    ${TEST_ENV_SH}
    ${TEST_ENV_SZ}    Run KeyWord If    ${单双中心标志}==1    Set Variable    ${双中心节点_深圳}
    Set Global Variable    ${TEST_ENV_SZ}

出参解析数据
    [Arguments]    ${接口}
    ${返回码}    ${返回消息tsp}    Run KeyWord If    ${单双中心标志}==0    ${接口}    ${url}    ${接口名_全局变量}
    log    ${返回消息tsp}
    ${返回码_SH}    ${返回消息tsp_SH}    Run KeyWord If    ${单双中心标志}==1    ${接口}    ${url}    ${接口名_全局变量}    1    #1为上海,0为深圳
    log    ${返回消息tsp_SH}
    ${返回码_SZ}    ${返回消息tsp_SZ}    Run KeyWord If    ${单双中心标志}==1    ${接口}    ${url}    ${接口名_全局变量}    0    #1为上海,0为深圳
    log    ${返回消息tsp_SZ}
    [Return]    ${返回码}    ${返回消息tsp}    ${返回码_SH}    ${返回消息tsp_SH}    ${返回码_SZ}    ${返回消息tsp_SZ}

解析数据
    [Arguments]    ${接口}
    ${返回码}    ${返回消息tsp}    Run KeyWord If    ${单双中心标志}==0    ${接口}    ${url}    ${接口名_全局变量}
    log    ${返回消息tsp}
    ${返回码_SH}    ${返回消息tsp_SH}    Run KeyWord If    ${单双中心标志}==1 and '${接口名_全局变量}' not in ('F900202','F400002','F900203','F400003','F900204','F400004')    ${接口}    ${url}    ${接口名_全局变量}
    log    ${返回消息tsp_SH}
    ${返回码_SZ}    ${返回消息tsp_SZ}    Run KeyWord If    ${单双中心标志}==1    ${接口}    ${url}    ${接口名_全局变量}
    log    ${返回消息tsp_SZ}
    [Return]    ${返回码}    ${返回消息tsp}    ${返回码_SH}    ${返回消息tsp_SH}    ${返回码_SZ}    ${返回消息tsp_SZ}

中台获取接口流程
    ${接口}    Run KeyWord If    '${接口名_全局变量}'=='F400001'    Set Variable    F400001_快订资金查询
    ...    ELSE IF    '${接口名_全局变量}'=='F900201'    Set Variable    F900201_交易资金查询
    ...    ELSE IF    '${接口名_全局变量}'=='F900202'    Set Variable    F900202_可划拨资金查询
    ...    ELSE IF    '${接口名_全局变量}'=='F900203'    Set Variable    F900203_交易资金划拨
    ...    ELSE IF    '${接口名_全局变量}'=='F900204'    Set Variable    F900204_资金划拨
    ...    ELSE IF    '${接口名_全局变量}'=='F400002'    Set Variable    F400002_资金划拨
    ...    ELSE IF    '${接口名_全局变量}'=='F400003'    Set Variable    F400003_双中心资金划拨
    ...    ELSE IF    '${接口名_全局变量}'=='F400004'    Set Variable    F400004_双中心资金划拨
    ...    ELSE IF    '${接口名_全局变量}'=='F900000'    Set Variable    F900000_客户登录
    [Return]    ${接口}
