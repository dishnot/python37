*** Settings ***
Documentation     -v CUST_MODE:1P1 -v TEST_ENV:66 -v MODE:1 \ -i 00_e_100_100_软加速
Default Tags      00_e_100_100_软加速    SZ_JJ    RJS
Resource          ../../../公共目录/配置信息/环境配置信息.robot
Resource          ../../../接口定义/金证/4.辅助功能.robot
Resource          ../../../公共目录/数据配置/交易信息.robot
Resource          ../../../业务流程/交易流程_公共/业务流程.robot

*** Test Cases ***
00_e_100_100_00001_深A黄金ETF限价买入_软加速_已报
    普通交易委托流程    ${深A黄金ETF证券信息_全局变量}    100000    1    100

00_e_100_100_00002_深A黄金ETF限价买入_软加速_全撤
    普通交易委托流程    ${深A黄金ETF证券信息_全局变量}    100000    1    100

00_e_100_100_00003_深A黄金ETF限价买入_软加速_部成
    普通交易委托流程    ${深A黄金ETF证券信息_全局变量}    100000    1    200

00_e_100_100_00004_深A黄金ETF限价买入_软加速_部撤
    普通交易委托流程    ${深A黄金ETF证券信息_全局变量}    1000000    1    600

00_e_100_100_00005_深A黄金ETF限价买入_软加速_全成
    普通交易委托流程    ${深A黄金ETF证券信息_全局变量}    10000000    1    5000

00_e_100_100_00006_深A黄金ETF限价买入_软加速_废单
    普通交易委托流程    ${深A黄金ETF证券信息_全局变量}    1000    1    300

00_e_100_101_00007_深A黄金ETF限价卖出_软加速_已报
    普通交易委托流程    ${深A黄金ETF证券信息_全局变量}    1000    2000    100

00_e_100_101_00008_深A黄金ETF限价卖出_软加速_全撤
    普通交易委托流程    ${深A黄金ETF证券信息_全局变量}    100    2000    100

00_e_100_101_00009_深A黄金ETF限价卖出_软加速_部成
    普通交易委托流程    ${深A黄金ETF证券信息_全局变量}    100    2000    200

00_e_100_101_00010_深A黄金ETF限价卖出_软加速_部撤
    普通交易委托流程    ${深A黄金ETF证券信息_全局变量}    100    2000    400

00_e_100_101_00011_深A黄金ETF限价卖出_软加速_全成
    普通交易委托流程    ${深A黄金ETF证券信息_全局变量}    100    2000    500

00_e_100_101_00012_深A黄金ETF限价卖出_软加速_废单
    普通交易委托流程    ${深A黄金ETF证券信息_全局变量}    100    2000    300
