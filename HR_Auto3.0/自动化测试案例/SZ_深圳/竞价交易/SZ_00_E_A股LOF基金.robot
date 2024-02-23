*** Settings ***
Documentation     -v CUST_MODE:1P1 -v TEST_ENV:66 -v MODE:1 \ -i 00_E_100_100
Default Tags      00_E_100_100    00    hr
Resource          ../../../公共目录/配置信息/环境配置信息.robot
Resource          ../../../公共目录/数据配置/交易信息.robot
Resource          ../../../业务流程/交易流程_公共/业务流程.robot

*** Test Cases ***
00_E_100_100_00001_深ALOF基金限价买入_已报
    普通交易委托流程    ${深A标准LOF证券信息_全局变量}    10000000    1    5000

00_E_100_100_00002_深ALOF基金限价买入_全撤
    普通交易委托流程    ${深A标准LOF证券信息_全局变量}    10000000    1    5000

00_E_100_100_00003_深ALOF基金限价买入_部成
    普通交易委托流程    ${深A标准LOF证券信息_全局变量}    10000000    1    2300

00_E_100_100_00004_深ALOF基金限价买入_部撤
    普通交易委托流程    ${深A标准LOF证券信息_全局变量}    10000000    1    2300

00_E_100_100_00005_深ALOF基金限价买入_全成
    普通交易委托流程    ${深A标准LOF证券信息_全局变量}    10000000    1    1000

00_E_100_100_00006_深ALOF基金限价买入_废单
    普通交易委托流程    ${深A标准LOF证券信息_全局变量}    1000    1    8000

00_E_100_101_00007_深ALOF基金限价卖出_已报
    普通交易委托流程    ${深A标准LOF证券信息_全局变量}    1000    5000    5000

00_E_100_101_00008_深ALOF基金限价卖出_全撤
    普通交易委托流程    ${深A标准LOF证券信息_全局变量}    100    5000    5000

00_E_100_101_00009_深ALOF基金限价卖出_部成
    普通交易委托流程    ${深A标准LOF证券信息_全局变量}    100    2300    2300

00_E_100_101_00010_深ALOF基金限价卖出_部撤
    普通交易委托流程    ${深A标准LOF证券信息_全局变量}    100    2300    2300

00_E_100_101_00011_深ALOF基金限价卖出_全成
    普通交易委托流程    ${深A标准LOF证券信息_全局变量}    100    1000    1000

00_E_100_101_00012_深ALOF基金限价卖出_废单
    普通交易委托流程    ${深A标准LOF证券信息_全局变量}    100    8000    8000
