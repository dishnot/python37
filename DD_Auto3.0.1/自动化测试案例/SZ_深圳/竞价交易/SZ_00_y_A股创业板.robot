*** Settings ***
Documentation     -v CUST_MODE:1P1 -v TEST_ENV:66 -v MODE:1 \ -i 00_y_100_100
Default Tags      00_y_100_100    00    hr    XH    12
Resource          ../../../公共目录/配置信息/环境配置信息.robot
Resource          ../../../接口定义/金证/4.辅助功能.robot
Resource          ../../../公共目录/数据配置/交易信息.robot
Resource          ../../../业务流程/交易流程_公共/业务流程.robot
Resource          ../../../公共目录/数据配置/交易协议.robot

*** Test Cases ***
00_y_100_100_00001_深A创业板限价买入_已报
    普通交易委托流程    ${深A创业板证券信息_全局变量}    10000    1    5000    ${创业板协议}

00_y_100_100_00002_深A创业板限价买入_全撤
    普通交易委托流程    ${深A创业板证券信息_全局变量}    1000    1    5000    ${创业板协议}

00_y_100_100_00003_深A创业板限价买入_部成
    普通交易委托流程    ${深A创业板证券信息_全局变量}    10000    1    1000    ${创业板协议}

00_y_100_100_00004_深A创业板限价买入_部撤
    普通交易委托流程    ${深A创业板证券信息_全局变量}    100000    1    2300    ${创业板协议}

00_y_100_100_00005_深A创业板限价买入_全成
    普通交易委托流程    ${深A创业板证券信息_全局变量}    100000    1    1000    ${创业板协议}

00_y_100_100_00006_深A创业板限价买入_废单
    普通交易委托流程    ${深A创业板证券信息_全局变量}    1000    1    8000    ${创业板协议}

00_y_100_101_00007_深A创业板限价卖出_已报
    普通交易委托流程    ${深A创业板证券信息_全局变量}    1000    5000    5000    ${创业板协议}

00_y_100_101_00008_深A创业板限价卖出_全撤
    普通交易委托流程    ${深A创业板证券信息_全局变量}    1    5000    5000    ${创业板协议}

00_y_100_101_00009_深A创业板限价卖出_部成
    普通交易委托流程    ${深A创业板证券信息_全局变量}    1    2300    2300    ${创业板协议}

00_y_100_101_00010_深A创业板限价卖出_部撤
    普通交易委托流程    ${深A创业板证券信息_全局变量}    1    2300    2300    ${创业板协议}

00_y_100_101_00011_深A创业板限价卖出_全成
    普通交易委托流程    ${深A创业板证券信息_全局变量}    1    1000    1000    ${创业板协议}

00_y_100_101_00012_深A创业板限价卖出_废单
    普通交易委托流程    ${深A创业板证券信息_全局变量}    1    8000    8000    ${创业板协议}

00_y_100_120_00013_深A创业板盘后固定价格买入_已报
    [Tags]    00_y_100_100盘后
    普通交易委托流程    ${深A创业板证券信息_全局变量}    1000    1    200    ${创业板协议}

00_y_100_120_00014_深A创业板盘后固定价格买入_全撤
    [Tags]    00_y_100_100盘后
    普通交易委托流程    ${深A创业板证券信息_全局变量}    1000    1    200    ${创业板协议}

00_y_100_120_00015_深A创业板盘后固定价格买入_部成
    [Tags]    00_y_100_100盘后
    普通交易委托流程    ${深A创业板证券信息_全局变量}    1000    1    1000    ${创业板协议}

00_y_100_120_00016_深A创业板盘后固定价格买入_部撤
    [Tags]    00_y_100_100盘后
    普通交易委托流程    ${深A创业板证券信息_全局变量}    100000    1    6000    ${创业板协议}

00_y_100_120_00017_深A创业板盘后固定价格买入_全成
    [Tags]    00_y_100_100盘后
    普通交易委托流程    ${深A创业板证券信息_全局变量}    100000    1    500    ${创业板协议}

00_y_100_120_00018_深A创业板盘后固定价格买入_废单
    [Tags]    00_y_100_100盘后
    普通交易委托流程    ${深A创业板证券信息_全局变量}    1000    1    300    ${创业板协议}

00_y_100_121_00019_深A创业板盘后固定价格卖出_已报
    [Tags]    00_y_100_100盘后
    普通交易委托流程    ${深A创业板证券信息_全局变量}    1000    2000    200    ${创业板协议}

00_y_100_121_00020_深A创业板盘后固定价格卖出_全撤
    [Tags]    00_y_100_100盘后
    普通交易委托流程    ${深A创业板证券信息_全局变量}    10    2000    200    ${创业板协议}

00_y_100_121_00021_深A创业板盘后固定价格卖出_部成
    [Tags]    00_y_100_100盘后
    普通交易委托流程    ${深A创业板证券信息_全局变量}    10    2000    1000    ${创业板协议}

00_y_100_121_00022_深A创业板盘后固定价格卖出_部撤
    [Tags]    00_y_100_100盘后
    普通交易委托流程    ${深A创业板证券信息_全局变量}    10    2000    400    ${创业板协议}

00_y_100_121_00023_深A创业板盘后固定价格卖出_全成
    [Tags]    00_y_100_100盘后
    普通交易委托流程    ${深A创业板证券信息_全局变量}    10    2000    500    ${创业板协议}

00_y_100_121_00024_深A创业板盘后固定价格卖出_废单
    [Tags]    00_y_100_100盘后
    普通交易委托流程    ${深A创业板证券信息_全局变量}    10    2000    300    ${创业板协议}
