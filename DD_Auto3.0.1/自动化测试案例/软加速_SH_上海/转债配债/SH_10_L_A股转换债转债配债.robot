*** Settings ***
Documentation     -v CUST_MODE:1P1 -v TEST_ENV:66 -v MODE:1 \ -i 10_L_100_153_软加速
Default Tags      SH_JJ    RJS
Resource          ../../../公共目录/配置信息/环境配置信息.robot
Resource          ../../../接口定义/金证/4.辅助功能.robot
Resource          ../../../公共目录/数据配置/交易信息.robot
Resource          ../../../业务流程/交易流程_公共/业务流程.robot

*** Test Cases ***
10_L_100_153_00001_沪A转换债转债配债_软加速_已报
    普通交易委托流程    ${沪A转换债转债配债证券信息_全局变量}    1000    10000    100

10_L_100_153_00002_沪A转换债转债配债_软加速_全撤
    普通交易委托流程    ${沪A转换债转债配债证券信息_全局变量}    1000    10000    100
