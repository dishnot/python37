*** Settings ***
Documentation     -v CUST_MODE:1P1 -v TEST_ENV:66 -v MODE:1 \ -i 00_A_100_181_00001
Default Tags      00_A_100_181_00001    ETF
Resource          ../../../公共目录/配置信息/环境配置信息.robot
Resource          ../../../公共目录/数据配置/交易信息.robot
Resource          ../../../业务流程/交易流程_公共/业务流程.robot

*** Test Cases ***
10_A_100_187_00001_沪A跨境ETF申购_已报
    普通交易委托流程    ${沪A跨境ETF申购证券信息_全局变量}    1000    1    0

10_A_100_100_00002_沪A跨境ETF赎回买入_全成
    普通交易委托流程    ${沪A跨境ETF申购证券信息_全局变量}    1000    1    0

10_A_100_188_00003_沪A跨境ETF赎回_已报
    普通交易委托流程    ${沪A跨境ETF申购证券信息_全局变量}    1000    1    0
