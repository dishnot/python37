*** Settings ***
Force Tags
Default Tags      00_705_kjhgsz    00_705    LR_PT
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
00_0_100_705_00001_深A可交换公司债卖券还款_已报
    业务流程    1000

00_0_100_705_00002_深A可交换公司债卖券还款_全撤
    业务流程    1000

00_0_100_705_00003_深A可交换公司债卖券还款_全成
    业务流程    1000

00_0_100_705_00004_深A可交换公司债卖券还款_废单
    业务流程    1000

00_0_100_705_00005_深A可交换公司债卖券还款_部成
    业务流程    1000

00_0_100_705_00006_深A可交换公司债卖券还款_部撤
    业务流程    1000
