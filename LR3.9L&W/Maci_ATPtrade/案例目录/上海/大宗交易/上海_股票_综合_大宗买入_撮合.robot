*** Settings ***
Force Tags
Default Tags      10_982    10_982_gp    LR_PT
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
10_A_100_982_00001_沪A股票大宗买入_已报
    业务流程    510000

10_A_100_982_00002_沪A股票大宗买入_全撤
    业务流程    510000

10_A_100_982_00003_沪A股票大宗买入_全成
    业务流程    350000

10_A_100_982_00004_沪A股票大宗买入_废单
    业务流程    410000
