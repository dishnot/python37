*** Settings ***
Documentation     -v CUST_MODE:1P1 -v TEST_ENV:66 -v MODE:1 \ -i 00_d_100_100_软加速 \
Default Tags      00_d_100_100_软加速    SZ_JJ    RJS    619
Resource          ../../../公共目录/配置信息/环境配置信息.robot
Resource          ../../../接口定义/金证/4.辅助功能.robot
Resource          ../../../公共目录/数据配置/交易信息.robot
Resource          ../../../业务流程/交易流程_公共/业务流程.robot

*** Test Cases ***
00_d_100_100_00001_深A债券ETF限价买入_软加速_已报
    普通交易委托流程    ${深A债券ETF证券信息_全局变量}    10000000000    1    50000

00_d_100_100_00002_深A债券ETF限价买入_软加速_全撤
    普通交易委托流程    ${深A债券ETF证券信息_全局变量}    100000000    1    50000

00_d_100_100_00003_深A债券ETF限价买入_软加速_部成
    普通交易委托流程    ${深A债券ETF证券信息_全局变量}    100000000    1    70000

00_d_100_100_00004_深A债券ETF限价买入_软加速_部撤
    普通交易委托流程    ${深A债券ETF证券信息_全局变量}    1000000    1    70000

00_d_100_100_00005_深A债券ETF限价买入_软加速_全成
    普通交易委托流程    ${深A债券ETF证券信息_全局变量}    100000000    1    10000

00_d_100_100_00006_深A债券ETF限价买入_软加速_废单
    普通交易委托流程    ${深A债券ETF证券信息_全局变量}    100000000    1    80000

00_d_100_101_00007_深A债券ETF限价卖出_软加速_已报
    普通交易委托流程    ${深A债券ETF证券信息_全局变量}    1    50000    50000

00_d_100_101_00008_深A债券ETF限价卖出_软加速_全撤
    普通交易委托流程    ${深A债券ETF证券信息_全局变量}    1    50000    50000

00_d_100_101_00009_深A债券ETF限价卖出_软加速_部成
    普通交易委托流程    ${深A债券ETF证券信息_全局变量}    1    70000    70000

00_d_100_101_00010_深A债券ETF限价卖出_软加速_部撤
    普通交易委托流程    ${深A债券ETF证券信息_全局变量}    1    70000    70000

00_d_100_101_00011_深A债券ETF限价卖出_软加速_全成
    普通交易委托流程    ${深A债券ETF证券信息_全局变量}    1    10000    10000

00_d_100_101_00012_深A债券ETF限价卖出_软加速_废单
    普通交易委托流程    ${深A债券ETF证券信息_全局变量}    1    80000    80000
