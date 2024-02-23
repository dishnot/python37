*** Settings ***
Documentation     订单_78为linux上海软加速环境
...               订单_118为linux深圳软加速环境
Library           RequestsLibrary
Resource          ../通用操作/常用关键字.robot
Library           DatabaseLibrary
Library           demjson

*** Variables ***
&{API地址}          网址=http://utp.ciccwm.com    金证api接口后缀=/macli/client/    环境后缀=/api/rfenv/    金证柜台接口后缀=/lbm/client/    华锐环境后缀=/atp/env/    华锐api接口后缀=/atp/client/    华锐web登录后缀1=/bss/getChallenge    华锐web登录后缀2=/bss/login    华锐web查询客户信息=/bss/account/list    华锐web查询证券信息=/bss/security/list    华锐web资金调整=/bss/fund/query    华锐web股份调整=/bss/stock/sharePositionAdjust    华锐web交易参考信息设置=/bss/securityParam/list    华锐web配售交易参考信息设置=/bss/rightsIssueBusinessRule/list    华锐webETF实时申购赎回=/bss/etfBizRule/list    华锐web网上发行=/bss/securityParam/businessType/13/list    华锐api返回信息=/atp/order/
&{订单_66}          服务器IP=10.138.1.66    服务器端口=41000    数据库=10.138.1.68    数据库名称=kbss_stds    数据库用户名称=sa    数据库密码=zt@1234    数据库端口=1433    服务队列=req_stds    应答队列=ans_stds    servername=KCBP01    username=KCXP00    password=888888    protocol=${0}    port=${21000}
&{订单_67}          服务器IP=10.138.1.67    服务器端口=41000    数据库=10.138.1.68    数据库名称=kbss_stds    数据库用户名称=sa    数据库密码=zt@1234    数据库端口=1433    服务队列=req_stds    应答队列=ans_stds    servername=KCBP01    username=KCXP00    password=888888    protocol=${0}    port=${21000}
&{订单_209}         服务器IP=10.138.1.209    服务器端口=41000    数据库=10.138.1.211    数据库名称=kbss_stds_62    数据库用户名称=sa    数据库密码=zt@1234    数据库端口=1433    服务队列=req_stds    应答队列=ans_stds    servername=KCBP01    username=KCXP00    password=888888    protocol=${0}    port=${21000}
&{订单_47}          服务器IP=10.138.2.47    服务器端口=41000    数据库=10.138.1.68    数据库名称=kbss_stds_47    数据库用户名称=sa    数据库密码=zt@1234    数据库端口=1433    服务队列=req_stds    应答队列=ans_stds    servername=KCBP01    username=KCXP00    password=888888    protocol=${0}    port=${21000}
&{订单_118}         服务器IP=10.171.1.118    服务器端口=41000    数据库=10.171.9.13    数据库名称=kbss_stds_33    数据库用户名称=sa    数据库密码=szkd@@600446    数据库端口=1433    服务队列=req_stds_33    应答队列=ans_stds_33    servername=KCBP01    username=KCXP00    password=888888    protocol=${0}    port=${21000}
&{订单_78}          服务器IP=10.171.7.78    服务器端口=41000    数据库=10.171.9.13    数据库名称=kbss_stds_331    数据库用户名称=sa    数据库密码=szkd@@600446    数据库端口=1433    服务队列=req_stds_331    应答队列=ans_stds_331    servername=KCBP01    username=KCXP00    password=888888    protocol=${0}    port=${21000}
&{订单_136}         服务器IP=10.171.7.136    服务器端口=41000    数据库=10.171.9.13    数据库名称=kbss_stds_136    数据库用户名称=sa    数据库密码=zt@1234    数据库端口=1433    服务队列=req_stds_40    应答队列=ans_stds_40    servername=KCBP01    username=KCXP00    password=888888    protocol=${0}    port=${21000}

