*** Settings ***
Documentation     -v CUST_MODE:1P1 -v TEST_ENV:66 -v MODE:1 \ -i 10_M_100_100
Default Tags      10_M_100_100    100    10    XH    10_ZQ
Resource          ../../../公共目录/配置信息/环境配置信息.robot
Resource          ../../../接口定义/金证/4.辅助功能.robot
Resource          ../../../公共目录/数据配置/交易信息.robot
Resource          ../../../业务流程/交易流程_公共/业务流程.robot

*** Test Cases ***
10_M_100_100_00001_沪A公司债限价买入_已报
    普通交易委托流程    ${沪A公司债证券信息_全局变量}    1000000000    1    50000

10_M_100_100_00002_沪A公司债限价买入_全撤
    普通交易委托流程    ${沪A公司债证券信息_全局变量}    1000000000    1    50000

10_M_100_100_00003_沪A公司债限价买入_部成
    普通交易委托流程    ${沪A公司债证券信息_全局变量}    1000000000    1    23000

10_M_100_100_00004_沪A公司债限价买入_部撤
    普通交易委托流程    ${沪A公司债证券信息_全局变量}    1000000000    1    23000

10_M_100_100_00005_沪A公司债限价买入_全成
    普通交易委托流程    ${沪A公司债证券信息_全局变量}    10000000    1    100000

10_M_100_100_00006_沪A公司债限价买入_废单
    普通交易委托流程    ${沪A公司债证券信息_全局变量}    100000000    1    80000

10_M_100_101_00007_沪A公司债限价卖出_已报
    普通交易委托流程    ${沪A公司债证券信息_全局变量}    1    50000    50000

10_M_100_101_00008_沪A公司债限价卖出_全撤
    普通交易委托流程    ${沪A公司债证券信息_全局变量}    1    50000    50000

10_M_100_101_00009_沪A公司债限价卖出_部成
    普通交易委托流程    ${沪A公司债证券信息_全局变量}    1    23000    23000

10_M_100_101_00010_沪A公司债限价卖出_部撤
    普通交易委托流程    ${沪A公司债证券信息_全局变量}    1    23000    23000

10_M_100_101_00011_沪A公司债限价卖出_全成
    普通交易委托流程    ${沪A公司债证券信息_全局变量}    1    10000    10000

10_M_100_101_00012_沪A公司债限价卖出_废单
    普通交易委托流程    ${沪A公司债证券信息_全局变量}    1    80000    8000
