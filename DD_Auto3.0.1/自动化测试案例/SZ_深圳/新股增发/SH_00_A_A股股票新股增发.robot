*** Settings ***
Documentation     -v CUST_MODE:1P1 -v TEST_ENV:66 \ -i \ 10_A_100_113 \ \ \ -v MODE:0
Default Tags      10_A_100_113    XH
Resource          ../../../公共目录/配置信息/环境配置信息.robot
Resource          ../../../接口定义/金证/4.辅助功能.robot
Resource          ../../../公共目录/数据配置/交易信息.robot
Resource          ../../../业务流程/交易流程_公共/业务流程.robot

*** Test Cases ***
00_A_100_104_00001_深A股票新股增发_已报
    [Documentation]    -v CUST_MODE:1P1 -v TEST_ENV:66 -v MODE:1
    ...
    ...
    ...
    ...    股东市值额度设置，限定1000
    普通交易委托流程    ${深A股票新股增发证券信息_全局变量}    1000    1000    1000
