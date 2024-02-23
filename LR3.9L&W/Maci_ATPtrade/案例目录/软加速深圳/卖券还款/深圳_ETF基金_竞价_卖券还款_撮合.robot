*** Settings ***
Force Tags
Default Tags      rjs_00_705    00_705_etfjj    LR_RJS
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
00_D_100_705_00001_软加速深AETF基金卖券还款_已报
    业务流程    100

00_D_100_705_00002_软加速深AETF基金卖券还款_全撤
    业务流程    100

00_D_100_705_00003_软加速深AETF基金卖券还款_全成
    业务流程    100

00_D_100_705_00004_软加速深AETF基金卖券还款_废单
    业务流程    100

00_D_100_705_00005_软加速深AETF基金卖券还款_部成
    业务流程    100

00_D_100_705_00006_软加速深AETF基金卖券还款_部撤
    业务流程    100
