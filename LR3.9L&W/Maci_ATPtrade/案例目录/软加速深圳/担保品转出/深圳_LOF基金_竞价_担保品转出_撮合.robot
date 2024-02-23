*** Settings ***
Force Tags
Default Tags      00_709    00_709_lofjj    LR_RJS
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
00_E_100_709_00001_深A软加速LOF基金担保品转出_已报
    业务流程    100

00_E_100_709_00002_深A软加速LOF基金担保品转出_全撤
    业务流程    100
