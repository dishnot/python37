*** Settings ***
Documentation     -v CUST_MODE:1P1 -v TEST_ENV:66 -v MODE:1 \ -i 10_H_100_100
Default Tags      10_H_100_100    hr    10
Resource          ../../../公共目录/配置信息/环境配置信息.robot
Resource          ../../../公共目录/数据配置/交易信息.robot
Resource          ../../../业务流程/交易流程_公共/业务流程.robot

*** Test Cases ***
10_H_100_100_00001_沪A国债限价买入_已报
    普通交易委托流程    ${沪A国债证券信息_全局变量}    1000000    1    50000

10_H_100_100_00002_沪A国债限价买入_全撤
    普通交易委托流程    ${沪A国债证券信息_全局变量}    1000000    1    50000

10_H_100_100_00003_沪A国债限价买入_部成
    普通交易委托流程    ${沪A国债证券信息_全局变量}    100000000    200    23000

10_H_100_100_00004_沪A国债限价买入_部撤
    普通交易委托流程    ${沪A国债证券信息_全局变量}    100000000    1    23000

10_H_100_100_00005_沪A国债限价买入_全成
    普通交易委托流程    ${沪A国债证券信息_全局变量}    1000000000    1    10000

10_H_100_100_00006_沪A国债限价买入_废单
    普通交易委托流程    ${沪A国债证券信息_全局变量}    1000    1    8000

10_H_100_101_00007_沪A国债限价卖出_已报
    普通交易委托流程    ${沪A国债证券信息_全局变量}    1000    5000    5000

10_H_100_101_00008_沪A国债限价卖出_全撤
    普通交易委托流程    ${沪A国债证券信息_全局变量}    1    50000    50000

10_H_100_101_00009_沪A国债限价卖出_部成
    普通交易委托流程    ${沪A国债证券信息_全局变量}    1    23000    23000

10_H_100_101_00010_沪A国债限价卖出_部撤
    普通交易委托流程    ${沪A国债证券信息_全局变量}    1    20000    23000

10_H_100_101_00011_沪A国债限价卖出_全成
    普通交易委托流程    ${沪A国债证券信息_全局变量}    1    10000    10000

10_H_100_101_00012_沪A国债限价卖出_废单
    普通交易委托流程    ${沪A国债证券信息_全局变量}    1    8000    8000
