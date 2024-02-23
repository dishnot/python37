*** Settings ***
Resource          ../../../公共目录/通用操作/常用关键字.robot
Resource          通用初始化.robot
Resource          ../../交易流程_金证/1-初始化流程/普通买卖交易.robot
Resource          ../3-检查点流程/公共/计算该笔委托的值_取值计算录制模式.robot

*** Keywords ***
普通买卖交易初始化流程
    [Arguments]    ${交易信息}    ${资金初始化}    ${股份初始化}    ${委托数量}    ${权限}=${Empty}
    用例名称转换为字典
    客户与证券信息查询    ${交易信息}    ${委托数量}
    Set Global Variable    ${资金初始化}
    Set Global Variable    ${股份初始化}
    Set Global Variable    ${权限}
    普通买卖初始化

普通买卖初始化
    [Arguments]    ${调整资金}=${资金初始化}    ${调整股份}=${股份初始化}    ${权限}=${Empty}    ${接口类型}=${接口类型_全局变量}
    #${变化数据_金证}    Run Keyword If    '${接口类型}'=='Stk'    金证_普通买卖初始化    ${调整资金}    ${调整股份}
    ${变化数据_金证}    Create List    可用资金查询_10303001    可用股份查询_10303002    CUACCT_FUND    STK_ASSET
    ${变化数据}    Run Keyword If    '${接口类型}'=='Stk'    Set Variable    ${变化数据_金证}
    ${字段提取_需计算_委托前_全局变量}    ${字段提取_无需计算_委托前}    接口/表取值流程_取值计算录制模式    ${变化数据}
    Set Global Variable    ${字段提取_需计算_委托前_全局变量}
    log    ${字段提取_需计算_委托前_全局变量}

新股申购初始化流程
    [Arguments]    ${交易信息}    ${委托数量}    ${权限}=${Empty}
    用例名称转换为字典
    客户与证券信息查询    ${交易信息}    ${委托数量}
    Set Global Variable    ${权限}
    新股申购初始化

新股申购初始化
    [Arguments]    ${权限}=${Empty}    ${接口类型}=${接口类型_全局变量}
    ${变化数据_金证}    Run Keyword If    '${接口类型}'=='Stk'    金证_新股申购初始化
    ${变化数据}    Run Keyword If    '${接口类型}'=='Stk'    Set Variable    ${变化数据_金证}
    ${字段提取_需计算_委托前_全局变量}    ${字段提取_无需计算_委托前}    接口/表取值流程_取值计算录制模式    ${变化数据}
    Set Global Variable    ${字段提取_需计算_委托前_全局变量}
    log    ${字段提取_需计算_委托前_全局变量}
