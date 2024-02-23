*** Settings ***
Resource          ../../../接口定义/华锐/初始化接口.robot
Resource          ../../../接口定义/华锐/查询接口.robot
Resource          ../../../业务流程/交易流程_公共/3-检查点流程/公共/计算该笔委托的值_取值计算录制模式.robot

*** Keywords ***
华锐_普通买卖初始化
    [Arguments]    ${调整资金}    ${调整股份}    ${权限}=${Empty}
    #资金调整_web    ${调整资金}
    #股份调整_web    ${调整股份}
    ReqCustLoginOther_账户登入函数
    ${变化数据}    Create List    ReqFundQuery_资金查询    ReqShareQuery_股份查询    ReqExtQueryShareEx_增强股份查询    basedb.t_fund_assets    basedb.t_stocks
    [Return]    ${变化数据}

华锐_新股申购初始化
    [Arguments]    ${权限}=${Empty}
    ReqCustLoginOther_账户登入函数
    ${变化数据}    Create List    ReqFundQuery_资金查询    basedb.t_fund_assets
    [Return]    ${变化数据}

华锐_篮子买卖初始化

sqltest普通买卖初始化
    ReqCustLoginOther_账户登入函数
    ${变化数据}    Create List    ReqFundQuery_资金查询    ReqShareQuery_股份查询    basedb.t_fund_assets    basedb.t_stocks
    ${字段提取_需计算_委托前_全局变量}    ${字段提取_无需计算_委托前}    接口/表取值流程_取值计算录制模式    ${变化数据}
    Set Global Variable    ${字段提取_需计算_委托前_全局变量}
    log    ${字段提取_需计算_委托前_全局变量}
