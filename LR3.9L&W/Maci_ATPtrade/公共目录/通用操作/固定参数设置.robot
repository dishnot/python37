*** Settings ***

*** Keywords ***
货币代码参数
    ${货币代码_全局变量}    Set Variable    0
    Set Global Variable    ${货币代码_全局变量}

交易单元参数
    ${上海交易单元_全局变量}    Set Variable    39107
    Set Global Variable    ${上海交易单元_全局变量}
    ${深圳交易单元_全局变量}    Set Variable    393228
    Set Global Variable    ${深圳交易单元_全局变量}

合约类型参数
    ${合约类型_全局变量}    Run KeyWord If    '${证券业务_全局变量}'in ('702','705')    Set Variable    0
    ...    ELSE IF    '${证券业务_全局变量}'in ('703','704','710')    Set Variable    1
    ...    ELSE IF    '${证券业务_全局变量}'=='直接还款'    Set Variable    1
    Set Global Variable    ${合约类型_全局变量}
