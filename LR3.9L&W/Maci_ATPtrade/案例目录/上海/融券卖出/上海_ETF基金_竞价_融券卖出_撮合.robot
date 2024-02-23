*** Settings ***
Force Tags
Default Tags      10_703    10_703_etfjj    A    LR_PT
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
10_D_100_703_00001_沪AETF基金融券卖出_已报
    业务流程    100

10_D_100_703_00002_沪AETF基金融券卖出_全撤
    业务流程    100

10_D_100_703_00003_沪AETF基金融券卖出_全成
    业务流程    100

10_D_100_703_00004_沪AETF基金融券卖出_废单
    业务流程    100

10_D_100_703_00005_沪AETF基金融券卖出_部成
    业务流程    100

10_D_100_703_00006_沪AETF基金融券卖出_部撤
    业务流程    100