*** Keywords ***
环境信息查询与连接
    [Arguments]    ${接口类型}=${接口类型_全局变量}
    #华锐和金证环境    Stk是金证，Cash是华锐
    ${环境}    Run Keyword If    '${TEST_ENV}'=='66'    Set Variable    ${订单_66}
    ...    ELSE IF    '${TEST_ENV}'=='67'    Set Variable    ${订单_67}
    ...    ELSE IF    '${TEST_ENV}'=='211'    Set Variable    ${订单_211}
    ...    ELSE IF    '${TEST_ENV}'=='47'    Set Variable    ${订单_47}
    ...    ELSE IF    '${TEST_ENV}'=='118'    Set Variable    ${订单_118}
    ...    ELSE IF    '${TEST_ENV}'=='78'    Set Variable    ${订单_78}
    ...    ELSE IF    '${TEST_ENV}'=='136'    Set Variable    ${订单_136}
    ${域名/IP}    Run Keyword If    '${接口类型}'=='Stk'    Set Variable    ${环境["服务器IP"]}
    ${端口}    Run Keyword If    '${接口类型}'=='Stk'    Set Variable    ${环境["服务器端口"]}
    ${数据库信息}    Run Keyword If    '${接口类型}'=='Stk'    Set Variable    Server=${环境["数据库"]};Port=${环境["数据库端口"]};Database=${环境["数据库名称"]};UID=${环境["数据库用户名称"]};PWD=${环境["数据库密码"]}
    ${队列信息}    Run Keyword If    '${接口类型}'=='Stk' and '${TEST_ENV}'in'(118,78,136)'    Set Variable    {\\"address\\":\\"${环境["数据库"]}\\",\\"sendq\\":\\"${环境["服务队列"]}\\",\\"recvq\\":\\"${环境["应答队列"]}\\",\\"servername\\":\\"${环境["servername"]}\\",\\"username\\":\\"${环境["username"]}\\",\\"password\\":\\"${环境["password"]}\\",\\"protocol\\":${环境["protocol"]},\\"port\\":${环境["port"]}}
    ...    ELSE IF    '${接口类型}'=='Stk' and '${TEST_ENV}'in'(47,66,67,209)'    Set Variable    {\\"address\\":\\"${环境["服务器IP"]}\\",\\"sendq\\":\\"${环境["服务队列"]}\\",\\"recvq\\":\\"${环境["应答队列"]}\\",\\"servername\\":\\"${环境["servername"]}\\",\\"username\\":\\"${环境["username"]}\\",\\"password\\":\\"${环境["password"]}\\",\\"protocol\\":${环境["protocol"]},\\"port\\":${环境["port"]}}
    ${请求信息}    Run Keyword If    '${接口类型}'=='Stk'    Set Variable    \\"F_SESSION\\":\\"1839893105657921\\",\\"F_OP_SITE\\":\\"00505680bbd7\\",\\"F_CHANNEL\\":\\"0\\",\\"F_OP_USER\\":\\"w8sBypob9KM=\\",\\"F_OP_ROLE\\":\\"2\\",\\"F_OP_ORG\\":\\"8001\\",
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
    Comment    Close_连接关闭函数

