*** Settings ***
Documentation     -v CUST_MODE:1P1 -v TEST_ENV:66 -v MODE:1 \ -i 00_H_100_165_00001 \
Default Tags      00_H_100_165_00001    hr    00
Resource          ../../../公共目录/配置信息/环境配置信息.robot
Resource          ../../../公共目录/数据配置/交易信息.robot
Resource          ../../../业务流程/交易流程_公共/业务流程.robot

*** Test Cases ***
00_H_100_165_00001_深A国债逆回购_已报
    普通交易委托流程    ${深A国债逆回购证券信息_全局变量}    1000000    5000    5000

00_H_100_165_00002_深A国债逆回购_全撤
    普通交易委托流程    ${深A国债逆回购证券信息_全局变量}    1000000    5000    5000

00_H_100_165_00003_深A国债逆回购_部成
    普通交易委托流程    ${深A国债逆回购证券信息_全局变量}    1000000    2300    2300

00_H_100_165_00004_深A国债逆回购_部撤
    普通交易委托流程    ${深A国债逆回购证券信息_全局变量}    1000000    2300    2300

00_H_100_165_00005_深A国债逆回购_全成
    普通交易委托流程    ${深A国债逆回购证券信息_全局变量}    1000000    1000    1000

00_H_100_165_00006_深A国债逆回购_废单
    普通交易委托流程    ${深A国债逆回购证券信息_全局变量}    1000000    8000    8000
