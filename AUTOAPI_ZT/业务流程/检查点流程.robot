*** Setting ***
Resource          ../公共目录/配置信息/接口字段转换匹配.robot

*** Keywords ***
接口返回数据校验
    [Arguments]    ${返回消息tsp}    ${返回消息_测试系统}
    转换字段遍历校验    ${返回消息tsp}    ${返回消息_测试系统}

单双节点校验
    Run KeyWord If    ${单双中心标志}==0    接口返回数据校验    ${单中心返回消息TSP}    ${单中心返回消息STK}
    Run KeyWord If    ${单双中心标志}==1    接口返回数据校验    ${双中心返回消息TSP_SH}    ${双中心返回消息STK_SH}
    Run KeyWord If    ${单双中心标志}==1    接口返回数据校验    ${双中心返回消息TSP_SZ}    ${双中心返回消息STK_SZ}

华锐登录检查
    [Arguments]    ${返回数据}
    log    ${返回数据}
    ${账户状态}    Run KeyWord If    '${测试系统_全局变量}'=='ATP'    Set Variable    ${返回数据}[status]
    ${账户状态}    Convert To String    ${账户状态}
    Run keyWord If    ${账户状态}==4    LOG    PASS
    ...    ELSE IF    ${账户状态}==0    LOG    检查账户是否登录
    Should Be Equal    ${账户状态}    4
