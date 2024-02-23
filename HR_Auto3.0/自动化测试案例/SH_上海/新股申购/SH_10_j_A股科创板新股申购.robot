*** Settings ***
Default Tags      10_j_100_113_00001    10
Resource          ../../../公共目录/配置信息/环境配置信息.robot
Resource          ../../../公共目录/数据配置/交易信息.robot
Resource          ../../../业务流程/交易流程_公共/业务流程.robot

*** Test Cases ***
10_j_100_113_00001_沪A科创板新股申购_已报
    [Documentation]    -v CUST_MODE:1P1 -v TEST_ENV:66 -v MODE:1 \ -i 10_j_100_113_00001
    新股申购委托流程    ${沪A科创板新股申购证券信息_全局变量}    5000
