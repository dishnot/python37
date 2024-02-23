*** Settings ***
Library           RequestsLibrary
Library           DatabaseLibrary
Library           demjson
Resource          接口入参数据.robot
Resource          ../../业务流程/http通用检查点.robot

*** Keywords ***
POST接口下单请求_ZT
    [Arguments]    ${url}    ${uri}
    #创建session
    ${hearder}    create dictionary    Content-Type=application/json
    create session    自定义POST请求    ${url}    ${hearder}
    ${接口入参}    Run Keyword    接口入参数据    ${接口名_全局变量}
    #格式转换
    ${接口入参}    evaluate    demjson.encode(${接口入参})    demjson
    log    ${接口入参}
    #请求
    Comment    ${resp}    Post Request    自定义POST请求    ${后缀}    data=${接口入参}
    ${resp}    POST On Session    自定义POST请求    ${uri}    data=${接口入参}
    ${接口返回码}    set variable    ${resp.json()}[code]
    ${检查结果}    请求状态检查    ${resp}
    ${headers}    set variable    ${resp.headers}
    #格式处理
    log    ${resp}
    ${resp}    set variable    ${resp.json()}
    log    响应头：${headers}|数据：${resp}
    [Return]    ${resp}    ${headers}

POST接口请求_ZT
    [Arguments]    ${url}    ${uri}    ${入参数据}
    #创建session
    ${hearder}    create dictionary    Content-Type=application/json
    create session    自定义POST请求    ${url}    ${hearder}
    ${接口入参}    Set Variable    {"request":{${入参数据}}}
    LOG    ${接口入参}
    #格式转换
    ${接口入参}    evaluate    demjson.encode(${接口入参})    demjson
    log    ${接口入参}
    #请求
    Comment    ${resp}    Post Request    自定义POST请求    ${后缀}    data=${接口入参}
    ${resp}    POST On Session    自定义POST请求    ${uri}    data=${接口入参}
    ${接口返回码}    set variable    ${resp.json()}[code]
    ${检查结果}    请求状态检查    ${resp}
    ${headers}    set variable    ${resp.headers}
    #格式处理
    log    ${resp}
    ${resp}    set variable    ${resp.json()}
    log    响应头：${headers}|数据：${resp}
    [Return]    ${resp}    ${headers}

POST接口请求_WFW
    [Arguments]    ${url}    ${uri}    ${入参数据}
    #创建session
    ${hearder}    create dictionary    Content-Type=application/json
    create session    自定义POST请求    ${url}    ${hearder}
    ${接口入参}    Set Variable    {"params":{${入参数据}}}
    LOG    ${接口入参}
    #格式转换
    ${接口入参}    evaluate    demjson.encode(${接口入参})    demjson
    log    ${接口入参}
    #请求
    Comment    ${resp}    Post Request    自定义POST请求    ${后缀}    data=${接口入参}
    ${resp}    POST On Session    自定义POST请求    function${uri}    data=${接口入参}
    ${接口返回码}    set variable    ${resp.json()}[code]
    ${检查结果}    请求状态检查    ${resp}
    ${headers}    set variable    ${resp.headers}
    #格式处理
    log    ${resp}
    ${resp}    set variable    ${resp.json()}
    log    响应头：${headers}|数据：${resp}
    [Return]    ${resp}    ${headers}