POST接口下单请求_UTP数据银行
    [Arguments]    ${接口}    ${接口参数}    ${接口中文名称}=${EMPTY}    ${接口响应}=${EMPTY}    ${环境}=${TEST_ENV}    ${接口类型}=${接口类型_全局变量}    ${接口版本}=1.0.0    ${session}=${EMPTY}    ${sync_flag}=1
    #创建session
    ${hearder}    Run Keyword IF    '${接口中文名称}'!='用户登录API'and '${接口类型}'=='Stk'    create dictionary    Content-Type=application/json    session=${session_全局变量}
    ...    ELSE    create dictionary    Content-Type=application/json
    create session    自定义POST请求    ${API地址["网址"]}    ${hearder}
    #接口调用
    log    ${接口中文名称}
    #根据不同系统传参不一样
    log    ${MODE}
    ${接口入参}    Run Keyword If    '${接口中文名称}'!='${EMPTY}' and '${接口类型}'=='Stk' and '${模式_全局变量}'=='软加速'    Set Variable    {"env": "${环境}","func_code": "${接口}","bus_type": "${接口类型}","bus_name": "${接口中文名称}","version": "${接口版本}","data": {${接口参数}}}
    ...    ELSE IF    '${接口中文名称}'!='${EMPTY}' and '${接口类型}'=='Stk' and '${模式_全局变量}'!='软加速'    Set Variable    {"env": "${环境}","func_code": "${接口}","bus_type": "${接口类型}","bus_name": "${接口中文名称}","version": "${接口版本}","sync_flag": "${sync_flag}","data": {${接口参数}}}
    ...    ELSE IF    '${接口中文名称}'=='${EMPTY}'    Set Variable    {"env": "${环境}","func_code": "${接口}","data": [{${接口参数}}]}
    log    ${接口入参}
    #格式转换
    ${接口入参}    evaluate    demjson.encode(${接口入参})    demjson
    Comment    ${接口入参}    Run Keyword If    '${接口类型}'!='Stk'    evaluate    json.dumps(${接口入参})    json
    ...    ELSE    set variable    ${接口入参}
    Comment    ${接口入参}    Run Keyword If    '${接口类型}'=='Stk'    evaluate    json.dumps(${接口入参})    json
    ...    ELSE    set variable    ${接口入参}    #将python对象编码成Json字符串
    log    ${接口入参}
    #选择后缀地址
    ${后缀}    Run Keyword If    '${接口中文名称}'!='${EMPTY}' and '${接口类型}'=='Stk'    set variable    ${API地址["金证api接口后缀"]}
    ...    ELSE IF    '${接口中文名称}'=='${EMPTY}'    Set Variable    ${API地址["金证柜台接口后缀"]}
    log    网址：${API地址["网址"]}${后缀}|入参：${接口入参}
    #请求
    Comment    ${resp}    Post Request    自定义POST请求    ${后缀}    data=${接口入参}
    FOR    ${i}    IN RANGE    2
        ${result}    ${resp}    Run Keyword And Ignore Error    POST On Session    自定义POST请求    ${后缀}    data=${接口入参}
        ${resp_retry}    Run Keyword If    '${resp}'=='None'    Retry Request    ${后缀}    ${接口入参}
        ${resp}    Run Keyword If    '${resp}'=='None'    Set Variable    ${resp_retry}
        ...    ELSE    Set Variable    ${resp}
        Run Keyword If    '${resp}'=='None'    Continue For Loop
        Exit For Loop If    '${resp.status_code}'!='None'
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
    ${hearder}    Run Keyword IF    '${接口中文名称}'!='用户登录API'and '${接口类型}'=='Stk'    create dictionary    Content-Type=application/json    session=${session_全局变量}
    ...    ELSE    create dictionary    Content-Type=application/json
    create session    自定义POST请求    ${API地址["网址"]}    ${hearder}
    #接口调用
    log    ${接口中文名称}
    #根据不同系统传参不一样
    ${接口入参}    Run Keyword If    '${接口中文名称}'!='${EMPTY}' and '${接口类型}'=='Stk'    Set Variable    {"env": "${环境}","func_code": "${接口}","bus_type": "${接口类型}","bus_name": "${接口中文名称}","version": "${接口版本}","data": {${接口参数}}}
    ...    ELSE IF    '${接口中文名称}'=='${EMPTY}'    Set Variable    {"env": "${环境}","func_code": "${接口}","data": [{${接口参数}}]}
    log    ${接口入参}
    #格式转换
    ${接口入参}    evaluate    demjson.encode(${接口入参})    demjson
    Comment    ${接口入参}    Run Keyword If    '${接口类型}'!='Stk'    evaluate    json.dumps(${接口入参})    json
    ...    ELSE    set variable    ${接口入参}
    Comment    ${接口入参}    Run Keyword If    '${接口类型}'=='Stk'    evaluate    json.dumps(${接口入参})    json
    ...    ELSE    set variable    ${接口入参}    #将python对象编码成Json字符串
    log    ${接口入参}
    #选择后缀地址
    ${后缀}    Run Keyword If    '${接口中文名称}'!='${EMPTY}' and '${接口类型}'=='Stk'    set variable    ${API地址["金证api接口后缀"]}
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
    ${resp}    POST On Session    自定义POST请求    ${后缀}    data=${接口入参}
    #格式处理
    ${resp}    set variable    ${resp.json()}
    log    ${resp}
    [Return]    ${resp}

