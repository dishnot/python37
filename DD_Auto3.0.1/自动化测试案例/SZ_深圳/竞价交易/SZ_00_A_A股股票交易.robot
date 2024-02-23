*** Settings ***
Documentation     -v CUST_MODE:1P1 -v TEST_ENV:66 -v MODE:1 \ -i 00_A_100_100
Default Tags      00_A_100_100    00    hr    XH    12
Resource          ../../../公共目录/配置信息/环境配置信息.robot
Resource          ../../../接口定义/金证/4.辅助功能.robot
Resource          ../../../公共目录/数据配置/交易信息.robot
Resource          ../../../业务流程/交易流程_公共/业务流程.robot

*** Test Cases ***
00_A_100_100_00001_深A股票限价买入_已报
    普通交易委托流程    ${深A股票证券信息_全局变量}    1000000    1    5000

00_A_100_100_00002_深A股票限价买入_全撤
    普通交易委托流程    ${深A股票证券信息_全局变量}    1000000    1    5000

00_A_100_100_00003_深A股票限价买入_部成
    普通交易委托流程    ${深A股票证券信息_全局变量}    1000000    1    2300

00_A_100_100_00004_深A股票限价买入_部撤
    普通交易委托流程    ${深A股票证券信息_全局变量}    10000000    1    2300

00_A_100_100_00005_深A股票限价买入_全成
    普通交易委托流程    ${深A股票证券信息_全局变量}    10000000    1    1000

00_A_100_100_00006_深A股票限价买入_废单
    普通交易委托流程    ${深A股票证券信息_全局变量}    1000000    1    8000

00_A_100_101_00007_深A股票限价卖出_已报
    普通交易委托流程    ${深A股票证券信息_全局变量}    1000    5000    5000

00_A_100_101_00008_深A股票限价卖出_全撤
    普通交易委托流程    ${深A股票证券信息_全局变量}    100    5000    5000

00_A_100_101_00009_深A股票限价卖出_部成
    普通交易委托流程    ${深A股票证券信息_全局变量}    10000    2300    2300

00_A_100_101_00010_深A股票限价卖出_部撤
    普通交易委托流程    ${深A股票证券信息_全局变量}    10000    2300    2300

00_A_100_101_00011_深A股票限价卖出_全成
    普通交易委托流程    ${深A股票证券信息_全局变量}    10000    1000    1000

00_A_100_101_00012_深A股票限价卖出_废单
    普通交易委托流程    ${深A股票证券信息_全局变量}    10000    7000    8000
