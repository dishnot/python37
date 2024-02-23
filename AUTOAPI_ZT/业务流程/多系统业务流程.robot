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
Resource          ../接口定义/微服务/集中接口.robot
Resource          ../公共目录/配置信息/接口入参数据.robot
Resource          检查点流程.robot
Resource          中台初始化流程.robot
Resource          TSP对接系统方初始化流程.robot
Resource          TSP匹配STK接口.robot
Resource          计算逻辑初始化数据.robot

*** Keywords ***
中台业务
    入参逻辑数据初始化
    Run KeyWord IF    '${接口名_全局变量}' in ('F900204','F400004')    初始化前数据
    ${接口}    中台获取接口流程
    ${返回码}    ${返回消息tsp}    ${返回码_SH}    ${返回消息tsp_SH}    ${返回码_SZ}    ${返回消息tsp_SZ}    Run KeyWord If    '${接口}' in ('F400001_快订资金查询','F900201_交易资金查询')    出参解析数据    ${接口}
    ...    ELSE    解析数据    ${接口}    #对市场入参逻辑处理
    LOG    TSP接口请求发送
    [Return]    ${返回码}    ${返回消息tsp}    ${返回码_SH}    ${返回消息tsp_SH}    ${返回码_SZ}    ${返回消息tsp_SZ}

订单业务
    [Arguments]    ${TEST_ENV}
    Set Global Variable    ${TEST_ENV}
    环境连接
    ${货币代码_全局变量}    Set Variable    0
    Set Global Variable    ${货币代码_全局变量}
    用户登录API_10301105
    ${返回码}    ${返回消息stk}    调用接口
    log    ${返回消息stk}
    [Return]    ${返回码}    ${返回消息stk}

华锐业务
    [Arguments]    ${TEST_ENV}
    Set Global Variable    ${TEST_ENV}
    环境连接
    登录_Web
    获取客户信息_web
    ReqCustLoginOther_账户登入函数
    ${返回码}    ${返回数据}    ReqFundQuery_资金查询
    [Return]    ${返回码}    ${返回数据}

微服务
    [Arguments]    ${uri}=${用例名_全局变量}
    ${环境地址}    通过对接系统取环境路径
    ${返回码}    ${返回消息}    RunKeyWord    502资金查询    ${环境地址}    ${uri}
    [Return]    ${返回码}    ${返回消息}
