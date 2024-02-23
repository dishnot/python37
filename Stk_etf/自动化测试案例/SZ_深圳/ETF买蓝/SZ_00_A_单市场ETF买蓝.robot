*** Settings ***
Documentation     -v CUST_MODE:1P1 -v TEST_ENV:66 -v MODE:1 \ -i 00_A_100_181_00001
Default Tags      00_A_100_181_00001
Resource          ../../../公共目录/配置信息/环境配置信息.robot
Resource          ../../../接口定义/金证/4.辅助功能.robot
Resource          ../../../公共目录/数据配置/交易信息.robot
Resource          ../../../业务流程/交易流程_公共/业务流程.robot

*** Test Cases ***
00_A_121_100_00001_深A单市场ETF买蓝_全成
    买蓝委托流程

00_A_121_101_00002_深A单市场ETF卖蓝_全成
    买蓝委托流程
