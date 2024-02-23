*** Settings ***
Resource          ../公共目录/配置信息/环境连接.robot
Resource          ../公共目录/配置信息/业务数据获取.robot
Resource          ../订单接口/3.实时查询.robot
Resource          ../订单接口/1.参数管理.robot
Resource          ../订单接口/2.实时交易.robot
Resource          ../订单接口/4.辅助功能.robot
Resource          ../订单接口/LBM查询接口.robot
Resource          初始化流程/交易前初始化.robot
Resource          ../业务流程/订单委托流程/下单委托流程.robot

*** Keywords ***
交易下单流程
    Run KeyWord If    '${证券业务_全局变量}'!='直接还款'    交易前初始化
    ...    ELSE    直接还款交易前初始化
    Run KeyWord If    '${证券业务_全局变量}'!='直接还款'    买卖下单流程
    ...    ELSE IF    '${证券业务_全局变量}'=='直接还款'    直接还款下单流程
