*** Settings ***
Force Tags
Default Tags      LR_RJS
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
0_2_直接还款_1_2_10_RJS
    还款流程    10

0_2_直接还款_0_1_10_RJS
    还款流程    10

0_2_直接还款_0_2_10_RJS
    还款流程    10

0_2_直接还款_3_2_10_RJS
    还款流程    10

0_2_直接还款_0_0_10_RJS
    还款流程    10

0_2_直接还款_3_0_10_RJS
    还款流程    10

0_2_直接还款_3_1_10_RJS
    还款流程    10

0_2_直接还款_1_0_10_RJS
    还款流程    10

0_2_直接还款_1_1_10_RJS
    还款流程    10
