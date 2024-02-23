*** Settings ***
Library           RequestsLibrary
Resource          ../通用操作/常用关键字.robot
Library           DatabaseLibrary
Library           demjson

*** Variables ***
&{API地址}          网址=http://utp.ciccwm.com    金证api接口后缀=/macli/client/    环境后缀=/api/rfenv/    金证柜台接口后缀=/lbm/client/    华锐环境后缀=/atp/env/    华锐api接口后缀=/atp/client/    华锐web登录后缀1=/bss/getChallenge    华锐web登录后缀2=/bss/login    华锐web查询客户信息=/bss/account/list    华锐web查询证券信息=/bss/security/list    华锐web资金调整=/bss/fund/query    华锐web股份调整=/bss/stock/sharePositionAdjust    华锐web交易参考信息设置=/bss/securityParam/list    华锐web配售交易参考信息设置=/bss/rightsIssueBusinessRule/list    华锐webETF实时申购赎回=/bss/etfBizRule/list    华锐web网上发行=/bss/securityParam/businessType/13/list    华锐api返回信息=/atp/order/
&{订单_69}          服务器IP=10.138.1.69    服务器端口=41000    数据库=10.138.1.70    数据库名称=kbss_stds    数据库用户名称=sa    数据库密码=zt@1234    数据库端口=1433    服务队列=req_stds    应答队列=ans_stds    servername=KCBP01    username=KCXP00    password=888888    protocol=${0}    port=${21000}
&{订单_210}         服务器IP=10.138.1.210    服务器端口=41000    数据库=10.138.1.211    数据库名称=kbss_stds_210    数据库用户名称=sa    数据库密码=zt@1234    数据库端口=1433    服务队列=req_stds_210    应答队列=ans_stds_210    servername=KCBP01    username=KCXP00    password=888888    protocol=${0}    port=${21000}
&{订单_125}         服务器IP=10.174.3.125    服务器端口=41000    数据库=10.171.9.5    数据库名称=kbss_stds_fsl    数据库用户名称=sa    数据库密码=zt@1234    数据库端口=1433    服务队列=req_stds_lr    应答队列=ans_stds_lr    servername=KCBP01    username=KCXP00    password=888888    protocol=${0}    port=${21000}
&{订单_83}          服务器IP=10.171.7.83    服务器端口=41000    数据库=10.171.9.5    数据库名称=kbss_stds_fsl_83_1    数据库用户名称=sa    数据库密码=zt@1234    数据库端口=1433    服务队列=req_stds_83    应答队列=ans_stds_83    servername=KCBP01    username=KCXP00    password=888888    protocol=${0}    port=${21000}
&{订单_204}         服务器IP=10.138.1.204    服务器端口=41000    数据库=10.138.1.211    数据库名称=kbss_stds_81    数据库用户名称=sa    数据库密码=zt@1234    数据库端口=1433    服务队列=req_stds_81    应答队列=ans_stds_81    servername=KCBP01    username=KCXP00    password=888888    protocol=${0}    port=${21000}
&{订单_206}         服务器IP=10.138.1.206    服务器端口=41000    数据库=10.138.1.211    数据库名称=kbss_stds_82_sc    数据库用户名称=sa    数据库密码=zt@1234    数据库端口=1433    服务队列=req_stds_82    应答队列=ans_stds_82    servername=KCBP01    username=KCXP00    password=888888    protocol=${0}    port=${21000}
&{订单_210b}        服务器IP=10.138.1.210    服务器端口=41000    数据库=10.138.1.211    数据库名称=kbss_stds_210b    数据库用户名称=sa    数据库密码=zt@1234    数据库端口=1433    服务队列=req_stds_210    应答队列=ans_stds_210    servername=KCBP01    username=KCXP00    password=888888    protocol=${0}    port=${21000}
&{订单_182}         服务器IP=10.138.2.182    服务器端口=41000    数据库=10.171.9.5    数据库名称=kbss_stds_182    数据库用户名称=sa    数据库密码=zt@1234    数据库端口=1433    服务队列=req_stds_182    应答队列=ans_stds_182    servername=KCBP01    username=KCXP00    password=888888    protocol=${0}    port=${21000}
&{订单_182x}        服务器IP=10.138.2.182    服务器端口=41000    数据库=10.171.9.5    数据库名称=kbss_stds_182_x    数据库用户名称=sa    数据库密码=zt@1234    数据库端口=1433    服务队列=req_stds_182    应答队列=ans_stds_182    servername=KCBP01    username=KCXP00    password=888888    protocol=${0}    port=${21000}

