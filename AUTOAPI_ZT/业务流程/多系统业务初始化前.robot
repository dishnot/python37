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
初始化前_订单业务
    [Arguments]    ${TEST_ENV}
    Set Global Variable    ${TEST_ENV}
    环境连接
    ${货币代码_全局变量}    Set Variable    0
    Set Global Variable    ${货币代码_全局变量}
    用户登录API_10301105
    ${返回码}    ${返回消息stk}    调用接口
    log    ${返回消息stk}
    ${划拨前资金}    Run KeyWord IF    '${接口名_全局变量}' in ('F900204','F400004')    Set Variable    ${返回消息stk[0]}[FUND_AVL]
    Set Global Variable    ${划拨前资金}
    log    ${划拨前资金}
    [Return]    ${返回码}    ${返回消息stk}
