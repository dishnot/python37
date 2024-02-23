*** Setting ***
Resource          多系统初始化前数据.robot

*** Keywords ***
初始化前数据
    Run KeyWord IF    '${测试系统_全局变量}'=='STK'    STK_计算需要初始化前数据
    ...    ELSE IF    '${测试系统_全局变量}'=='ATP'    ATP_计算需要初始化前数据