*** Keywords ***
环境信息查询与连接
    [Arguments]    ${接口类型}=${接口类型_全局变量}
    #金证两融环境    Fis是金证
    ${环境}    Run Keyword If    '${TEST_ENV}'=='69'    Set Variable    ${订单_69}
    ...    ELSE IF    '${TEST_ENV}'=='210'    Set Variable    ${订单_210}
    ...    ELSE IF    '${TEST_ENV}'=='125'    Set Variable    ${订单_125}
    ...    ELSE IF    '${TEST_ENV}'=='83'    Set Variable    ${订单_83}
    ...    ELSE IF    '${TEST_ENV}'=='204'    Set Variable    ${订单_204}
    ...    ELSE IF    '${TEST_ENV}'=='206'    Set Variable    ${订单_206}
    ...    ELSE IF    '${TEST_ENV}'=='210b'    Set Variable    ${订单_210b}
    ...    ELSE IF    '${TEST_ENV}'=='182'    Set Variable    ${订单_182}
    ...    ELSE IF    '${TEST_ENV}'=='182x'    Set Variable    ${订单_182x}
    ${域名/IP}    Run Keyword If    '${接口类型}'=='Fis'    Set Variable    ${环境["服务器IP"]}
    ${端口}    Run Keyword If    '${接口类型}'=='Fis'    Set Variable    ${环境["服务器端口"]}
    ${数据库信息}    Run Keyword If    '${接口类型}'=='Fis'    Set Variable    Server=${环境["数据库"]};Port=${环境["数据库端口"]};Database=${环境["数据库名称"]};UID=${环境["数据库用户名称"]};PWD=${环境["数据库密码"]}
    ${队列信息}    Run Keyword If    '${接口类型}'=='Fis' and '${TEST_ENV}'in ('69','210','125','83','204','206','210b','182','182x')    Set Variable    {\\"address\\":\\"${环境["服务器IP"]}\\",\\"sendq\\":\\"${环境["服务队列"]}\\",\\"recvq\\":\\"${环境["应答队列"]}\\",\\"servername\\":\\"${环境["servername"]}\\",\\"username\\":\\"${环境["username"]}\\",\\"password\\":\\"${环境["password"]}\\",\\"protocol\\":${环境["protocol"]},\\"port\\":${环境["port"]}}
    ${请求信息}    Run Keyword If    '${接口类型}'=='Fis'    Set Variable    \\"F_SESSION\\":\\"1839893105657921\\",\\"F_OP_SITE\\":\\"00505680bbd7\\",\\"F_CHANNEL\\":\\"0\\",\\"F_OP_USER\\":\\"w8sBypob9KM=\\",\\"F_OP_ROLE\\":\\"2\\",\\"F_OP_ORG\\":\\"8001\\",
    ${环境_全局变量}    Set Variable    ${环境}
    ${模式_全局变量}    Run Keyword If    '${MODE}'=='0'    Set Variable    普通
    ...    ELSE IF    '${MODE}'=='1'    Set Variable    软加速
    ${接口_全局变量}    Run Keyword If    '${API}'=='0'    Set Variable    普通
    ...    ELSE IF    '${MODE}'=='1'    Set Variable    软加速
    Set Global Variable    ${模式_全局变量}
    Set Global Variable    ${环境_全局变量}
    Set Global Variable    ${接口_全局变量}
    #把数据信息存在到UTP平台上
    POST环境请求_UTP    {"env_name": "${TEST_ENV}","env_desc": "${TEST_ENV}环境","env_address": "${域名/IP}","env_port": "${端口}","db_info": "${数据库信息}","quenue_info": "${队列信息}","request_info": "${请求信息}"}
    #数据库链接
    ${数据库信息_全局变量}    Set Variable    ${数据库信息}
    Set Global Variable    ${数据库信息_全局变量}
    数据库链接
    #KBSS数据信息
    #win版    ${fixpram_全局变量}    Replace String    ${请求信息}    ${/}    ${EMPTY}
    #LINUX版    ${fixpram_全局变量}    Replace String    ${请求信息}    \\    ${EMPTY}
    ${xt}    Evaluate    sys.platform    sys
    ${fh}    Set Variable IF    '${xt}'=='win32'    ${/}    \\
    ${fixpram_全局变量}    Replace String    ${请求信息}    ${fh}    ${EMPTY}
    Set Global Variable    ${fixpram_全局变量}

