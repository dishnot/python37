*** Settings ***
Documentation     -v CUST_MODE:1P1 -v TEST_ENV:66 -v MODE:1 \ -i 00_L_100_161_00001
...
...               证券在在STK_BOND_FJYXX 表里
Default Tags      00_L_100_161_00001    hr    00    XH
Resource          ../../../公共目录/配置信息/环境配置信息.robot
Resource          ../../../接口定义/金证/4.辅助功能.robot
Resource          ../../../公共目录/数据配置/交易信息.robot
Resource          ../../../业务流程/交易流程_公共/业务流程.robot

*** Test Cases ***
00_L_100_161_00001_深A转换债转债回售_已报
    [Documentation]    证券在回售期
    普通交易委托流程    ${深A转换债转债回售证券信息_全局变量}    1000000    5000    5000

00_L_100_161_00002_深A转换债转债回售_全撤
    普通交易委托流程    ${深A转换债转债回售证券信息_全局变量}    1000000    5000    5000