数据库链接
    [Arguments]    ${接口类型}=${接口类型_全局变量}    ${数据库信息}=${数据库信息_全局变量}
    #数据库链接
    #SQL
    Comment    win版连接    Run Keyword If    '${接口类型}'=='Stk'    Connect To Database Using Custom Params    pyodbc    "Driver={SQL Server};${数据库信息}"
    Comment    linux版连接    Run Keyword If    '${接口类型}'=='Stk'    Connect To Database Using Custom Params    pyodbc    "Driver={ODBC Driver 11 for SQL Server};${数据库信息}"
    ${xt}    Evaluate    sys.platform    sys
    ${driver}    Set Variable IF    '${xt}'=='win32'    SQL Server    ODBC Driver 11 for SQL Server
    Run Keyword If    '${接口类型}'=='Stk'    Connect To Database Using Custom Params    pyodbc    "Driver={${driver}};${数据库信息}"
    #Oracel数据库连接_基准数据存储
    Run Keyword If    '${接口类型}'=='${EMPTY}'    Connect To Database Using Custom Params    cx_Oracle    'auto','auto','(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=10.171.9.18)(PORT=1521)))(CONNECT_DATA=(SERVICE_NAME=testdb)))'

GET获取返回数据_华锐API
    [Arguments]    ${用户系统消息序号}
    #获取数据
    Comment    ${接口入参}    Create Dictionary    client_seq_id=${用户系统消息序号}
    FOR    ${i}    IN RANGE    10
        ${resp}    GET环境请求_UTP    client_seq_id=${用户系统消息序号}
        Run Keyword And Return Status    Run Keyword If    '${resp["reason"]}'=='None'    SLEEP    0.25
        Run Keyword And Return Status    Continue For Loop IF    '${resp["reason"]}'=='None'
        ${keys}    ${values}    ${reason}    类似字典类的字符串转换为字典    ${resp["reason"]}
        Run Keyword And Return Status    Exit For Loop If    '${reason["err_msg"]}'=='成功'
    END
    log    ${resp}
    log    ${resp["ans"]}
    FOR    ${i}    IN    ${resp["ans"]}
        log    ${i}
    END
    log    ${resp["ack"]}
    #${resp["ans"]}    Replace String    ${resp["ans"]}    ${SPACE}    ${EMPTY}
    log    ${resp["ans"]}
    #${resp["ans"]}    Replace String    ${resp["ans"]}    \\n    ${EMPTY}
    #判断正常单是否因环境问题导致下单错误
    ${keys}    ${values}    ${返回数据}    类似字典类的字符串转换为字典    ${resp["ack"]}
    ${ord_status}    Run Keyword If    '${resp["business_name"]}' in ('集中竞价交易委托函数','债券转股回售业务委托函数','配售业务委托函数','质押式回购集中竞价业务委托函数','ETF申赎业务委托函数','网上发行业务委托函数','盘后定价(科创板、创业板)业务委托函数')    Set Variable    ${返回数据["ord_status"]}
    Run Keyword If    '${resp["business_name"]}' in ('集中竞价交易委托函数','债券转股回售业务委托函数','配售业务委托函数','质押式回购集中竞价业务委托函数','ETF申赎业务委托函数','网上发行业务委托函数','盘后定价(科创板、创业板)业务委托函数','用户登录') and '${订单状态_全局变量}' not in ('废单')    Should Not Be Equal As Strings    ${ord_status}    8    ${订单状态_全局变量}用例订单状态为已拒绝，请检查环境！！
    #已申报和已拒绝不写ans
    ${数据}    Run Keyword If    '${resp["business_name"]}' in ('集中竞价交易委托函数','债券转股回售业务委托函数','配售业务委托函数','质押式回购集中竞价业务委托函数','ETF申赎业务委托函数','网上发行业务委托函数','盘后定价(科创板、创业板)业务委托函数','用户登录')    Set Variable    ${resp["ack"]}
    ...    ELSE    Set Variable    ${resp["ans"]}
    sleep    2
    ${keys}    ${values}    ${返回数据}    类似字典类的字符串转换为字典    ${数据}
    log    ${返回数据}
    ${返回码}    Set Variable    ${reason["err_code"]}
    [Return]    ${返回码}    ${返回数据}

