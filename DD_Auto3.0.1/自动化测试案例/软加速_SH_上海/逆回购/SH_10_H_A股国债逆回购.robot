*** Settings ***
Documentation     -v CUST_MODE:1P1 -v TEST_ENV:66 -v MODE:1 \ -i 10_L_100_165_软加速
Default Tags      SH_JJ    RJS    8619
Resource          ../../../公共目录/配置信息/环境配置信息.robot
Resource          ../../../接口定义/金证/4.辅助功能.robot
Resource          ../../../公共目录/数据配置/交易信息.robot
Resource          ../../../业务流程/交易流程_公共/业务流程.robot

*** Test Cases ***
10_H_100_165_00001_沪A国债逆回购_软加速_已报
    普通交易委托流程    ${沪A国债逆回购证券信息_全局变量}    1000000    50000    50000

10_H_100_165_00002_沪A国债逆回购_软加速_全撤
    普通交易委托流程    ${沪A国债逆回购证券信息_全局变量}    1000000    50000    50000

10_H_100_165_00003_沪A国债逆回购_软加速_部成
    普通交易委托流程    ${沪A国债逆回购证券信息_全局变量}    1000000    23000    23000

10_H_100_165_00004_沪A国债逆回购_软加速_部撤
    普通交易委托流程    ${沪A国债逆回购证券信息_全局变量}    1000000    23000    23000

10_H_100_165_00005_沪A国债逆回购_软加速_全成
    普通交易委托流程    ${沪A国债逆回购证券信息_全局变量}    1000000    10000    10000

10_H_100_165_00006_沪A国债逆回购_软加速_废单
    普通交易委托流程    ${沪A国债逆回购证券信息_全局变量}    1000000    80000    80000
