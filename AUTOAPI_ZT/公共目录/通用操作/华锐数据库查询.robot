*** Settings ***
Resource          ../../公共目录/配置信息/环境配置信息.robot

*** KeyWord ***
客户代码获取
    ${客户代码}    query    select cust_id from basedb.t_accounts where fund_id = ${资金账户_全局变量}
    ${客户代码_全局变量}    Set Variable    ${客户代码}[0][0]
    Set Global Variable    ${客户代码_全局变量}
    [Return]    ${客户代码}
