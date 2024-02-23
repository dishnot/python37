*** Settings ***
Documentation     -v CUST_MODE:1P1 -v TEST_ENV:66 -v MODE:1 \ -i 00_A_100_181_00001
Default Tags      00_A_100_181_00001    ETF
Resource          ../../../公共目录/配置信息/环境配置信息.robot
Resource          ../../../接口定义/金证/4.辅助功能.robot
Resource          ../../../公共目录/数据配置/交易信息.robot
Resource          ../../../业务流程/交易流程_公共/业务流程.robot

*** Test Cases ***
10_A_121_100_00001_沪A单市场ETF买篮_全成
    买蓝委托流程

10_A_100_181_00002_沪A单市场ETF申购_全成
    普通交易委托流程    ${沪A单市场股票ETF信息_全局变量}

10_A_100_101_00003_沪A单市场ETF卖出_全成
    普通交易委托流程    ${沪A单市场股票ETF信息_全局变量}

10_A_100_100_00004_沪A单市场ETF赎回买入_全成
    普通交易委托流程    ${沪A单市场股票ETF信息_全局变量}

10_A_100_182_00005_沪A单市场ETF赎回_全成
    普通交易委托流程    ${沪A单市场股票ETF信息_全局变量}

10_A_121_101_00006_沪A单市场ETF卖出_篮子卖出_全成
    买蓝委托流程
