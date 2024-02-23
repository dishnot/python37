*** Settings ***
Documentation     -v CUST_MODE:1P1 -v TEST_ENV:66 -v MODE:1 \ -i 00_A_100_181_00001
Default Tags      00_A_100_181_00001    XH
Resource          ../../../公共目录/配置信息/环境配置信息.robot
Resource          ../../../接口定义/金证/4.辅助功能.robot
Resource          ../../../公共目录/数据配置/交易信息.robot
Resource          ../../../业务流程/交易流程_公共/业务流程.robot

*** Test Cases ***
00_A_100_181_00001_深A单市场股票ETF申购_已报
    普通交易委托流程    ${深A单市场股票ETF申购证券信息_全局变量}    1000    1    250000    ${ETF申赎协议}

00_A_100_181_00002_深A单市场股票ETF申购_全成
    普通交易委托流程    ${深A单市场股票ETF申购证券信息_全局变量}    1000    1    250000    ${ETF申赎协议}
