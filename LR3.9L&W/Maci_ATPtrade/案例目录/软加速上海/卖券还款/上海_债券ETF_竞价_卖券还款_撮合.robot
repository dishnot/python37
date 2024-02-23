*** Settings ***
Force Tags
Default Tags      10_705_zqetf    rjs_10_705    LR_RJS
Resource          ../../../订单接口/3.实时查询.robot
Resource          ../../../订单接口/1.参数管理.robot
Resource          ../../../订单接口/2.实时交易.robot
Resource          ../../../订单接口/4.辅助功能.robot
Resource          ../../../订单接口/LBM查询接口.robot
Resource          ../../../订单接口/初始化接口.robot
Resource          ../../../公共目录/配置信息/环境配置信息.robot
Resource          ../../../公共目录/通用操作/常用关键字.robot
Resource          ../../../公共目录/通用操作/数据库操作.robot
Resource          ../../../业务流程/业务流程.robot

*** Test Cases ***
10_d_100_705_00001_软加速沪A债券ETF卖券还款_已报
    业务流程    100

10_d_100_705_00002_软加速沪A债券ETF卖券还款_全撤
    业务流程    100

10_d_100_705_00003_软加速沪A债券ETF卖券还款_全成
    业务流程    100

10_d_100_705_00004_软加速沪A债券ETF卖券还款_废单
    业务流程    100

10_d_100_705_00005_软加速沪A债券ETF卖券还款_部成
    业务流程    100

10_d_100_705_00006_软加速沪A债券ETF卖券还款_部撤
    业务流程    100
