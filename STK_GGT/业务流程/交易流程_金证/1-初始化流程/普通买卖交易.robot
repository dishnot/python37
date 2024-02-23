*** Settings ***
Resource          ../../../接口定义/金证/初始化接口.robot
Resource          通用初始化.robot

*** Keywords ***
金证_普通买卖初始化
    [Arguments]    ${调整资金}    ${调整股份}    ${权限}=${Empty}
    资金调整_10305004    ${调整资金}
    股份调整_10305005    ${调整股份}
    Run Keyword If    '${权限}'!='${Empty}'    交易初始化_权限    ${权限}
    log    ----交易数据处理----
    sleep    2
    ${变化数据}    Create List    可用资金查询_10303001    可用股份查询_10303002    CUACCT_FUND    STK_ASSET
    [Return]    ${变化数据}

金证_新股申购初始化
    [Arguments]    ${权限}=${Empty}
    Run Keyword If    '${权限}'!='${Empty}'    交易初始化_权限    ${权限}
    log    ----交易数据处理----
    sleep    2
    ${变化数据}    Create List    可用资金查询_10303001    CUACCT_FUND
    [Return]    ${变化数据}
