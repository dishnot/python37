*** Settings ***
Documentation     -v CUST_MODE:1P1 -v TEST_ENV:66 -v MODE:1 \ -i 10_L_100_161_00001
...
...               证券在STK_BOND_FJYXX表中
Default Tags      10_L_100_161_00001    100    10    XH    11
Resource          ../../../公共目录/配置信息/环境配置信息.robot
Resource          ../../../接口定义/金证/4.辅助功能.robot
Resource          ../../../公共目录/数据配置/交易信息.robot
Resource          ../../../业务流程/交易流程_公共/业务流程.robot

*** Test Cases ***
10_L_100_161_00001_沪A转换债转债回售_已报
    普通交易委托流程    ${沪A转换债转债回售证券信息_全局变量}    1000    100    100

10_L_100_161_00002_沪A转换债转债回售_全撤
    普通交易委托流程    ${沪A转换债转债回售证券信息_全局变量}    1000    100    100
