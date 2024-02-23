*** Settings ***
Library           RequestsLibrary
Library           JSONLibrary
Resource          ../../公共目录/配置信息/Post接口调用.robot
Resource          ../../公共目录/配置信息/TSP环境配置信息.robot
Resource          ../../公共目录/配置信息/UTP185Linux服务器.robot

*** Keywords ***
TSP数据库操作
    TDSQL数据库连接
    ${TSP账户节点数据}    Query    select node_id,account,secu_acc,`enable` from tsp_sit_v2.router_account_config
    ${TSP节点数据}    Set Variable    ${TSP账户节点数据}[0][0]
    ${TSP账户数据}    Set Variable    ${TSP账户节点数据}[0][1]
    ${TSP股东账户数据}    Set Variable    ${TSP账户节点数据}[0][2]

通过账户获取对应节点
    [Arguments]    ${账户}=${资金账户_全局变量}
    TDSQL数据库连接
    ${TSP账户节点数据}    Query    select node_id,account,secu_acc,`enable` from tsp_sit_v2.router_account_config where account = '${账户}'
    ${TSP节点数据}    Set Variable    ${TSP账户节点数据}[0][0]
    [Return]    ${TSP节点数据}

深圳账户对应节点
    [Arguments]    ${账户}=${资金账户_全局变量}
    TDSQL数据库连接
    ${深圳TSP账户节点数据}    Query    select node_id,account,secu_acc,`enable` from tsp_sit_v2.router_account_config where account = '${账户}' and market='0'
    ${深圳TSP节点数据}    Set Variable    ${深圳TSP账户节点数据}[0][0]
    [Return]    ${深圳TSP节点数据}

上海账户对应节点
    [Arguments]    ${账户}=${资金账户_全局变量}
    TDSQL数据库连接
    ${上海TSP账户节点数据}    Query    select node_id,account,secu_acc,`enable` from tsp_sit_v2.router_account_config where account = '${账户}' and market='1'
    ${上海TSP节点数据}    Set Variable    ${上海TSP账户节点数据}[0][0]
    [Return]    ${上海TSP节点数据}

通过账户获取对应客户号
    [Arguments]    ${账户}=${资金账户_全局变量}
    TDSQL数据库连接
    ${TSP客户号数据}    Query    select cust_code from tsp_sit_v2.account where account = '${账户}'
    ${TSP客户号}    Set Variable    ${TSP客户号数据}[0][0]
    [Return]    ${TSP客户号}

通过账户获取对应账户类别
    [Arguments]    ${账户}=${资金账户_全局变量}
    TDSQL数据库连接
    ${TSP客户号数据}    Query    select account_type from tsp_sit_v2.account where account = '${账户}'
    ${TSP账户类别}    Set Variable    ${TSP客户号数据}[0][0]
    [Return]    ${TSP账户类别}

通过账户获取对应机构号
    [Arguments]    ${账户}=${资金账户_全局变量}
    TDSQL数据库连接
    ${TSP机构号数据}    Query    select branch from tsp_sit_v2.account where account = '${账户}'
    ${TSP机构号}    Set Variable    ${TSP机构号数据}[0][0]
    [Return]    ${TSP机构号}

通过账户获取对应双中心标志
    [Arguments]    ${账户}=${资金账户_全局变量}
    TDSQL数据库连接
    ${TSP标志数据}    Query    select is_multi_node from tsp_sit_v2.account where account = '${账户}'
    ${TSP标志}    Set Variable    ${TSP标志数据}[0][0]
    [Return]    ${TSP标志}
