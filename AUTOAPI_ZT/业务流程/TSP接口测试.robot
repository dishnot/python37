*** Settings ***
Resource          ../公共目录/通用操作/常用关键字.robot
Resource          ../公共目录/配置信息/TSP环境配置信息.robot
Resource          ../公共目录/配置信息/POST接口调用.robot
Resource          ../公共目录/数据配置/账户信息.robot
Resource          ../公共目录/通用操作/数据库查询.robot
Resource          ../公共目录/配置信息/环境连接.robot
Resource          多系统业务流程.robot
Resource          检查点流程.robot
Resource          TSP对接流程.robot

*** Keywords ***
TSP接口测试
    [Arguments]    ${发生金额_全局变量}=100
    Set Global Variable    ${发生金额_全局变量}
    TSP用例名称转换为字典
    Run Keyword If    '${测试系统_全局变量}'=='STK'    中台对接订单
    ...    ELSE IF    '${测试系统_全局变量}'=='ATP'    中台对接华锐
    ...    ELSE IF    '${测试系统_全局变量}'=='WFW'    中台对接微服务

TSP_ATP测试
    中台对接华锐