数据库链接
    [Arguments]    ${接口类型}=${接口类型_全局变量}    ${数据库信息}=${数据库信息_全局变量}
    #数据库链接
    #SQL
    Comment    win版连接    Run Keyword If    '${接口类型}'=='Fis'    Connect To Database Using Custom Params    pyodbc    "Driver={SQL Server};${数据库信息}"
    Comment    linux版连接    Run Keyword If    '${接口类型}'=='Fis'    Connect To Database Using Custom Params    pyodbc    "Driver={ODBC Driver 11 for SQL Server};${数据库信息}"
    ${xt}    Evaluate    sys.platform    sys
    ${driver}    Set Variable IF    '${xt}'=='win32'    SQL Server    ODBC Driver 11 for SQL Server
    Run Keyword If    '${接口类型}'=='Fis'    Connect To Database Using Custom Params    pyodbc    "Driver={${driver}};${数据库信息}"
    #mysql
    #Run Keyword If    '${接口类型}'=='Cash'    Connect To Database Using Custom Params    pymysql    ${数据库信息}
    #Oracel数据库连接_基准数据存储
    Run Keyword If    '${接口类型}'=='${EMPTY}'    Connect To Database Using Custom Params    cx_Oracle    'auto','auto','(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=10.171.9.18)(PORT=1521)))(CONNECT_DATA=(SERVICE_NAME=testdb)))'

