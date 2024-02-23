*** Settings ***
Force Tags
Default Tags      rjs_10_704    10_704_hjetf    LR_RJS
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
10_e_100_704_00001_软加速沪A黄金ETF买券还券_已报
    业务流程    100

10_e_100_704_00002_软加速沪A黄金ETF买券还券_全撤
    业务流程    100

10_e_100_704_00003_软加速沪A黄金ETF买券还券_全成
    业务流程    100

10_e_100_704_00004_软加速沪A黄金ETF买券还券_废单
    业务流程    100

10_e_100_704_00005_软加速沪A黄金ETF买券还券_部成
    业务流程    100

10_e_100_704_00006_软加速沪A黄金ETF买券还券_部撤
    业务流程    100
