*** Settings ***
Force Tags
Default Tags      00_700    00_700_zqetf    A    LR_PT
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
00_d_100_700_00001_深A债券ETF担保品买入_已报
    业务流程    100

00_d_100_700_00002_深A债券ETF担保品买入_全撤
    业务流程    100

00_d_100_700_00003_深A债券ETF担保品买入_全成
    业务流程    100

00_d_100_700_00004_深A债券ETF担保品买入_废单
    业务流程    100

00_d_100_700_00005_深A债券ETF担保品买入_部成
    业务流程    100

00_d_100_700_00006_深A债券ETF担保品买入_部撤
    业务流程    100