POST接口下单请求_UTP数据银行_取服务器优化前
    [Arguments]    ${接口}    ${接口参数}    ${接口中文名称}=${EMPTY}    ${接口响应}=${EMPTY}    ${环境}=${TEST_ENV}    ${接口类型}=${接口类型_全局变量}    ${接口版本}=1.0.0    ${session}=${EMPTY}    ${sync_flag}=1
    #创建session
    log    ${接口}
    ${hearder}    Run Keyword IF    '${接口中文名称}'!='用户登录'and '${接口类型}'=='Fis'    create dictionary    Content-Type=application/json    session=${session_全局变量}
    ...    ELSE    create dictionary    Content-Type=application/json
    create session    自定义POST请求    ${API地址["网址"]}    ${hearder}
    #接口调用
    log    ${接口中文名称}
    #根据条件传参不一样
    ${接口入参}    Run Keyword If    '${接口中文名称}'!='${EMPTY}' and '${接口类型}'=='Fis' and '${模式_全局变量}'=='软加速'or'${接口中文名称}'=='用户登录'    Set Variable    {"env": "${环境}","func_code": "${接口}","bus_type": "${接口类型}","bus_name": "${接口中文名称}","version": "${接口版本}","data": {${接口参数}}}
    ...    ELSE IF    '${接口中文名称}'!='${EMPTY}' and '${接口类型}'=='Fis' and '${模式_全局变量}'!='软加速'    Set Variable    {"env": "${环境}","func_code": "${接口}","bus_type": "${接口类型}","bus_name": "${接口中文名称}","version": "${接口版本}","sync_flag": "${sync_flag}","data": {${接口参数}}}
    ...    ELSE IF    '${接口中文名称}'=='${EMPTY}'    Set Variable    {"env": "${环境}","func_code": "${接口}","data": [{${接口参数}}]}
    log    ${接口入参}
    #格式转换
    ${接口入参}    evaluate    demjson.encode(${接口入参})    demjson
    Comment    ${接口入参}    Run Keyword If    '${接口类型}'!='Fis'    evaluate    json.dumps(${接口入参})    json
    ...    ELSE    set variable    ${接口入参}
    Comment    ${接口入参}    Run Keyword If    '${接口类型}'=='Fis'    evaluate    json.dumps(${接口入参})    json
    ...    ELSE    set variable    ${接口入参}    #将python对象编码成Json字符串
    log    ${接口入参}
    #选择后缀地址
    ${后缀}    Run Keyword If    '${接口中文名称}'!='${EMPTY}' and '${接口类型}'=='Fis'    set variable    ${API地址["金证api接口后缀"]}
    ...    ELSE IF    '${接口中文名称}'=='${EMPTY}'    Set Variable    ${API地址["金证柜台接口后缀"]}
    log    网址：${API地址["网址"]}${后缀}|入参：${接口入参}
    #请求
    Comment    ${resp}    Post Request    自定义POST请求    ${后缀}    data=${接口入参}
    ${resp}    POST On Session    自定义POST请求    ${后缀}    data=${接口入参}
    ${headers}    set variable    ${resp.headers}
    #格式处理
    log    ${resp}
    ${resp}    set variable    ${resp.json()}
    log    响应头：${headers}|数据：${resp}
    [Return]    ${resp}    ${headers}

POST接口下单请求_UTP数据银行
    [Arguments]    ${接口}    ${接口参数}    ${接口中文名称}=${EMPTY}    ${接口响应}=${EMPTY}    ${环境}=${TEST_ENV}    ${接口类型}=${接口类型_全局变量}    ${接口版本}=1.0.0    ${session}=${EMPTY}    ${sync_flag}=1
    #创建session
    log    ${接口}
    ${hearder}    Run Keyword IF    '${接口中文名称}'!='用户登录'and '${接口类型}'=='Fis'    create dictionary    Content-Type=application/json    session=${session_全局变量}
    ...    ELSE    create dictionary    Content-Type=application/json
    create session    自定义POST请求    ${API地址["网址"]}    ${hearder}
    #接口调用
    log    ${接口中文名称}
    #根据条件传参不一样
    ${接口入参}    Run Keyword If    '${接口中文名称}'!='${EMPTY}' and '${接口类型}'=='Fis' and '${模式_全局变量}'=='软加速'or'${接口中文名称}'=='用户登录'    Set Variable    {"env": "${环境}","func_code": "${接口}","bus_type": "${接口类型}","bus_name": "${接口中文名称}","version": "${接口版本}","data": {${接口参数}}}
    ...    ELSE IF    '${接口中文名称}'!='${EMPTY}' and '${接口类型}'=='Fis' and '${模式_全局变量}'!='软加速'    Set Variable    {"env": "${环境}","func_code": "${接口}","bus_type": "${接口类型}","bus_name": "${接口中文名称}","version": "${接口版本}","sync_flag": "${sync_flag}","data": {${接口参数}}}
    ...    ELSE IF    '${接口中文名称}'=='${EMPTY}'    Set Variable    {"env": "${环境}","func_code": "${接口}","data": [{${接口参数}}]}
    log    ${接口入参}
    #格式转换
    ${接口入参}    evaluate    demjson.encode(${接口入参})    demjson
    Comment    ${接口入参}    Run Keyword If    '${接口类型}'!='Fis'    evaluate    json.dumps(${接口入参})    json
    ...    ELSE    set variable    ${接口入参}
    Comment    ${接口入参}    Run Keyword If    '${接口类型}'=='Fis'    evaluate    json.dumps(${接口入参})    json
    ...    ELSE    set variable    ${接口入参}    #将python对象编码成Json字符串
    log    ${接口入参}
    #选择后缀地址
    ${后缀}    Run Keyword If    '${接口中文名称}'!='${EMPTY}' and '${接口类型}'=='Fis'    set variable    ${API地址["金证api接口后缀"]}
    ...    ELSE IF    '${接口中文名称}'=='${EMPTY}'    Set Variable    ${API地址["金证柜台接口后缀"]}
    log    网址：${API地址["网址"]}${后缀}|入参：${接口入参}
    #请求
    Comment    ${resp}    Post Request    自定义POST请求    ${后缀}    data=${接口入参}
    FOR    ${i}    IN RANGE    2
        ${bool}    ${resp}    Run Keyword And Ignore Error    POST On Session    自定义POST请求    ${后缀}    data=${接口入参}
        ${bool2}    ${resp_retry}    Run Keyword If    '${bool}'=='FAIL'    Retry Request    ${后缀}    ${接口入参}
        ${resp}    Run Keyword If    '${bool}'=='FAIL'    Set Variable    ${resp_retry}
        ...    ELSE    Set Variable    ${resp}
        Run Keyword If    '${bool2}'=='FAIL'    Continue For Loop
        Exit For Loop If    '${bool2}'!='FAIL'
    END
    ${headers}    set variable    ${resp.headers}
    #格式处理
    log    ${resp}
    ${resp}    set variable    ${resp.json()}
    log    响应头：${headers}|数据：${resp}
    [Return]    ${resp}    ${headers}

