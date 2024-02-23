*** Settings ***
Resource          ../../订单接口/3.实时查询.robot
Resource          ../../订单接口/1.参数管理.robot
Resource          ../../订单接口/2.实时交易.robot
Resource          ../../订单接口/4.辅助功能.robot
Resource          ../../订单接口/LBM查询接口.robot

*** Keywords ***
担保品证券信息查询
    [Arguments]    ${证券代码}=${证券代码_全局变量}
    担保品证券信息查询_10321010

信用客户头寸信息查询
    ${返回码}    ${返回信息}    融资融券协议查询_10321004
    log    ${返回码}
    log    ${返回信息}
    ${头寸编号_全局变量}    Set Variable    ${返回信息[0]}[CASH_FI_NO]
    Set Global Variable    ${头寸编号_全局变量}
    Should Be Equal As Strings    ${返回码[0]}[code]    ${0}

资金头寸信息查询
    ${返回码}    ${返回信息}    资金头寸查询_10323008
    log    ${返回码}
    log    ${返回信息}
    Should Be Equal As Strings    ${返回码[0]}[code]    ${0}

股份头寸信息查询
    ${返回码}    ${返回信息}    股份头寸查询_10323009
    log    ${返回码}
    log    ${返回信息}
    #Run KeyWord IF    '${证券业务_全局变量}' not in ('700','701')    Should Be Equal As Strings    ${返回码[0]}[code]    ${0}

融资融券合约查询
    ${返回码}    ${返回信息}    融资融券合约_10323001
    log    ${返回码}
    log    ${返回信息}
    Should Be Equal As Strings    ${返回码[0]}[code]    ${0}

融券合约汇总查询
    ${返回码}    ${返回信息}    融券合约汇总查询_10323031
    log    ${返回码}
    log    ${返回信息}
    Should Be Equal As Strings    ${返回码[0]}[code]    ${0}

融资合约汇总查询
    ${返回码}    ${返回信息}    融资合约汇总查询_10323030
    log    ${返回码}
    log    ${返回信息}
    Should Be Equal As Strings    ${返回码[0]}[code]    ${0}
