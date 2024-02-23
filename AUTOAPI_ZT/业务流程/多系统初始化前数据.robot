*** Setting ***
Resource          多系统业务初始化前.robot

*** Keywords ***
STK_计算需要初始化前数据
    ${单中心返回码STK}    ${单中心返回消息STK}    ${双中心返回码STK_SH}    ${双中心返回消息STK_SH}    ${双中心返回码STK_SZ}    ${双中心返回消息STK_SZ}    系统数据    初始化前_订单业务
    Log    ${划拨前资金}

ATP_计算需要初始化前数据
