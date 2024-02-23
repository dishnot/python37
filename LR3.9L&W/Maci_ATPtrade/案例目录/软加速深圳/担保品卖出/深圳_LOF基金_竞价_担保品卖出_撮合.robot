*** Settings ***
Force Tags
Default Tags      rjs_00_701    00_701_lofjj    LR_RJS
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
00_E_100_701_00001_软加速深ALOF基金担保品卖出_已报
    业务流程    100

00_E_100_701_00002_软加速深ALOF基金担保品卖出_全撤
    业务流程    100

00_E_100_701_00003_软加速深ALOF基金担保品卖出_全成
    业务流程    100

00_E_100_701_00004_软加速深ALOF基金担保品卖出_废单
    业务流程    100

00_E_100_701_00005_软加速深ALOF基金担保品卖出_部成
    业务流程    100

00_E_100_701_00006_软加速深ALOF基金担保品卖出_部撤
    业务流程    100
