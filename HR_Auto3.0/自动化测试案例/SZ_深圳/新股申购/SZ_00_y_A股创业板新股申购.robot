*** Settings ***
Documentation     -v CUST_MODE:1P1 -v TEST_ENV:66 -v MODE:1 \ -i 00_y_100_113_00001
Default Tags      00
Resource          ../../../公共目录/配置信息/环境配置信息.robot
Resource          ../../../公共目录/数据配置/交易信息.robot
Resource          ../../../业务流程/交易流程_公共/业务流程.robot

*** Test Cases ***
00_y_100_113_00001_深A创业板新股申购_已报
    新股申购委托流程    ${深A创业板新股申购证券信息_全局变量}    5000
