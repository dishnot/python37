*** Settings ***
Documentation     -v CUST_MODE:1P1 -v TEST_ENV:66 -v MODE:1 \ -i 00_A_100_106_软加速
Default Tags      00_A_100_106_软加速    SZ_JJ    RJS
Resource          ../../../公共目录/配置信息/环境配置信息.robot
Resource          ../../../接口定义/金证/4.辅助功能.robot
Resource          ../../../公共目录/数据配置/交易信息.robot
Resource          ../../../业务流程/交易流程_公共/业务流程.robot

*** Test Cases ***
00_A_100_106_00001_深A股票配股_软加速_已报
    普通交易委托流程    ${深A股票配股证券信息_全局变量}    1000000    5000    5000

00_A_100_106_00002_深A股票配股_软加速_全撤
    普通交易委托流程    ${深A股票配股证券信息_全局变量}    1000    100    100
