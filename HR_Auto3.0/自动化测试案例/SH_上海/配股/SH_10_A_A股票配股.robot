*** Settings ***
Documentation     -v CUST_MODE:1P1 -v TEST_ENV:66 -v MODE:1 \ -i 10_A_100_106_00001
Default Tags      10
Resource          ../../../公共目录/配置信息/环境配置信息.robot
Resource          ../../../公共目录/数据配置/交易信息.robot
Resource          ../../../业务流程/交易流程_公共/业务流程.robot

*** Test Cases ***
10_A_100_106_00001_沪A股票配股_已报
    普通交易委托流程    ${沪A股票配股证券信息_全局变量}    1000    10000    5000
