*** Settings ***
Resource          ../公共目录/配置信息/环境连接.robot
Resource          ../公共目录/配置信息/业务数据获取.robot
Resource          ../订单接口/3.实时查询.robot
Resource          ../订单接口/1.参数管理.robot
Resource          ../订单接口/2.实时交易.robot
Resource          ../订单接口/4.辅助功能.robot
Resource          ../订单接口/LBM查询接口.robot
Resource          ../业务流程/交易下单流程.robot
Resource          ../业务流程/检查点流程/交易后表的录制流程.robot

*** Keywords ***
业务流程
    [Arguments]    ${委托数量}
    两融环境连接
    log    --环境准备
    业务数据源    ${委托数量}
    log    --数据准备
    交易下单流程
    log    --交易开始
    普通买卖检查流程
    log    --数据校验

还款流程
    [Arguments]    ${委托金额}
    两融环境连接
    log    --环境准备
    还款数据源    ${委托金额}
    log    --数据准备
    交易下单流程
    log    --交易开始
    直接还款检查流程
    log    --数据校验
