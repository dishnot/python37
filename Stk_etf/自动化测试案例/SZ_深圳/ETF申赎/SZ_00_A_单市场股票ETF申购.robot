*** Settings ***
Default Tags      ETF
Resource          ../../../公共目录/配置信息/环境配置信息.robot
Resource          ../../../接口定义/金证/4.辅助功能.robot
Resource          ../../../公共目录/数据配置/交易信息.robot
Resource          ../../../业务流程/交易流程_公共/业务流程.robot

*** Test Cases ***
00_A_121_100_00001_深A单市场ETF申购买蓝成分股_全成
    买蓝委托流程

00_A_100_181_00002_深A单市场ETF申购_全成
    普通交易委托流程    ${深A单市场股票ETF证券信息_全局变量}

00_A_100_101_00003_深A单市场ETF卖出_部成
    普通交易委托流程    ${深A单市场股票ETF证券信息_全局变量}

00_A_100_100_00004_深A单市场ETF赎回买入_部成
    普通交易委托流程    ${深A单市场股票ETF证券信息_全局变量}

00_A_100_182_00005_深A单市场ETF赎回_全成
    普通交易委托流程    ${深A单市场股票ETF证券信息_全局变量}

00_A_121_101_00006_深A单市场ETF卖出_篮子成分股卖出_全成
    买蓝委托流程