GET获取返回数据_华锐API00
    [Arguments]    ${用户系统消息序号}
    #获取数据
    Comment    ${接口入参}    Create Dictionary    client_seq_id=${用户系统消息序号}
    FOR    ${i}    IN RANGE    10
        ${resp}    GET环境请求_UTP    client_seq_id=${用户系统消息序号}
        Run Keyword And Return Status    Run Keyword If    '${resp["reason"]}'=='None'    SLEEP    0.25
        Run Keyword And Return Status    Continue For Loop IF    '${resp["reason"]}'=='None'
        ${keys}    ${values}    ${reason}    类似字典类的字符串转换为字典    ${resp["reason"]}
        Run Keyword And Return Status    Exit For Loop If    '${reason["err_msg"]}'=='成功'
    END
    log    ${resp}
    log    ${resp["ack"]}
    log    ${resp["ans"]}
    #判断正常单是否因环境问题导致下单错误
    ${keys}    ${values}    ${返回数据}    类似字典类的字符串转换为字典    ${resp["ack"]}
    ${ord_status}    Run Keyword If    '${resp["business_name"]}' in ('集中竞价交易委托函数','债券转股回售业务委托函数','配售业务委托函数','质押式回购集中竞价业务委托函数','ETF申赎业务委托函数','网上发行业务委托函数','盘后定价(科创板、创业板)业务委托函数')    Set Variable    ${返回数据["ord_status"]}
    Run Keyword If    '${resp["business_name"]}' in ('集中竞价交易委托函数','债券转股回售业务委托函数','配售业务委托函数','质押式回购集中竞价业务委托函数','ETF申赎业务委托函数','网上发行业务委托函数','盘后定价(科创板、创业板)业务委托函数') and '${订单状态_全局变量}' not in ('废单')    Should Not Be Equal As Strings    ${ord_status}    8    ${订单状态_全局变量}用例订单状态为已拒绝，请检查环境！！
    #已申报和已拒绝不写ans
    ${数据}    Run Keyword If    '${resp["business_name"]}' in ('集中竞价交易委托函数','债券转股回售业务委托函数','配售业务委托函数','质押式回购集中竞价业务委托函数','ETF申赎业务委托函数','网上发行业务委托函数','盘后定价(科创板、创业板)业务委托函数') and '${订单状态_全局变量}' in ('已报','废单','全撤')    Set Variable    ${resp["ack"]}
    ...    ELSE    Set Variable    ${resp["ans"]}
    sleep    2
    ${keys}    ${values}    ${返回数据}    类似字典类的字符串转换为字典    ${数据}
    log    ${返回数据}
    ${返回码}    Set Variable    ${reason["err_code"]}
    [Return]    ${返回码}    ${返回数据}

Retry Request
    [Arguments]    ${后缀}    ${接口入参}
    Sleep    5
    FOR    ${i}    IN RANGE    10
        ${result}    ${resp}    Run Keyword And Ignore Error    POST On Session    自定义POST请求    ${后缀}    data=${接口入参}
        LOG    ${resp}
        Run Keyword And Return Status    Run Keyword If    '${resp}'=='None'    SLEEP    5
        Run Keyword And Return Status    Continue For Loop IF    '${resp}'=='None'
        Run Keyword And Return Status    Exit For Loop If    '${resp}'!='None'
    END
    LOG    ${resp}
    [Return]    ${resp}