POST接口下单请求_UTP数据银行_备份
    [Arguments]    ${接口}    ${接口参数}    ${接口中文名称}=${EMPTY}    ${接口响应}=${EMPTY}    ${环境}=${TEST_ENV}    ${接口类型}=${接口类型_全局变量}    ${接口版本}=1.0.0    ${session}=${EMPTY}
    #创建session
    log    ${接口}
    ${hearder}    Run Keyword IF    '${接口中文名称}'!='用户登录'and '${接口类型}'=='Fis'    create dictionary    Content-Type=application/json    session=${session_全局变量}
    ...    ELSE    create dictionary    Content-Type=application/json
    create session    自定义POST请求    ${API地址["网址"]}    ${hearder}
    #接口调用
    log    ${接口中文名称}
    #根据不同系统传参不一样
    ${接口入参}    Run Keyword If    '${接口中文名称}'!='${EMPTY}' and '${接口类型}'=='Fis'    Set Variable    {"env": "${环境}","func_code": "${接口}","bus_type": "${接口类型}","bus_name": "${接口中文名称}","version": "${接口版本}","data": {${接口参数}}}
    ...    ELSE IF    '${接口中文名称}'=='${EMPTY}'    Set Variable    {"env": "${环境}","func_code": "${接口}","data": [{${接口参数}}]}
    log    ${接口入参}
    #格式转换
    ${接口入参}    evaluate    demjson.encode(${接口入参})    demjson
    Comment    ${接口入参}    Run Keyword If    '${接口类型}'!='Fis'    evaluate    json.dumps(${接口入参})    json
    ...    ELSE    set variable    ${接口入参}
    Comment    ${接口入参}    Run Keyword If    '${接口类型}'=='Fis'    evaluate    json.dumps(${接口入参})    json
    ...    ELSE    set variable    ${接口入参}    #将python对象编码成Json字符串
    log    ${接口入参}
    #选择后缀地址
    ${后缀}    Run Keyword If    '${接口中文名称}'!='${EMPTY}' and '${接口类型}'=='Fis'    set variable    ${API地址["金证api接口后缀"]}
    ...    ELSE IF    '${接口中文名称}'=='${EMPTY}'    Set Variable    ${API地址["金证柜台接口后缀"]}
    log    网址：${API地址["网址"]}${后缀}|入参：${接口入参}
    #请求
    Comment    ${resp}    Post Request    自定义POST请求    ${后缀}    data=${接口入参}
    ${resp}    POST On Session    自定义POST请求    ${后缀}    data=${接口入参}
    ${headers}    set variable    ${resp.headers}
    #格式处理
    log    ${resp}
    ${resp}    set variable    ${resp.json()}
    log    响应头：${headers}|数据：${resp}
    [Return]    ${resp}    ${headers}

