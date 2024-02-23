*** Settings ***
Force Tags
Default Tags      10_700_zqetf    rjs_10_700    LR_RJS
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
10_d_100_700_00001_软加速沪A债券ETF担保品买入_已报
    业务流程    100

10_d_100_700_00002_软加速沪A债券ETF担保品买入_全撤
    业务流程    100

10_d_100_700_00003_软加速沪A债券ETF担保品买入_全成
    业务流程    100

10_d_100_700_00004_软加速沪A债券ETF担保品买入_废单
    业务流程    100

10_d_100_700_00005_软加速沪A债券ETF担保品买入_部成
    业务流程    100

10_d_100_700_00006_软加速沪A债券ETF担保品买入_部撤
    业务流程    100