GET环境请求_UTP
    [Arguments]    ${接口入参}    ${后缀}=${API地址["华锐api返回信息"]}
    #创建session
    ${hearder}    create dictionary    Content-Type=application/json
    create session    自定义POST请求    ${API地址["网址"]}    ${hearder}
    #接口调用
    Comment    ${接口入参}    create dictionary    env_name=${TEST_ENV}
    Comment    ${resp}    get Request    自定义POST请求    ${API地址["环境后缀"]}    params=${接口入参}
    log    网址：${API地址["网址"]}${后缀}|入参：${接口入参}
    Comment    ${resp}    get Request    自定义POST请求    ${后缀}    params=${接口入参}
    ${resp}    GET On Session    自定义POST请求    ${后缀}    params=${接口入参}
    #格式处理
    ${resp}    set variable    ${resp.json()}
    ${resp}    Set Variable    ${resp["data"][0]}
    log    ${resp}
    [Return]    ${resp}

POST环境请求_UTP
    [Arguments]    ${接口入参}    ${后缀}=${EMPTY}
    #创建session
    ${hearder}    create dictionary    Content-Type=application/json
    create session    自定义POST请求    ${API地址["网址"]}    ${hearder}
    #接口调用
    Comment    ${接口入参}    Set Variable    ${接口入参}
    ${后缀}    Run Keyword If    '${后缀}'=='${EMPTY}'    Set Variable    ${API地址["环境后缀"]}
    ...    ELSE IF    '${后缀}'!='${EMPTY}'    Set Variable    ${API地址["华锐环境后缀"]}
    log    网址：${API地址["网址"]}${后缀}|入参：${接口入参}
    Comment    ${resp}    Post Request    自定义POST请求    ${后缀}    data=${接口入参}
    #格式转换
    ${接口入参}    evaluate    demjson.encode(${接口入参} )    demjson
    FOR    ${i}    IN RANGE    2
        ${bool}    ${resp}    Run Keyword And Ignore Error    POST On Session    自定义POST请求    ${后缀}    data=${接口入参}
        ${bool2}    ${resp_retry}    Run Keyword If    '${bool}'=='FAIL'    Retry Request    ${后缀}    ${接口入参}
        ${resp}    Run Keyword If    '${bool}'=='FAIL'    Set Variable    ${resp_retry}
        ...    ELSE    Set Variable    ${resp}
        Run Keyword If    '${bool2}'=='FAIL'    Continue For Loop
        Exit For Loop If    '${bool2}'!='FAIL'
    END
    #格式处理
    ${resp}    set variable    ${resp.json()}
    log    ${resp}
    [Return]    ${resp}

Retry Request
    [Arguments]    ${后缀}    ${接口入参}
    Sleep    5
    FOR    ${i}    IN RANGE    10
        ${bool}    ${resp}    Run Keyword And Ignore Error    POST On Session    自定义POST请求    ${后缀}    data=${接口入参}
        LOG    ${resp}
        Run Keyword And Return Status    Run Keyword If    '${bool}'=='FAIL'    SLEEP    5
        Run Keyword And Return Status    Continue For Loop IF    '${bool}'=='FAIL'
        Run Keyword And Return Status    Exit For Loop If    '${bool}'!='FAIL'
    END
    LOG    ${resp}
    [Return]    ${bool}    ${resp}
